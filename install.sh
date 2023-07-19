#!/bin/bash

cd ./home-manager/
./nix.sh
cd ..
bash home-manager/home.sh
bash scripts/fish.sh
bash scripts/stow.sh
fish scripts/bob-nvim.sh
bash scripts/font.sh
