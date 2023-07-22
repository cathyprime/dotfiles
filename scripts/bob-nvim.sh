#!/bin/bash

rustup default stable
cargo install --git https://github.com/MordechaiHadad/bob.git

set -Ua fish_user_paths ~/.local/share/bob/nvim-bin/
set -Ua fish_user_paths ~/.cargo/bin/
bob install latest
bob use latest
