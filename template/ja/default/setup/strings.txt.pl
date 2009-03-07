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
    blacklisted => '(ブラックリスト対象)',
    checking_for => '確認中 : ',
    checking_dbd      => '既存の perl DBD モジュールを確認中...',
    checking_optional => '以下は任意の Perl モジュールです :',
    checking_modules  => 'Perl モジュールを確認中...',
    done => '完了',
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
    max_allowed_packet => <<EOT,
    警告: あなたの MySQL 設定ファイルの max_allowed_packet パラメータを、
    最低でも ##needed## 煮設定する必要があります。現在この値は、##current## 
    に設定されています。MySQL 設定ファイルの [mysqld] セクションで、
    このパラメータを設定可能です。
EOT
    module_found => "検出 v##ver##",
    module_not_found => "非検出",
    module_ok => 'ok',
    module_unknown_version => "バージョン不明を検出",
    template_precompile   => "テンプレートの事前コンパイル中...",
    template_removing_dir => "既存のコンパイル済テンプレートを削除中...",
);

1;
