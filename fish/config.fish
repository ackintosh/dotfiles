### fzf ###
# 新キーバインディングを有効にする
# キーバインディングは別途、 .config/fish/functions/fish_user_key_bindings.fish で設定している
set -U FZF_LEGACY_KEYBINDINGS 0

### Python ###
# python3 installed via homebrew
if test -d /usr/local/opt/python/libexec/bin
  set PATH /usr/local/opt/python/libexec/bin $PATH
end

### Node.js ###
# nodejs installed via nodebrew
if test -d ~/.nodebrew/current/bin
  set PATH ~/.nodebrew/current/bin $PATH
end

### Rust ###
# Cargo
if test -e ~/.cargo
  source ~/.cargo/env
end

### Go ###
# tools installed via `go install`
if test -d ~/go/bin
  set PATH $PATH ~/go/bin
end

# http://qiita.com/methane/items/d82b9f28b97b5c3bd08a
# http://d.hatena.ne.jp/hiro_nemu/20140113/1389620004
if which -s go
  set GOROOT (go env GOROOT)
  set GOPATH $HOME
  set PATH $PATH:$GOROOT/bin:$GOPATH/bin:/usr/local/opt/go/libexec/bin
end

### direnv ###
# https://github.com/direnv/direnv
if which -s direnv
  eval (direnv hook fish)
end

### rbenv ###
if which -s rbenv
  # `rbenv init` で出力されたコマンド
  # ----------------------------------------------------------
  # $ rbenv init
  # # Load rbenv automatically by appending
  # # the following to ~/.config/fish/config.fish:
  # 
  # status --is-interactive; and source (rbenv init -|psub)
  # ----------------------------------------------------------
  status --is-interactive; and source (rbenv init -|psub)
  # 動作しない場合は下記を参照する
  # https://github.com/rbenv/rbenv#homebrew-on-macos
  # > 4. Verify that rbenv is properly set up using this rbenv-doctor script:
end

### aliases ###
# baliasを使うことで、通常のコマンドと同じように補完される
balias g 'git'
balias gb 'git branch'
balias gco 'git checkout'
balias gcm 'git checkout master'
balias gs 'git status'
balias ga 'git add'
balias gd 'git diff'
balias gr 'git remote'
balias gc 'git commit -v'
balias gp 'git push'
balias gm 'git merge'
balias gl 'git pull'
balias gf 'git fetch'
balias gfa 'git fetch --all --prune'
balias glg 'git log --stat'
balias l 'ls -lah'
balias ll 'ls -lh'
balias 1 'cd -'
balias 2 'cd -2'
balias vi 'vim'
balias python3 'python'

# キレイなls
if which -s exa
  balias ls 'exa'
end

# イケてるcat
if which -s bat
  balias cat 'bat'
end

# ghコマンドのコマンド補完を設定する
# https://cli.github.com/manual/gh_completion
if which -s gh
  eval (gh completion -s fish)
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/google-cloud-sdk/path.fish.inc ]; if type source > /dev/null; source ~/google-cloud-sdk/path.fish.inc; else; . ~/google-cloud-sdk/path.fish.inc; end; end

### 職場用の設定などを読み込む ###
if test -e ~/.additional_config.fish
  source ~/.additional_config.fish
end
