#!/usr/bin/env bash

if tmux list-windows | grep -q 'help'; then
    id=$(tmux list-windows | grep 'help' | sed 's#\([0-9]\+\):.*#\1#')
    tmux select-window -t "$id"
else
    mkfifo output_help
    (tmux command-prompt -p "enter query for --help command:" "run-shell \"echo '%1' > output_help\"") &
    exec 3< output_help
    read -u 3 selected
    rm output_help
    if [ "$selected" = "" ]; then
        exit 0
    fi
    selected=$(echo "$selected" | sed 's#\(.*\)#\1 --help#')
    tmux neww -at 4 -n "help" bash -c "eval '$selected' | bat -pl bash --paging=always; tmux kill-window"
fi
