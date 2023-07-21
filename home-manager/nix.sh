#!/bin/bash

sh <(curl -L https://nixos.org/nix/install) --no-daemon

pushd home-manager
rm -r ~/.config/home-manager
mkdir -p ~/.config/home-manager
configs=$(pwd)
pushd ~/.config/home-manager
for file in "$configs"/*.nix; do
	cp "$file" .
done
