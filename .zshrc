### fish/config.fish から機械的に移植した zsh 設定 ###

### homebrew ###
if [[ -d /opt/homebrew/bin ]]; then
  export PATH="/opt/homebrew/bin:${PATH}"
fi

### claude など ###
if [[ -d "${HOME}/.local/bin" ]]; then
  export PATH="${HOME}/.local/bin:${PATH}"
fi

### Flutter ###
if [[ -d "${HOME}/flutter/bin" ]]; then
  export PATH="${HOME}/flutter/bin:${PATH}"
fi

### BSD 版コマンド ###
if [[ -d /opt/homebrew/opt/grep/libexec/gnubin ]]; then
  export PATH="/opt/homebrew/opt/grep/libexec/gnubin:${PATH}"
fi
if [[ -d /opt/homebrew/opt/gnu-sed/libexec/gnubin ]]; then
  export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:${PATH}"
fi

### fzf ###
export FZF_LEGACY_KEYBINDINGS=0

### Node.js ###
if [[ -d "${HOME}/.nodebrew/current/bin" ]]; then
  export PATH="${HOME}/.nodebrew/current/bin:${PATH}"
fi

### Rust ###
if [[ -d "${HOME}/.cargo" ]]; then
  export PATH="${HOME}/.cargo/bin:${PATH}"
fi

### Go ###
if [[ -d "${HOME}/go/bin" ]]; then
  export PATH="${PATH}:${HOME}/go/bin"
fi

if command -v go >/dev/null 2>&1; then
  export GOROOT="$(go env GOROOT)"
  export GOPATH="${HOME}"
  export PATH="${PATH}:${GOROOT}/bin:${GOPATH}/bin:/usr/local/opt/go/libexec/bin"
fi

### direnv ###
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

### jenv ###
if command -v jenv >/dev/null 2>&1; then
  export JENV_ROOT=/opt/homebrew/bin/jenv
  export PATH="${HOME}/.jenv/shims:${PATH}"
  eval "$(jenv init - zsh)"
fi

### rbenv ###
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
fi

### aliases ###
if [[ -o interactive ]]; then
  alias g='git'
  alias gb='git branch'
  alias gco='git checkout'
  alias gcm='git checkout master || git checkout main'
  alias gs='git status'
  alias ga='git add'
  alias gd='git diff'
  alias gr='git remote'
  alias gc='git commit -v'
  alias gp='git push'
  alias gm='git merge'
  alias gl='git pull'
  alias gf='git fetch'
  alias gfa='git fetch --all --prune'
  alias glg='git log --stat'
  alias l='ls -lah'
  alias ll='ls -lh'
  alias 1='cd -'
  alias 2='cd -2'
  alias vi='vim'
  alias ...='cd ../..'

  if command -v eza >/dev/null 2>&1; then
    alias ls='eza'
  fi
fi

autoload -Uz compinit
compinit

# 補完は大小文字を区別しない (例: "dow" -> "Downloads")
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

### gh completion ###
if command -v gh >/dev/null 2>&1; then
  eval "$(gh completion -s zsh)"
fi

### fish_user_key_bindings.fish の移植 ###
# Ctrl + ]: ghq repository search (fzf or peco)
function __ghq_repository_search() {
  local selected_dir

  if ! command -v ghq >/dev/null 2>&1; then
    zle -M 'ghq command not found'
    return 1
  fi

  if command -v fzf >/dev/null 2>&1; then
    selected_dir="$(ghq list -p | fzf --height=40% --reverse --prompt='ghq> ')"
  elif command -v peco >/dev/null 2>&1; then
    selected_dir="$(ghq list -p | peco --prompt '[ghq]')"
  else
    zle -M 'fzf or peco command not found'
    return 1
  fi

  if [[ -n "${selected_dir}" ]]; then
    BUFFER="cd ${(q)selected_dir}"
    zle accept-line
  fi
  zle redisplay
}
zle -N __ghq_repository_search

# Ctrl + r: history search (fish-like fuzzy picker with fallback)
function __history_search() {
  local selected_cmd

  if command -v fzf >/dev/null 2>&1; then
    selected_cmd="$(fc -rl 1 | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]*//' | awk '!seen[$0]++' | fzf --height=40% --reverse --prompt='history> ' --query "$LBUFFER")"
    if [[ -n "${selected_cmd}" ]]; then
      BUFFER="${selected_cmd}"
      CURSOR=${#BUFFER}
    fi
    zle redisplay
  else
    zle history-incremental-search-backward
  fi
}
zle -N __history_search

bindkey '^F' forward-char
bindkey '^R' __history_search
bindkey '^]' __ghq_repository_search
if [[ -n "$(zle -la | grep '^__fzf_find_file$')" ]]; then
  bindkey '^T' __fzf_find_file
fi

### bobthefish の挙動を簡易再現 ###
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'

setopt PROMPT_SUBST
PROMPT='%F{cyan}%~%f%F{green}${vcs_info_msg_0_}%f
%(?.%F{magenta}.%F{red})❯%f '

### 職場用の設定などを読み込む ###
if [[ -f "${HOME}/.additional_config.zsh" ]]; then
  source "${HOME}/.additional_config.zsh"
fi
