#!/bin/bash

cd ./home-manager/
./nix.sh
cd ..
bash home-manager/home.sh
