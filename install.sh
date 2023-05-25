#!/bin/bash

config=$HOME/.config/

ln -rs picom.conf $config/
ln -rs alacritty.yml $config/alacritty/
ln -rs starship.toml $config/
ln -rs rofi/ $config/
ln -rs dunst/ $config/
ln -rs config.fish $config/fish/
ln -rs functions/ $config/fish
