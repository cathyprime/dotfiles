#!/bin/bash

rustup default stable
cargo install --git https://github.com/MordechaiHadad/bob.git

fish_add_path ~/.local/share/bob/nvim-bin/
fish_add_path ~/.cargo/bin/
bob install latest
bob use latest
