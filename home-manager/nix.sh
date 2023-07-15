#!/bin/bash

sh <(curl -L https://nixos.org/nix/install) --no-daemon

rm -r ~/.config/home-manager
mkdir -p ~/.config/home-manager
configs=$(pwd)
pushd ~/.config/home-manager
for file in "$configs"/*.nix; do
	ln -s "$file"
done
