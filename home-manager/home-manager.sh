#!/bin/bash

rm -r ~/.config/home-manager
mkdir -p ~/.config/home-manager
configs=$(pwd)
pushd ~/.config/home-manager

for file in "$configs"/*.nix; do
	ln -s "$file"
done

popd
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
home-manager switch
