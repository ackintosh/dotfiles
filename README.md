ackintosh/dotfiles

## setup

- setup/install_homebrew_packages.sh
- setup/install_fish_plugins.sh
- setup/put_symbolic_links.sh

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
  * setup/install_homebrew_packages.sh
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

#### App Cleaner & Uninstaller

* アプリケーションフォルダから削除しただけでは残ってしまうゴミを削除できる
* https://itunes.apple.com/jp/app/app-cleaner-uninstaller/id1013897218?mt=12

#### spectacle

* ウィンドウの移動, リサイズ
* https://www.spectacleapp.com/

## ***env

#### rbenv

* https://github.com/rbenv/rbenv

#### direnv

* `brew install direnv`

## エディタ

#### vim 7.4 or above

* http://qiita.com/yu-ichiro/items/c9db44671701e7f485af
* `brew install vim --with-lua`
* go
  * goimports
    * `go get code.google.com/p/go.tools/cmd/goimports`
  * gotags
    * `go get -u github.com/jstemmer/gotags`

#### Intellij IDEA

* Solarized Colorscheme for IntelliJ IDEA
  * https://github.com/jkaving/intellij-colors-solarized
* Java/Kotlin
  * ワイルドカードでのimportを無効化する
  * https://pleiades.io/help/idea/creating-and-optimizing-imports.html#disable-wildcard-imports

## その他

#### キーボード関係の環境設定

* caps lock に control を割り当てる
  * キーボード -> キーボード -> 修飾キー -> Caps Lock キー のプルダウンで Control を選択する
* スペルの自動変換を OFF
  * キーボード -> ユーザー辞書 -> "英字入力中にスペルを自動変換" のチェックを外す
* スマート引用符を OFF
  * キーボード -> ユーザー辞書 -> "スマート引用符とスマートダッシュを使用" のチェックを外す

#### Ergodox EZ

* レイアウト(閲覧にはログインが必要)
* https://www.massdrop.com/configurator/ergodox?referer=QKNF2S&hash=f845a48d2539881741e562e719370157

![image](https://user-images.githubusercontent.com/1885716/47960233-12543180-e03b-11e8-8b20-2d91cc3e61d7.png)


#### Keyboardio

* レイアウト定義ファイル: KeyboardioModel01-Firmware.ino
* wiki
  * https://github.com/keyboardio/Kaleidoscope/wiki/Install-Arduino-support-on-a-Mac

#### Chrome 拡張

- [Stylus](https://chrome.google.com/webstore/detail/stylish-custom-themes-for/fjnbnpbmkenffdnngjfgmeleoegfcffe?hl=ja)
- [Copy URL+](https://chrome.google.com/webstore/detail/copy-url%20/capojgaalppngkaagaobmigigcgnidmn?hl=ja)
  - `Shift+V` : `${title}${n}${URL}`
  - `Shift+Cmd+V` : `[${title}](${URL})`
