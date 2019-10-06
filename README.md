ackintosh/dotfiles

## setup scripts

- [setup/install_homebrew_packages.sh](https://github.com/ackintosh/dotfiles/blob/master/setup/install_homebrew_packages.sh)
- [setup/install_fish_plugins.sh](https://github.com/ackintosh/dotfiles/blob/master/setup/install_fish_plugins.sh)
- [setup/put_symbolic_links.sh](https://github.com/ackintosh/dotfiles/blob/master/setup/put_symbolic_links.sh)

## シェル

#### homebrew

* http://brew.sh/index_ja.html

#### powerline

* powerline-status
  * `pip install --user powerline-status`
* [powerline-fonts](https://github.com/powerline/fonts)
  * [インストール](https://github.com/powerline/fonts#quick-installation)
  * `git clone https://github.com/powerline/fonts.git --depth=1`
  * `cd fonts`
  * `./install.sh`
  * `cd ..`
  * `rm -rf fonts`
  * iTerm -> Preference -> Text -> "Font" と "Non-ASCII Font" を Source code pro for Powerline に変更する

#### [fish](https://github.com/fish-shell/fish-shell)

* インストール
  * [setup/install_homebrew_packages.sh](https://github.com/ackintosh/dotfiles/blob/master/setup/install_homebrew_packages.sh)
  * shellsにfishを追記
    * `sudo vi /etc/shells `
    * fishのパスを追記 `which fish`
  * デフォルトシェルを変更
    * chsh -s $(which fish)

###### [fisher](https://github.com/jorgebucaran/fisher)

* fishのプラグインマネージャ
* [インストール](https://github.com/jorgebucaran/fisher#installation)

###### fishプラグイン

* setup/install_fish_plugins.sh

#### tmux

* tmuxとOS Xのクリップボードの橋渡しをするツールを入れる
  * `brew install reattach-to-user-namespace`

#### git

  * dotfilesの設定ファイルを使う
    * `cd ~ && mv .gitignore_global .gitignore_global.default && ln -s ~/src/github.com/ackintosh/dotfiles/.gitignore_global .gitignore_global`
    * `git config --global core.excludesfile ~/.gitignore_global`
  * [gitignore に書くべきでないものは gitignore_global へ - Qiita](https://qiita.com/elzup/items/4c92a2abdab56db3fb4e)

###### git config

```bash
# git コミットメッセージの文字化け防止
git config --global core.editor '/usr/local/bin/vim -c "set fenc=utf-8"'

# 個人の環境特有の除外設定
git config --global core.excludesfile ~/.gitignore_global

# キレイなdiff
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

# ghq
git config --global ghq.root ~/src
```

```bash
# 仕事用マシンでOSSにコミットするとき
# サブアカウントとしてgithub.comのアカウントを設定する
git config --local user.name "ackintosh"
git config --local user.email "sora.akatsuki@gmail.com"
```

```bash
# HTTPSでリポジトリアクセスする場合
# - リポジトリの操作時にuser/passwordを尋ねられる
# - 2FAを有効にしているので、passwordにはpersonal access tokenを入れなければならない
# - 毎回入力するのは手間なのでOSXキーチェーンを使う
# see https://help.github.com/articles/accessing-github-using-two-factor-authentication/#using-two-factor-authentication-with-the-command-line
# see https://help.github.com/articles/caching-your-github-password-in-git/

git config --local credential.helper osxkeychain

# その後、初回のpushなどでuser/password(personal access token)を求められる
# それ以降は入力不要になる
```

## アプリ

#### iTerm2

* https://www.iterm2.com/
* 設定メモ
  *  command + w を押してもすぐに閉じないようにする
  * Preference -> Profiles -> Session -> Closing
  * `Always prompt before closing` を選択する
* 設定のエクスポート/インポート
  * https://qiita.com/reoring/items/a0f3d6186efd11c87f1b 
  * このリポジトリの iterm2 ディレクトリを指定する

#### ⌘英かな

* https://ei-kana.appspot.com/
* コマンドキー単体で英数/かなを切り替える

#### Alfred

* https://www.alfredapp.com/
* アプリ起動: cmd + space
* クリップボード: shift + cmd + space
* スニペットを↓にエクスポートしている
  * https://github.com/ackintosh/dotfiles/tree/master/alfred

#### f.lux

* https://justgetflux.com/
* 画面のブルーライトをカットするアプリ

#### GIPHY

* 画面をキャプチャしてgifアニメーションを作る
* https://itunes.apple.com/jp/app/giphy-capture-the-gif-maker/id668208984?mt=12

#### Skitch

* キャプチャ&加工
* https://apps.apple.com/jp/app/skitch-%E6%92%AE%E3%82%8B-%E6%8F%8F%E3%81%8D%E8%BE%BC%E3%82%80-%E5%85%B1%E6%9C%89%E3%81%99%E3%82%8B/id425955336

#### App Cleaner & Uninstaller

* アプリケーションフォルダから削除しただけでは残ってしまうゴミを削除できる
* https://itunes.apple.com/jp/app/app-cleaner-uninstaller/id1013897218?mt=12

#### spectacle

* ウィンドウの移動, リサイズ
* https://www.spectacleapp.com/

#### Charles

* 通信のモニタリング、シミュレーションなど
* https://www.charlesproxy.com/
* ローカルに起動したアプリケーションと外部サービスとの通信のデバッグなどに便利

## ***env

#### rbenv

* https://github.com/rbenv/rbenv

#### direnv

* `brew install direnv`

## エディタ

#### vim 7.4 or above

* http://qiita.com/yu-ichiro/items/c9db44671701e7f485af
* `brew install vim --with-lua`

#### Intellij IDEA

* Solarized Colorscheme for IntelliJ IDEA
  * https://github.com/jkaving/intellij-colors-solarized
* Java/Kotlin
  * ワイルドカードでのimportを無効化する
  * https://pleiades.io/help/idea/creating-and-optimizing-imports.html#disable-wildcard-imports
* 設定
  * http://kzdev.hatenablog.com/entry/2017/09/03/213423
  * https://github.com/FoxxMD/intellij-jvm-options-explained
  * Help -> Edit Custom VM Options...
  * `-Xms2G`
  * `-Xmx4G`
  * `-XX:MaxInlineLevel=3` [ref](https://youtrack.jetbrains.com/issue/IDEA-207243#focus=streamItem-27-3480124.0-0)
* Font
  * Menlo
  * Size: 11
  * Line spacing: 1.2


## その他

#### キーボード関係の環境設定

* caps lock に control を割り当てる
  * キーボード -> キーボード -> 修飾キー -> Caps Lock キー のプルダウンで Control を選択する
* スペルの自動変換を OFF
  * キーボード -> ユーザー辞書 -> "英字入力中にスペルを自動変換" のチェックを外す
* スマート引用符を OFF
  * キーボード -> ユーザー辞書 -> "スマート引用符とスマートダッシュを使用" のチェックを外す

#### Ergodox EZ

* Gateron Red
* レイアウト(閲覧にはログインが必要)
* https://www.massdrop.com/configurator/ergodox?referer=QKNF2S&hash=f845a48d2539881741e562e719370157

![image](https://user-images.githubusercontent.com/1885716/47960233-12543180-e03b-11e8-8b20-2d91cc3e61d7.png)

* https://www.pjrc.com/teensy/loader_mac.html から Teensy Loader Disk Image (teensy.dmg) をダウンロードする
* massdropのサイトからレイアウトをダウンロードする(.HEX)
* teensy.dmgを起動する
* Ergodox右上の穴を押してプログラムモードにする
* File -> Open Hex File でダウンロードしたHEXファイルを読み込む
* Operation -> Program
* Operation -> Reboot
* 変更が反映されたことを確認する

#### Keyboardio

* レイアウト定義ファイル: KeyboardioModel01-Firmware.ino
* wiki
  * https://github.com/keyboardio/Kaleidoscope/wiki/Install-Arduino-support-on-a-Mac

#### Chrome 拡張

- [Stylus](https://chrome.google.com/webstore/detail/stylish-custom-themes-for/fjnbnpbmkenffdnngjfgmeleoegfcffe?hl=ja)
- [keymapper](https://chrome.google.com/webstore/detail/keymapper/gddmjjinakgblokjagbcehkccngffpdj)
  - `Shift+V` : `[${title}](${URL})`
  - `Shift+Cmd+V` : `[${title} ${URL}]`

#### 簡易メモ帳

- ブラウザのアドレスバーに `data:text/html, <body contenteditable>`
