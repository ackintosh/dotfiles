# fzf
set -U FZF_LEGACY_KEYBINDINGS 0

# python3 installed via homebrew
if test -d /usr/local/opt/python/libexec/bin
  set PATH /usr/local/opt/python/libexec/bin $PATH
end
# nodejs installed via nodebrew
if test -d ~/.nodebrew/current/bin
  set PATH ~/.nodebrew/current/bin $PATH
end

# Cargo
if test -e ~/.cargo
  source ~/.cargo/env
end

# tools installed via `go install`
if test -d ~/go/bin
  set PATH $PATH ~/go/bin
end

# Go
# http://qiita.com/methane/items/d82b9f28b97b5c3bd08a
# http://d.hatena.ne.jp/hiro_nemu/20140113/1389620004
if which -s go
  set GOROOT (go env GOROOT)
  set GOPATH $HOME
  set PATH $PATH:$GOROOT/bin:$GOPATH/bin:/usr/local/opt/go/libexec/bin
end

# direnv
# https://github.com/direnv/direnv
if which -s direnv
  eval (direnv hook fish)
end

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/google-cloud-sdk/path.fish.inc ]; if type source > /dev/null; source ~/google-cloud-sdk/path.fish.inc; else; . ~/google-cloud-sdk/path.fish.inc; end; end

if test -e ~/.additional_config.fish
  source ~/.additional_config.fish
end
