#!/bin/bash

rustup default stable
cargo install bob-nvim

source ~/.config/zsh/.zshenv

bob install latest
bob use latest
