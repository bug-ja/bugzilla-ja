# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This Source Code Form is "Incompatible With Secondary Licenses", as
# defined by the Mozilla Public License, v. 2.0.

# This file contains a single hash named %strings, which is used by the
# installation code to display strings before Template-Toolkit can safely
# be loaded.
#
# Each string supports a very simple substitution system, where you can
# have variables named like ##this## and they'll be replaced by the string
# variable with that name.
#
# Please keep the strings in alphabetical order by their name.

%strings = (
    any  => '指定なし',
    apachectl_failed => <<END,
警告: Apache の設定を検証できませんでした。これは checksetup.pl を
##root## 以外で実行している場合に起こりえます。問題の詳細については
##command## を実行してください。
END
    bad_executable => '有効な実行ファイルでありません: ##bin##',
    blacklisted => '(ブラックリスト対象)',
    bz_schema_exists_before_220 => <<'END',
2.20 以前からアップグレードしようとしていますが、bz_schema テーブルがすでに
存在しています。これは、ある時点で、既存の Bugzilla データベースをドロップせ
ずに、データを mysqldump でデータベースにレストアしたことを意味するでしょう。
バックアップから Bugzilla のデータベースをレストアする際は、必ずすべてのデー
タをドロップしてから行ってください。

まず、あなたの Bugzilla のデータベースをドロップしてから、bz_schema テーブル
を含まないバックアップよりレストアしてください。何らかの理由でこの操作ができ
ない場合、上のレポートのように、MySQL データベースに接続して bz_schema テー
ブルを削除してください。
END
    checking_for => '確認中 : ',
    checking_dbd      => '既存の perl DBD モジュールを確認中...',
    checking_optional => '以下は任意の Perl モジュールです :',
    checking_modules  => 'Perl モジュールを確認中...',
    chmod_failed      => '##path##: 権限変更に失敗しました: ##error##',
    chown_failed      => '##path##: 所有者変更に失敗しました: ##error##',
    commands_dbd      => <<EOT,
必ず次のうちのひとつのコマンドを実行してください
(どのコマンドかはどのデータベースを利用しているかによります)
EOT
    commands_optional => 'オプションのモジュールをインストールするためのコマンド:',
    commands_required => <<EOT,
必須モジュールをインストールするためのコマンド
(*必ず*これらすべてのコマンドを実行後、checksetup.pl を再実行してください)
EOT
    continue_without_answers => <<'END',
インタラクティブモードで ('answers' ファイルなしで) checksetup.pl を再実行し
て続けてください。
END
    cpan_bugzilla_home => 
        "警告: Bugzilla ディレクトリを CPAN のホームディレクトリとして利用します。",
    db_enum_setup  => "標準的なドロップダウンフィールドを表示する準備中です:",
    db_schema_init => "bz_schema初期化中...",
    db_table_new   => "新規テーブル ##table## 追加中...",
    db_table_setup => "テーブル作成中...",
    done => '完了',
    enter_or_ctrl_c => "続行するにはエンターを、終了するには Ctrl-C を押してください。",
    error_localconfig_read => <<'END',
##localconfig## ファイルを読み込み中にエラーが発生しました。エラーメッセージ
は以下のものです。

##error##

localconfig ファイルを修正してください。もしくは、現在の localconfig ファイル
の名前を変更して、checksetup.pl を再実行して新しい localconfig ファイルを作成
してください。

  $ mv -f localconfig localconfig.old
  $ ./checksetup.pl
END
    extension_must_return_name => <<END,
##file## は ##returned## という拡張名には有効でない名前を返しました。
拡張は、<code>1</code> や数字ではなく、必ずその名前を返す必要があります。
詳細は、Bugzilla::Extension のドキュメントを参照してください。
END
    feature_auth_ldap         => 'LDAP 認証',
    feature_auth_radius       => 'RADIUS 認証',
    feature_graphical_reports => 'グラフレポート',
    feature_html_desc         => 'プロダクト・グループ説明での追加の HTML',
    feature_inbound_email     => 'システム向け Email',
    feature_jobqueue          => 'メールキュー',
    feature_jsonrpc           => 'JSON-RPC インターフェース',
    feature_new_charts        => '新形式のチャート',
    feature_old_charts        => '旧形式のチャート',
    feature_memcached         => 'Memcached 機能',
    feature_mod_perl          => 'mod_perl',
    feature_moving            => 'サイト間バグ移動',
    feature_patch_viewer      => 'パッチビューア',
    feature_rest              => 'REST インターフェース',
    feature_smtp_auth         => 'SMTP 認証でのメール送信',
    feature_smtp_ssl          => 'SMTP 送信での SSL 利用',
    feature_updates           => 'システム更新通知',
    feature_xmlrpc            => 'XML-RPC インターフェース',
    feature_detect_charset    => 'テキスト添付での自動文字コード検出',
    feature_typesniffer       => '添付の MIME 型を判別',
    feature_markdown          => 'コメントでの Markdown 形式のサポート',

    file_remove => 'ファイル ##name## を削除中...',
    file_rename => 'ファイル名を ##from## から ##to## へ変更中...',
    header => "* これは perl ##perl_ver## で動作中の Bugzilla ##bz_ver## です\n"
            . "* ##os_name## ##os_ver## で起動中です",
    install_all => <<EOT,

全ての必須と任意のモジュールを自動的にインストールしたいならば、
次を実行してください :

  ##perl## install-module.pl --all

EOT
    install_data_too_long => <<EOT,
警告 : ##table##.##column## カラムにあるいくつかのデータが、新しい長さ制限の
##max_length## 文字より長くなっています。修正が必要なデータは以下に、##id_column##
カラムを先頭、次に修正が必要な ##column## カラムの値を出力しています。

EOT
    install_module => '##module## バージョン ##version## をインストール中...',
    installation_failed => '*** インストールが中止されました。上記のメッセージをご覧ください。 ***',
    install_no_compiler => <<END,
エラー: install-module.pl を利用するには gcc のようなコンパイラが必要です。
END
    install_no_make => <<END,
エラー: install-module.pl を利用するには "make" が必要です。
END
    lc_new_vars => <<'END',
このバージョンの Bugzilla ではいくつかの新しい変数が追加されており、ローカル
で設定を変更する必要があるかもしれません。最後の checksetup.pl の実行以来、
次の値が ##localconfig## に追加されました。

##new_vars##

##localconfig## ファイルを編集して、checksetup.pl を再実行し、インストールを
完了させてください。
END
    lc_old_vars => <<'END',
次の値は ##localconfig## で利用されなくなりましたので、##old_file## に移動さ
れました。 ##vars##
END
    localconfig_create_htaccess => <<'END',
ウェブサーバに Apache を利用している場合、Bugzilla で .htaccess ファイルを作
成し、このファイル (localconfig) や他の秘密のファイルをウェブから見られない
ようにすることも可能です。

1 に設定すれば、checksetup.pl は .htaccess ファイルを、ファイルが存在しなけ
れば作成します。

0 に設定すれば、checksetup.pl は .htaccess ファイルを作成しません。
END
    localconfig_db_check => <<'END',
checksetup.pl にデータベース設定を検証させますか？
ある種のデータベースサーバ・Perl モジュール・状況の組み合わせでは、この機能は
正常に動作しませんので、その場合はこの設定を 0 にして checksetup.pl を実行し
てください。
END
    localconfig_db_driver => <<'END',
どの SQL データベースを利用するかの設定です。既定は mysql です。サポートされ
ているデータベースは Bugzilla/DB ディレクトリのリストになります。それぞれの
モジュールが一つのサポートされているデータベースに対応し、モジュール名 (".pm"
より前) がこの項目に設定できる値となります。
END
    localconfig_db_host => <<'END',
データベースサーバが実行されている DNS 名もしくは IP アドレスです。
END
    localconfig_db_name => 
    localconfig_db_name => <<'END',
データベース名です。Oracle ではデータベースの SID です。
SQLite では DB ファイルの名前(もしくはパス)です。
END
    localconfig_db_pass => <<'END',
データベースのパスワードです。通常は、Bugzilla データベース用ユーザのパスワー
ドを設定します。
パスワードにアポストロフィー (') もしくはバックスラッシュ (\) を利用している
場合、'\' でエスケープしてください。(\') もしくは (\\) です。(これらの文字列
を利用しないことが一番簡単です。)
END
    localconfig_db_port => <<'END',
標準的なポート以外でデータベースサーバを実行している場合もあります。その場合、
ここにデータベースサーバのポート番号を設定してください。0 にすると、"既定のポ
ート番号をデータベースサーバへの接続に利用する" を意味します。
END
    localconfig_db_sock => <<'END',
MySQL でのみ有効: MySQL で利用できる unix socket のパスを入力してください。空
白なら、MySQL の既定値が利用されます。通常は既定値を利用するはずです。
END
    localconfig_db_user => "データベースサーバに接続するためのユーザ名。",
    localconfig_db_mysql_ssl_ca_file => <<'END',
信頼されたSSL CA証明書を並べたPEMファイルの場所です。
ファイルはウェブサーバの実行ユーザから読めなければなりません。
END
    localconfig_db_mysql_ssl_ca_path => <<'END',
PEM形式の信頼されたSSL CA証明書がおかれたディレクトリのパスです。
ディレクトリとファイルはウェブサーバの実行ユーザから読めなければなりません。
END
    localconfig_db_mysql_ssl_client_cert => <<'END',
データベースサーバに認証のために送信するPEM形式のクライアントSSL証明書のフルパスです。
ファイルはウェブサーバの実行ユーザから読めなければなりません。
END
    localconfig_db_mysql_ssl_client_key => <<'END',
クライアントSSL証明書に対応した秘密鍵のフルパスです。
ファイルはパスワード保護されていてはならず、ウェブサーバの実行ユーザから読めなければなりません。
END
    localconfig_diffpath => <<'END',
"パッチ間の差異" 機能を利用するには、"diff" コマンドが存在するディレクトリを
設定する必要があります。(パッチビューアのこの機能を利用するときのみ設定する必
要があります。)
END
    localconfig_index_html => <<'END',
ほとんどのウェブサーバでは index.cgi をディレクトリインデックスとして利用する
よう設定できるでしょうし、既定の設定になっているかもしれませんが、あなたのサ
ーバがそうできなければ、index.cgi にリダイレクトするような index.html が必要
となります。$index_html を 1 に設定すると、checksetup.pl が index.html を存在
していなければ作成します。
注意: checksetup.pl は既存のファイルを置き換えませんので、checksetup.pl で作
      成しようとする場合は、index.html が存在しない状態にしておく必要がありま
      す。
END
    localconfig_interdiffbin => <<'END',
"二つのパッチの差分" 機能をパッチビューアで利用したい場合、"interdiff" 実行フ
ァイルへのフルパスを指定する必要があります。
END
    localconfig_site_wide_secret => <<'END',
この秘密鍵はこのインストールで暗号化トークンの作成と検証に利用されます。これ
らのトークンは、Bugzilla のセキュリティー機能の実装で、特定の攻撃から機能を守
るために利用されます。既定ではランダムな文字列が生成されます。この鍵を秘密に
しておくことが重要で、かつそれなりに長いことも必要です。
END
    localconfig_use_suexec => <<'END',
Apache を SuexecUserGroup 環境で実行しているときは 1 にしてください。

ウェブサーバでコントロールパネルソフトウェア (cPanel, Plesk など) を実行して
いる場合や、共用ホスティング環境で Bugzilla を実行している際は、あなたのソフ
トウェアは Apache の SuexecUserGroup 環境にいることが多いです。

Windows 上では、この設定は無視され何もしません。

0 に設定すると、checksetup.pl はファイル権限を通常のウェブサーバ環境に合わせ
て設定します。

1 に設定すると、checksetup.pl はファイル権限を Bugzilla を SuexecUserGroup 環
境で実行するために設定します。
END
    localconfig_webservergroup => <<'END',
ウェブサーバを実行しているグループ名を設定します。通常、Red Hat 系では "apache"
で、Debian/Ubuntu では "www-data" になります。

use_suexec を有効にしているなら、この値はウェブサーバが cgi ファイルを実行す
るグループの名前にすべきです。

Windows 上では、この設定は無視され何もしません。

スクリプトが実行されるグループにアクセス権限がない場合、"" に設定してください。
"" にした場合、いくつかのファイルが読み込み・書き込み可能になりローカルアクセ
スが可能なユーザがいじることができるようになり、Bugzilla は *非常に* 危険な状
態になります。試験的なサイトであり、かつ他の方法でセットアップできない場合に
限り "" に設定するようにしてください。これは警告です！

"" 以外に設定した場合、checksetup.pl を ##root## もしくは指定したグループに属
するユーザで実行する必要があります。
END
    max_allowed_packet => <<EOT,
警告 : max_allowed_packet パラメータを MySQL 設定ファイルに最低 ##needed## 
以上で設定する必要があります。現在の設定値は ##current## です。
MySQL 設定ファイルの [mysqld] セクションに設定できます。
EOT
    min_version_required => "最低必要なバージョン: ",

# Note: When translating these "modules" messages, don't change the formatting
# if possible, because there is hardcoded formatting in 
# Bugzilla::Install::Requirements to match the box formatting.
    modules_message_apache => <<END,
***********************************************************************
* APACHE モジュール                                                   *
***********************************************************************
* 通常、Bugzilla のアップグレードの際、全ての Bugzilla ユーザはブラウ *
* ザキャッシュをクリアする必要があり、しなければ空白が表示されるでし  *
* ょう。Apache 設定 (httpd.conf もしくは apache2.conf など) で必要な  *
* モジュールを読み込んでおけば、Bugzilla のアップグレードの際にもキャ *
* ッシュをクリアする必要はなくなるでしょう。有効にする必要があるモジ  *
* ュールは以下のものです。                                            *
*                                                                     *
END
    modules_message_db => <<EOT,
***********************************************************************
* データベースアクセス                                                *
***********************************************************************
* あなたのデータベースにアクセスするために、Bugzilla は正しい "DBD"   *
* モジュールがインストールされていることを必要としています。以下を    *
* 参照してあなたのデータベースに合致したモジュールがどれであるかを    *
* 確認してインストールしてください。                                  *
EOT
    modules_message_optional => <<EOT,
***********************************************************************
* オプションモジュール                                                *
***********************************************************************
* いくつかの Perl モジュールは Bugzilla では必須ではありませんが、    *
* 最新のバージョンをインストールしておけば、追加機能を利用できるよう  *
* になります。                                                        *
*                                                                     *
* オプションのモジュールでインストールされていないものは、以下に      *
* それが提供する機能とともにリストされています。表の下にそれぞれの    *
* モジュールをインストールするためのコマンドも表示されています。      *
EOT
    modules_message_required => <<EOT,
***********************************************************************
* 必須モジュール                                                      *
***********************************************************************
* Bugzilla はいくつかの Perl モジュールがあなたのシステムに存在しない *
* か、古いバージョンであることを検出しました。                        *
* 以下のコマンドを参考にモジュールをインストールしてください。        *
EOT

    module_found => "検出 v##ver##",
    module_not_found => "非検出",
    module_ok => 'ok',
    module_unknown_version => "バージョン不明を検出",
    no_such_module => "##module## という名前の Perl モジュールは CPAN にありません。",
    mysql_innodb_disabled => <<'END',
あなたの MySQL では InnoDB が無効かされています。
Bugzilla は InnoDB を利用しますので、有効にしてから checksetup.pl を再実行
してください。
END
    mysql_index_renaming => <<'END',
古いインデックスの名前を変えようとしています。作業完了までに想定される時間
は ##minutes## 分です。この操作は開始後に中断できません。キャンセルしたい
場合は、Ctrl-C を今すぐ押してください。 (45 秒待ちます)
END
    mysql_utf8_conversion => <<'END',
警告: テーブルの情報を UTF-8 に変換しようとしています。これにより、Bugzilla 
      は正しく多言語を保存しソートできるようになります。ただし、データベー
      スに UTF-8 以外のデータを挿入している場合、それらのデータはこのプロセ
      スによって *削除* されます。checksetup.pl を継続する前に、UTF-8 以外の
      データを保存している場合 (確信が持てない場合でも)、Ctrl-C を押して
      checksetup.pl を中断し、contrib/recode.pl を実行することで、全てのデー
      タを UTF-8 にしてください。そしてその後再実行してください。この操作は、
      Bugzilla のテーブルでなくても、データベースにある全てのテーブルに影響
      します。

      Bugzilla 2.22 以前のバージョンを利用していた場合は、checksetup.pl をい
      ますぐ止めて、contrib/recode.pl を実行することを *強く* お勧めします。
END
    no_checksetup_from_cgi => <<END,
<!DOCTYPE html>
<html>
  <head>
    <title>checksetup.pl をウェブブラウザから実行することはできません</title>
  </head>

  <body>
    <h1>checksetup.pl をウェブブラウザから実行することはできません</h1>
    <p>
      このスクリプトをウェブブラウザから実行しては <b>なりません</b>。
      Bugzilla のインストールやアップグレードには、このスクリプトを
      (Linux では <kbd>bash</kbd> や <kbd>ssh</kbd> で、Windows では <kbd>cmd.exe</kbd>
      上で) コマンドラインから実行し、表示される指示に従ってください。
    </p>

    <p>
      Bugzilla のインストール方法についてのより詳細は、公式 Bugzilla
      ウェブサイトにある
      <a href="http://www.bugzilla.org/docs/">ドキュメントを読んで</a>
      ください。
    </p>
  </body>
</html>
END
    patchutils_missing => <<'END',
オプション: Bugzilla の '二つのパッチ間の差分' 機能を利用したい場合、以下の
URL から patchutils をインストールしてください。(PatchReader Perl モジュール
を要求します。)

    http://cyberelk.net/tim/software/patchutils/
END
    template_precompile   => "テンプレートの事前コンパイル中...",
    template_removal_failed => <<END,
警告: ディレクトリ '##template_cache##' を削除できません。
      '##deleteme##' に移動させましたので、ディスクスペースの
      節約のためには手動で削除してください。
END
    template_removing_dir => "既存のコンパイル済テンプレートを削除中...",
    update_cf_invalid_name => 
        "カスタムフィールド '##field##' を削除中 - 無効な名前です",
    update_flags_bad_name => <<'END',
"##flag##" はフラグとしては無効な名前です。空白やカンマを含まない名前に
変更してください。
END
    update_nomail_bad => <<'END',
警告: 以下のユーザは ##data##/nomail にリストされていますが、アカウント
が存在していません。これらのユーザ名を ##data##/nomail.bad に移動します。
END
    update_summary_truncate_comment => 
        "要約フィールドの元の値は 255 文字以上ありましたので、アップグレ"
        . "ードの間に短縮されました。"
        . "元の要約は次のものでした。 \n\n##summary##",
    update_summary_truncated => <<'END',
警告: いくつかの 255 文字以上の要約を持つバグがありました。
これらの元の要約をコメントにコピーし、255 文字に短縮しました。対象は以下
の番号です。
END
    update_quips => <<'END',
Quip は外部ファイルでなくデータベースに保存されるようになりました。
##data##/comments に保存されていた quip はデータベースに移動され、ファイ
ルは ##data##/comments.bak に変更されています。全ての quip が移動済みであ
ると確認できれば、このファイルを消して大丈夫です。
END
    update_queries_to_tags => "新しい 'tag' テーブルを追加:",
    webdot_bad_htaccess => <<END,
警告: 依存関係グラフの画像にアクセスできなくなっています。
##dir##/.htaccess ファイルを消し、checksetup.pl を再実行してください。
END
);

1;
