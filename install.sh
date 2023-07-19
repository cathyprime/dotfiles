#!/bin/bash

cd ./home-manager/
./nix.sh
cd ..
bash home-manager/home.sh
bash scripts/font.sh
bash scripts/prestow.sh
bash scripts/stow.sh
if [ "$(basename $SHELL)" = "fish" ]; then
	fish scripts/fish.sh
	fish scripts/bob-nvim.sh
fi
