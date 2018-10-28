ackintosh/dotfiles

TODO: コマンド一発でシュッとインストールされるようにする

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

#### f.lux

* https://justgetflux.com/
* 画面のブルーライトをカットするアプリ

#### GIPHY

* 画面をキャプチャしてgitアニメーションを作る
* https://itunes.apple.com/jp/app/giphy-capture-the-gif-maker/id668208984?mt=12

#### App Cleaner & Uninstaller

* アプリケーションフォルダから削除しただけでは残ってしまうゴミを削除できる
* https://itunes.apple.com/jp/app/app-cleaner-uninstaller/id1013897218?mt=12

#### spectacle

* ウィンドウの移動, リサイズ
* https://www.spectacleapp.com/

#### homebrew

パッケージマネージャー
* http://brew.sh/index_ja.html

#### tmux

* `brew install tmux`
* tmuxとOS Xのクリップボードの橋渡しをするツールを入れる
  * `brew install reattach-to-user-namespace`

#### git

* `brew install git`
* git コミットメッセージの文字化け防止  
  * `git config --global core.editor '/usr/local/bin/vim -c "set fenc=utf-8"'`
* 個人の環境特有の除外設定
  * `git config --global core.excludesfile ~/.gitignore_global`
  * dotfilesの設定ファイルを使う
    * `cd ~ && mv .gitignore_global .gitignore_global.default && ln -s ~/src/github.com/ackintosh/dotfiles/.gitignore_global .gitignore_global`
    * `git config --global core.excludesfile ~/.gitignore_global`
  * [gitignore に書くべきでないものは gitignore_global へ - Qiita](https://qiita.com/elzup/items/4c92a2abdab56db3fb4e)

#### git showpr

* Commit Hash から該当 Pull Request を見つける
* http://qiita.com/awakia/items/f14dc6310e469964a8f7

```
$ git showpr daced1d3
5bf98dd Merge pull request #12856 from duglin/ConfigLocation
```

* .gitconfig

```
[alias]
  showpr = !"f() { git log --merges --oneline --reverse --ancestry-path $1...master | grep 'Merge pull request #' | head -n 1; }; f"
```

* シェルから設定する場合

```
git config --global alias.showpr \!"f() { git log --merges --oneline --reverse --ancestry-path \$1...master | grep 'Merge pull request #' | head -n 1; }; f"
```

#### rbenv

* https://github.com/rbenv/rbenv

#### go

* http://golang-jp.org/doc/install
* `brew install go`
* ghq
  * `brew install ghq`
  * `git config --global ghq.root ~/src`
* peco
  * `brew install peco`
* files
  * `go get github.com/mattn/files`
* pt
  * http://blog.monochromegane.com/blog/2014/01/16/the-platinum-searcher/
  * `brew install pt`

#### direnv

* `brew install direnv`

#### vim 7.4 or above

* http://qiita.com/yu-ichiro/items/c9db44671701e7f485af
* `brew install vim --with-lua`
* php
	* 辞書ファイルの更新
		* $ `php dict.php > .vim/dictionaries/php.dict`
* go
	* goimports
		* `go get code.google.com/p/go.tools/cmd/goimports`
	* gotags
		* `go get -u github.com/jstemmer/gotags`

	* phpmd
		* `curl -L -o ~/.vim/commands/phpmd.phar http://static.phpmd.org/php/latest/phpmd.phar`

#### Intellij IDEA

* Solarized Colorscheme for IntelliJ IDEA
  * https://github.com/jkaving/intellij-colors-solarized


#### pt

* http://blog.monochromegane.com/blog/2014/01/16/the-platinum-searcher/
* `brew install pt`

#### htop

* https://github.com/hishamhm/htop
* brew install htop

####  GNU GLOBAL

* http://qiita.com/yoshizow/items/9cc0236ac0249e0638ff
* インストール
	* `brew install global --with-exuberant-ctags --with-pygments`
* gtags
	* タグを作成
	* `gtags --gtagslabel=pygments -v`

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

#### Keyboardio

* レイアウト定義ファイル: KeyboardioModel01-Firmware.ino
* wiki
  * https://github.com/keyboardio/Kaleidoscope/wiki/Install-Arduino-support-on-a-Mac

#### Chrome 拡張

- [Stylus](https://chrome.google.com/webstore/detail/stylish-custom-themes-for/fjnbnpbmkenffdnngjfgmeleoegfcffe?hl=ja)
- [Copy URL+](https://chrome.google.com/webstore/detail/copy-url%20/capojgaalppngkaagaobmigigcgnidmn?hl=ja)
  - `Shift+V` : `${title}${n}${URL}`
