#!/bin/bash

cd ./home-manager/
./nix.sh
cd ..
bash home-manager/home.sh
bash scripts/stow.sh
bash scripts/bob-nvim.sh
bash scripts/font.sh
