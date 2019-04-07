# fzf
set -U FZF_LEGACY_KEYBINDINGS 0

# python3 via homebrew
set PATH /usr/local/opt/python/libexec/bin $PATH
# nodejs installed via nodebrew
if test -d ~/.nodebrew/current/bin
  set PATH ~/.nodebrew/current/bin $PATH
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

if test -e ~/.additional_config.fish
  source ~/.additional_config.fish
end
