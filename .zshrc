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

### git ###
alias gs="git status"
# diff-highlight (git > 2.9)
#   - http://qiita.com/takyam/items/d6afacc7934de9b0e85e
#   - https://github.com/blog/2188-git-2-9-has-been-released
#   - いい感じの色にする
#     - git config --global pager.log 'diff-highlight | less'
#     - git config --global pager.show 'diff-highlight | less'
#     - git config --global pager.diff 'diff-highlight | less'
#   - いい感じの差分にする
#     - git config --global diff.compactionHeuristic true
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

### rbenv ###
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

### direnv ###
eval "$(direnv hook bash)"

### nodebrew
export PATH=${PATH}:${HOME}/.nodebrew/current/bin

### ctags ###
# Exuberant Ctags is installed by the following command.
# $ brew install ctags
alias ctags="`brew --prefix`/bin/ctags"

### Go ###
# http://qiita.com/methane/items/d82b9f28b97b5c3bd08a
# http://d.hatena.ne.jp/hiro_nemu/20140113/1389620004
if [ -x "`which go`" ]; then
  export GOROOT=`go env GOROOT`
  export GOPATH=$HOME
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:/usr/local/opt/go/libexec/bin
fi

### vim ###
alias vi="vim"
# lightline.vim
export TERM=xterm-256color

### peco ###
# ghq
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# history
function peco-select-history() {
    typeset tac
    if which tac > /dev/null; then
        tac=tac
    else
        tac='tail -r'
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# find file
function peco-find-file() {
    if git rev-parse 2> /dev/null; then
        source_files=$(git ls-files)
    else
        source_files=$(find . -type f)
    fi
    selected_files=$(echo $source_files | peco --prompt "[find file]")

	selected_files_line=$(echo $selected_files | tr '\n' ' ')
    BUFFER="${BUFFER}${selected_files_line}"
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-find-file
bindkey '^q' peco-find-file

### 便利コマンド ###

# 特定のコミットが含まれるPull Requestを探す
# http://ukstudio.jp/2015/03/26/open_pull_request/
function find-pr() {
    local parent=$2||'master'
    git log $1..$2 --merges --ancestry-path --reverse --oneline | head -n1
}

# 特定のコミットが含まれるPull Requestを開く
# http://ukstudio.jp/2015/03/26/open_pull_request/
function open-pr() {
    local pr="$(find-pr $1 $2 | awk '{print substr($5, 2)}')"
    local repo="$(git config --get remote.origin.url | sed 's/git@git.pepabo.com://' | sed 's/\.git$//')"
    open "https://git.pepabo.com/${repo}/pull/${pr}"
}
