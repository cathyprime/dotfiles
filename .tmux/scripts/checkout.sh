#!/usr/bin/env bash

path=$(pwd | sed 's#\(.*\.git\/\).*#\1#')
bash ~/.local/bin/tmux-workspace "$path"
