#!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

rustup default stable
cargo install --git https://github.com/MordechaiHadad/bob.git

if [ "$(basename $SHELL)" = "fish" ]; then
	set -Ua fish_user_paths ~/.local/share/bob/nvim-bin
	set -Ua fish_user_paths ~/.cargo/bin
else
	echo 'export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"' >>~/.config/zsh/.zshenv
	echo 'export PATH="$PATH:$HOME/.cargo/bin"' >>~/.config/zsh/.zshenv
	source ~/.config/zsh/.zshenv
fi

bob install latest
bob use latest
