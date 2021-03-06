# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This Source Code Form is "Incompatible With Secondary Licenses", as
# defined by the Mozilla Public License, v. 2.0.

package Bugzilla::Mailer;

use 5.10.1;
use strict;
use warnings;

use parent qw(Exporter);
@Bugzilla::Mailer::EXPORT = qw(MessageToMTA build_thread_marker);

use Bugzilla::Constants;
use Bugzilla::Error;
use Bugzilla::Hook;
use Bugzilla::Util;

use Date::Format qw(time2str);

use Encode qw(encode);
use Encode::MIME::Header;
use Email::MIME;
use Email::Sender::Simple qw(sendmail);
use Email::Sender::Transport::SMTP::Persistent;
use Bugzilla::Sender::Transport::Sendmail;

sub MessageToMTA {
    my ($msg, $send_now) = (@_);
    my $method = Bugzilla->params->{'mail_delivery_method'};
    return if $method eq 'None';

    if (Bugzilla->params->{'use_mailer_queue'}
        && ! $send_now
        && ! Bugzilla->dbh->bz_in_transaction()
    ) {
        Bugzilla->job_queue->insert('send_mail', { msg => $msg });
        return;
    }

    my $dbh = Bugzilla->dbh;

    my $email;
    if (ref $msg) {
        $email = $msg;
    }
    else {
        # RFC 2822 requires us to have CRLF for our line endings and
        # Email::MIME doesn't do this for us. We use \015 (CR) and \012 (LF)
        # directly because Perl translates "\n" depending on what platform
        # you're running on. See http://perldoc.perl.org/perlport.html#Newlines
        $msg =~ s/(?:\015+)?\012/\015\012/msg;
        $email = new Email::MIME($msg);
    }

    # If we're called from within a transaction, we don't want to send the
    # email immediately, in case the transaction is rolled back. Instead we
    # insert it into the mail_staging table, and bz_commit_transaction calls
    # send_staged_mail() after the transaction is committed.
    if (! $send_now && $dbh->bz_in_transaction()) {
        # The e-mail string may contain tainted values.
        my $string = $email->as_string;
        trick_taint($string);
        $dbh->do("INSERT INTO mail_staging (message) VALUES(?)", undef, $string);
        return;
    }

    # Ensure that we are not sending emails too quickly to recipients.
    if (Bugzilla->params->{use_mailer_queue}
        && (EMAIL_LIMIT_PER_MINUTE || EMAIL_LIMIT_PER_HOUR))
    {
        $dbh->do(
            "DELETE FROM email_rates WHERE message_ts < "
            . $dbh->sql_date_math('LOCALTIMESTAMP(0)', '-', '1', 'HOUR'));

        my $recipient = $email->header('To');

        if (EMAIL_LIMIT_PER_MINUTE) {
            my $minute_rate = $dbh->selectrow_array(
                "SELECT COUNT(*)
                   FROM email_rates
                  WHERE recipient = ?  AND message_ts >= "
                        . $dbh->sql_date_math('LOCALTIMESTAMP(0)', '-', '1', 'MINUTE'),
                undef,
                $recipient);
            if ($minute_rate >= EMAIL_LIMIT_PER_MINUTE) {
                die EMAIL_LIMIT_EXCEPTION;
            }
        }
        if (EMAIL_LIMIT_PER_HOUR) {
            my $hour_rate = $dbh->selectrow_array(
                "SELECT COUNT(*)
                   FROM email_rates
                  WHERE recipient = ?  AND message_ts >= "
                        . $dbh->sql_date_math('LOCALTIMESTAMP(0)', '-', '1', 'HOUR'),
                undef,
                $recipient);
            if ($hour_rate >= EMAIL_LIMIT_PER_HOUR) {
                die EMAIL_LIMIT_EXCEPTION;
            }
        }
    }

    # We add this header to uniquely identify all email that we
    # send as coming from this Bugzilla installation.
    #
    # We don't use correct_urlbase, because we want this URL to
    # *always* be the same for this Bugzilla, in every email,
    # even if the admin changes the "ssl_redirect" parameter some day.
    $email->header_set('X-Bugzilla-URL', Bugzilla->params->{'urlbase'});

    # We add this header to mark the mail as "auto-generated" and
    # thus to hopefully avoid auto replies.
    $email->header_set('Auto-Submitted', 'auto-generated');

    # MIME-Version must be set otherwise some mailsystems ignore the charset
    $email->header_set('MIME-Version', '1.0') if !$email->header('MIME-Version');

    # Encode the headers correctly in quoted-printable
    foreach my $header ($email->header_names) {
        my @values = $email->header($header);
        # We don't recode headers that happen multiple times.
        next if scalar(@values) > 1;
        if (my $value = $values[0]) {
            if (Bugzilla->params->{'utf8'} && !utf8::is_utf8($value)) {
                utf8::decode($value);
            }

            # avoid excessive line wrapping done by Encode.
            local $Encode::Encoding{'MIME-Q'}->{'bpl'} = 998;

            my $encoded = encode('MIME-Q', $value);
            $email->header_set($header, $encoded);
        }
    }

    my $from = $email->header('From');

    my $hostname;
    my $transport;
    if ($method eq "Sendmail") {
        if (ON_WINDOWS) {
            $transport = Bugzilla::Sender::Transport::Sendmail->new({ sendmail => SENDMAIL_EXE });
        }
        else {
            $transport = Bugzilla::Sender::Transport::Sendmail->new();
        }
    }
    else {
        # Sendmail will automatically append our hostname to the From
        # address, but other mailers won't.
        my $urlbase = Bugzilla->params->{'urlbase'};
        $urlbase =~ m|//([^:/]+)[:/]?|;
        $hostname = $1;
        $from .= "\@$hostname" if $from !~ /@/;
        $email->header_set('From', $from);
        
        # Sendmail adds a Date: header also, but others may not.
        if (!defined $email->header('Date')) {
            $email->header_set('Date', time2str("%a, %d %b %Y %T %z", time()));
        }
    }

    if ($method eq "SMTP") {
        my ($host, $port) = split(/:/, Bugzilla->params->{'smtpserver'}, 2);
        $transport = Bugzilla->request_cache->{smtp} //=
          Email::Sender::Transport::SMTP::Persistent->new({
            host  => $host,
            defined($port) ? (port => $port) : (),
            sasl_username => Bugzilla->params->{'smtp_username'},
            sasl_password => Bugzilla->params->{'smtp_password'},
            helo => $hostname,
            ssl => Bugzilla->params->{'smtp_ssl'},
            debug => Bugzilla->params->{'smtp_debug'} });
    }

    Bugzilla::Hook::process('mailer_before_send', { email => $email });

    return if $email->header('to') eq '';

    $email->walk_parts(sub {
        my ($part) = @_;
        return if $part->parts > 1; # Top-level
        my $content_type = $part->content_type || '';
        $content_type =~ /charset=['"](.+)['"]/;
        # If no charset is defined or is the default us-ascii,
        # then we encode the email to UTF-8 if Bugzilla has utf8 enabled.
        # XXX - This is a hack to workaround bug 723944.
        if (!$1 || $1 eq 'us-ascii') {
            my $body = $part->body;
            if (Bugzilla->params->{'utf8'}) {
                $part->charset_set('UTF-8');
                # encoding_set works only with bytes, not with utf8 strings.
                my $raw = $part->body_raw;
                if (utf8::is_utf8($raw)) {
                    utf8::encode($raw);
                    $part->body_set($raw);
                }
            }
            $part->encoding_set('quoted-printable') if !is_7bit_clean($body);
        }
    });

    if ($method eq "Test") {
        my $filename = bz_locations()->{'datadir'} . '/mailer.testfile';
        open TESTFILE, '>>', $filename;
        # From - <date> is required to be a valid mbox file.
        print TESTFILE "\n\nFrom - " . $email->header('Date') . "\n" . $email->as_string;
        close TESTFILE;
    }
    else {
        # This is useful for Sendmail, so we put it out here.
        local $ENV{PATH} = SENDMAIL_PATH;
        eval { sendmail($email, { transport => $transport }) };
        if ($@) {
            ThrowCodeError('mail_send_error', { msg => $@->message, mail => $email });
        }
    }

    # insert into email_rates
    if (Bugzilla->params->{use_mailer_queue}
        && (EMAIL_LIMIT_PER_MINUTE || EMAIL_LIMIT_PER_HOUR))
    {
        $dbh->do(
            "INSERT INTO email_rates(recipient, message_ts) VALUES (?, LOCALTIMESTAMP(0))",
            undef,
            $email->header('To')
        );
    }
}

# Builds header suitable for use as a threading marker in email notifications
sub build_thread_marker {
    my ($bug_id, $user_id, $is_new) = @_;

    if (!defined $user_id) {
        $user_id = Bugzilla->user->id;
    }

    my $sitespec = '@' . Bugzilla->params->{'urlbase'};
    $sitespec =~ s/:\/\//\./; # Make the protocol look like part of the domain
    $sitespec =~ s/^([^:\/]+):(\d+)/$1/; # Remove a port number, to relocate
    if ($2) {
        $sitespec = "-$2$sitespec"; # Put the port number back in, before the '@'
    }

    my $threadingmarker;
    if ($is_new) {
        $threadingmarker = "Message-ID: <bug-$bug_id-$user_id$sitespec>";
    }
    else {
        my $rand_bits = generate_random_password(10);
        $threadingmarker = "Message-ID: <bug-$bug_id-$user_id-$rand_bits$sitespec>" .
                           "\nIn-Reply-To: <bug-$bug_id-$user_id$sitespec>" .
                           "\nReferences: <bug-$bug_id-$user_id$sitespec>";
    }

    return $threadingmarker;
}

sub send_staged_mail {
    my $dbh = Bugzilla->dbh;
    my @ids;
    my $emails
        = $dbh->selectall_arrayref("SELECT id, message FROM mail_staging");

    foreach my $row (@$emails) {
        MessageToMTA($row->[1]);
        push(@ids, $row->[0]);
    }

    if (@ids) {
        $dbh->do("DELETE FROM mail_staging WHERE " . $dbh->sql_in('id', \@ids));
    }
}

1;

__END__

=head1 NAME

Bugzilla::Mailer - Provides methods for sending email

=head1 METHODS

=over

=item C<MessageToMTA>

Sends the passed message to the mail transfer agent.

The actual behaviour depends on a number of factors: if called from within a
database transaction, the message will be staged and sent when the transaction
is committed.  If email queueing is enabled, the message will be sent to
TheSchwartz job queue where it will be processed by the jobqueue daemon, else
the message is sent immediately.

=item C<build_thread_marker>

Builds header suitable for use as a threading marker in email notifications.

=item C<send_staged_mail>

Sends all staged messages -- called after a database transaction is committed.

=back
