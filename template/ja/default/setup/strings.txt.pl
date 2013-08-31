# The contents of this file are subject to the Mozilla Public
# License Version 1.1 (the "License"); you may not use this file
# except in compliance with the License. You may obtain a copy of
# the License at http://www.mozilla.org/MPL/
#
# Software distributed under the License is distributed on an "AS
# IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
# implied. See the License for the specific language governing
# rights and limitations under the License.
#
# The Initial Developer of the Original Code is Everything Solved.
# Portions created by Everything Solved are Copyright (C) 2007
# Everything Solved. All Rights Reserved.
#
# The Original Code is the Bugzilla Bug Tracking System.
#
# Contributor(s): Max Kanat-Alexander <mkanat@bugzilla.org>

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
    blacklisted => '(ブラックリスト対象)',
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
(*必ず*これらすべてのコマンドを実行後、このスクリプトを再実行してください)
EOT
    done => '完了',

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
    feature_jsonrpc_faster    => 'JSON-RPC の高速化',
    feature_new_charts        => '新形式のチャート',
    feature_old_charts        => '旧形式のチャート',
    feature_mod_perl          => 'mod_perl',
    feature_moving            => 'サイト間バグ移動',
    feature_patch_viewer      => 'パッチビューア',
    feature_rand_security     => 'クッキーとトークンのセキュリティーの改善',
    feature_smtp_auth         => 'SMTP 認証でのメール送信',
    feature_updates           => 'システム更新通知',
    feature_xmlrpc            => 'XML-RPC インターフェース',

    file_remove => '##name## を削除中...',
    file_rename => '##from## から ##to## に名前変更中...',
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
    no_such_module => "CPAN で ##module## というモジュールが見つかりません。",
    template_precompile   => "テンプレートの事前コンパイル中...",
    template_removal_failed => <<END,
警告: ディレクトリ '##datadir##/template' を削除できません。
      '##datadir##/deleteme' に移動させましたので、ディスクスペースの
      節約のためには手動で削除してください。
END
    template_removing_dir => "既存のコンパイル済テンプレートを削除中...",
);

1;
