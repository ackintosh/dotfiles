# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="geoffgarside"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# zsh で Git の作業コピーに変更があるかどうかをプロンプトに表示する
# http://mollifier.hatenablog.com/entry/20100906/p1
autoload -Uz add-zsh-hook
autoload -Uz colors
colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  # この check-for-changes が今回の設定するところ
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
  zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
  zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
fi

function _update_vcs_info_msg() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{green}%1v%f|)"

setopt nonomatch

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Sublime Text
alias st="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"

# PHPUnit
alias phpunit="/Applications/MAMP/bin/php/php5.3.6/bin/phpunit"

# PHP5.2
alias php5.2="/Applications/MAMP/bin/php/php5.2.17/bin/php"

# PHP5.4
alias php5.4="/usr/local/php5/bin/php"

# PHP5.5
# http://kimikimi714.hatenablog.com/entry/2013/07/06/233518
export PATH="/usr/local/php5/bin/:$PATH"

# lightline.vim
export TERM=xterm-256color

# ctags
# Exuberant Ctags is installed by the following command.
# $ brew install ctags
alias ctags="`brew --prefix`/bin/ctags"

# MySQL in MAMP
alias mysql_mamp="/Applications/MAMP/Library/bin/mysql"

# vagrant-digitalocean
# https://github.com/smdahlen/vagrant-digitalocean#install
# export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

# Go
# http://qiita.com/methane/items/d82b9f28b97b5c3bd08a
# http://d.hatena.ne.jp/hiro_nemu/20140113/1389620004
if [ -x "`which go`" ]; then
  export GOROOT=`go env GOROOT`
  export GOPATH=$HOME
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# Scala
# conscript
export PATH="$PATH:$HOME/bin"

# AWS
# Auto Scaling Command Line Tool
# http://aws.amazon.com/developertools/2535
# export PATH="$PATH:$HOME/bin/aws/bin"
# export AWS_AUTO_SCALING_HOME="$HOME/bin/aws"

# Docker
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/Ack/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

