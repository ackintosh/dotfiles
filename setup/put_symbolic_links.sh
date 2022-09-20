#!/bin/bash

# fish
if [ -f ~/.config/fish/config.fish ]; then
	# fishのインストール時にデフォルトの設定ファイルが作成されるので退避する
	mv ~/.config/fish/config.fish ~/.config/fish/config.fish_bk_$(date "+%Y-%m-%d-%H-%M-%S")
fi
cd ~/.config/fish; ln -s ~/src/github.com/ackintosh/dotfiles/fish/config.fish

# key bindings for fish
cd ~/.config/fish/functions; ln -s ~/src/github.com/ackintosh/dotfiles/fish/fish_user_key_bindings.fish

# gitignore_global
cd ~; ln -s ~/src/github.com/ackintosh/dotfiles/.gitignore_global
# tmux
cd ~; ln -s ~/src/github.com/ackintosh/dotfiles/.tmux.conf

# vim
cd ~; ln -s ~/src/github.com/ackintosh/dotfiles/.vimrc
cd ~; ln -s ~/src/github.com/ackintosh/dotfiles/.vim

# IDEA
cd ~; ln -s ~/src/github.com/ackintosh/dotfiles/.ideavimrc

# Ruby
cd ~; ln -s ~/src/github.com/ackintosh/dotfiles/.gemrc
