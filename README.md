ackintosh/dotfiles

### iterm2

ターミナルソフト
* https://www.iterm2.com/

#### command + w を押してもすぐに閉じないようにする
Preference -> Profiles -> Session -> Closing
`Always prompt before closing` を選択する

--


### homebrew

パッケージマネージャー
* http://brew.sh/index_ja.html

--

### tmux

* `brew install tmux`
* tmuxとOS Xのクリップボードの橋渡しをする  
```
brew install reattach-to-user-namespace
```

--

### git

* `brew install git`
* git コミットメッセージの文字化け防止  
`git config --global core.editor '/usr/local/bin/vim -c "set fenc=utf-8"'`

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

--

### rbenv

* https://github.com/rbenv/rbenv

--

### go

* http://golang-jp.org/doc/install
* `brew install go`

--

### ghq

* `go get github.com/motemen/ghq`
* `git config --global ghq.root ~/src`

--

### peco

* `go get github.com/peco/peco/cmd/peco`

--

### files

* `go get github.com/mattn/files`

--

### sshrc

* https://github.com/Russell91/sshrc

--

### vim 7.4 or above

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

--

### pt

* http://blog.monochromegane.com/blog/2014/01/16/the-platinum-searcher/
* `brew install pt`

--

###  GNU GLOBAL

* http://qiita.com/yoshizow/items/9cc0236ac0249e0638ff
* インストール
	* `brew install global --with-exuberant-ctags --with-pygments`
* gtags
	* タグを作成
	* `gtags --gtagslabel=pygments -v`

--

### VirtualBox

* https://www.virtualbox.org/

--

### Vagrant

* https://www.vagrantup.com/

--

### KeyRemap4MacBook(現Karabiner)

* http://pqrs.org/macosx/keyremap4macbook/index.html.ja
* 左右のCommandキーに「英数」と「かな」を割り当て
* Macの環境設定でCaps Lockキーの動作をControlキーに変更

--

### Alfred

* https://www.alfredapp.com/

--

### f.lux

* https://justgetflux.com/
* 画面のブルーライトをカットするアプリ

--

### Ergodox EZ

* レイアウト(閲覧にはログインが必要)
* https://www.massdrop.com/configurator/ergodox?referer=QKNF2S&hash=f845a48d2539881741e562e719370157

