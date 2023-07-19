#!/bin/bash

cd ./home-manager/
./nix.sh
cd ..
bash home-manager/home.sh
bash scripts/font.sh
fish scripts/fish.sh
bash scripts/prestow.sh
bash scripts/stow.sh
fish scripts/bob-nvim.sh
