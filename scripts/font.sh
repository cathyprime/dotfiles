#!/bin/bash

pushd ~/Repositories/
git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts
pushd nerd-fonts
git sparse-checkout add patched-fonts/Hack
git checkout v2.3.3
./install.sh
