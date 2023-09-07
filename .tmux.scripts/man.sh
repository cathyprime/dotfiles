#!/usr/bin/env bash

if tmux list-windows | grep -q 'man'; then
    id=$(tmux list-windows | grep 'man' | sed 's#\([0-9]\+\):.*#\1#')
    tmux select-window -t "$id"
else
    mkfifo query
    (tmux command-prompt -p "Enter man query:" "run-shell \"echo '%1' > query\"") &
    exec 3< query
    read -u 3 selected
    rm query
    if [ "$selected" = "" ]; then
        exit 0
    fi
    tmux neww -n 'man' -at 4 bash -c "/usr/bin/man '$selected' | col -b | bat -pl man --paging=always && tmux kill-window & sleep infinity"
fi
