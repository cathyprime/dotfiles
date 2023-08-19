#!/usr/bin/env bash

selected=$(cat ~/.tmux/cht-command | fzf | sed "s/-/ /")
tmux neww bash -c "eval $(echo $selected --help) | bat & while true; do sleep 1; done"
