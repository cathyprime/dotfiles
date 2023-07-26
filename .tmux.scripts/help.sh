#!/usr/bin/env bash

selected=$(cat ~/.tmux/cht-command | fzf)
eval $(echo $selected --help) &
while [:]; do sleep 1; done
