#!/bin/bash

rustup default stable
cargo install --git https://github.com/MordechaiHadad/bob.git

bob install latest
bob use latest
fish_add_path ~/.local/share/bob/nvim-bin/
