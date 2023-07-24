#!/bin/bash

rustup default stable
cargo install --git https://github.com/MordechaiHadad/bob.git

if [ "$(basename $SHELL)" = "fish" ]; then
	set -Ua fish_user_paths ~/.local/share/bob/nvim-bin
	set -Ua fish_user_paths ~/.cargo/bin
fi

if [ "$(basename $SHELL)" = "zsh" ]; then
	echo 'export PATH="$PATH:~/.local/share/bob/nvim"' >>~/.config/zsh/.zshenv
	echo 'export PATH="$PATH:~/.cargo/bin"' >>~/.config/zsh/.zshenv
fi

bob install latest
bob use latest
