# PATHを通す
# https://zenn.dev/estra/articles/zenn-fish-add-path-final-answer#%E7%B5%90%E8%AB%96
# * config.fish でパスを通す場合には fish_add_path 関数を使用
# * PATH 以外の環境変数を定義するには set -gx を使用して定義

### homebrew ###
if test -d /opt/homebrew/bin
  set PATH /opt/homebrew/bin $PATH
end

### BSD版コマンド ###
# grep, fgrep, egrep
if test -d /opt/homebrew/opt/grep/libexec/gnubin
  set PATH /opt/homebrew/opt/grep/libexec/gnubin $PATH
end
# sed
if test -d /opt/homebrew/opt/gnu-sed/libexec/gnubin
  set PATH /opt/homebrew/opt/gnu-sed/libexec/gnubin $PATH
end

### fzf ###
# 新キーバインディングを有効にする
# キーバインディングは別途、 .config/fish/functions/fish_user_key_bindings.fish で設定している
set -U FZF_LEGACY_KEYBINDINGS 0

### Python ###
# パスが `/opt/homebrew/bin/python3` に変わったのでコメントアウト
# python3 installed via homebrew
# if test -d /usr/local/opt/python/libexec/bin
#   set PATH /usr/local/opt/python/libexec/bin $PATH
# end

### Node.js ###
# nodejs installed via nodebrew
if test -d ~/.nodebrew/current/bin
  set PATH ~/.nodebrew/current/bin $PATH
end

### Rust ###
# Cargo
if test -e ~/.cargo
  # fishでは ~/.cargo/env の読み込みがエラーになるので、代わりに明示的にパスの設定をしている
  # 参考: https://github.com/rust-lang/rustup/issues/478
  # source ~/.cargo/env
  set PATH ~/.cargo/bin $PATH
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

### jenv ###
if which -s jenv
  set JENV_ROOT /opt/homebrew/bin/jenv
  # 以下、`jenv init -` で出力されたコマンド
  # NOTE: 下記ファイルを一部(下記の3行)コメントアウトした (`command` の出力がターミナルにでてしまうため)
  # /opt/homebrew/Cellar/jenv/0.5.5_2/libexec/available-plugins/export/etc/jenv.d/init/export_jenv_hook.fish
  #   # if not command -s jenv
  #   #   return
  #   # end

  set -gx PATH '/Users/abi01357/.jenv/shims' $PATH
  set -gx JENV_SHELL fish
  set -gx JENV_LOADED 1
  set -e JAVA_HOME
  set -e JDK_HOME
  source '/opt/homebrew/Cellar/jenv/0.5.5_2/libexec/libexec/../completions/jenv.fish'
  jenv rehash 2>/dev/null
  jenv refresh-plugins
  source "/Users/abi01357/.jenv/plugins/export/etc/jenv.d/init/export_jenv_hook.fish"
  function jenv
    set command $argv[1]
    set -e argv[1]
  
    switch "$command"
    case enable-plugin rehash shell shell-options
      jenv "sh-$command" $argv | source
    case '*'
      command jenv "$command" $argv
    end
  end
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

# interactiveモードの時だけ balias でエイリアスを設定する
# https://github.com/jorgebucaran/fisher/issues/528#issuecomment-467810844
# 本当は config.fish でnon-builtinコマンドを使うのは避けたほうが良い
if status is-interactive
  balias g 'git'
  balias gb 'git branch'
  balias gco 'git checkout'
  balias gcm 'git checkout master || git checkout main'
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
  balias ... 'cd ../..'

  # キレイなls
  if which -s exa
    balias ls 'exa'
  end
  
  # イケてるcat
  if which -s bat
    balias cat 'bat'
  end
end


# ghコマンドのコマンド補完を設定する
# https://cli.github.com/manual/gh_completion
if which -s gh
  eval (gh completion -s fish)
end

### 職場用の設定などを読み込む ###
if test -e ~/.additional_config.fish
  source ~/.additional_config.fish
end
