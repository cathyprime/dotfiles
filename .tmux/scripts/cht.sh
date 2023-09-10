#!/usr/bin/env bash

if tmux list-windows | grep -q "cht.sh"; then
    id=$(tmux list-windows | grep "cht.sh" | sed "s#\([0-9]\+\):.*#\1#")
    tmux select-window -t "$id"
else
    mkfifo fzf_output
    (tmux neww "cat ~/.tmux/cht-languages ~/.tmux/cht-command | fzf > fzf_output") &
    exec 3< fzf_output
    read -u 3 selected
    rm fzf_output
    if [ "$selected" = "" ]; then
        exit 0
    fi
    if grep -qs "^$selected$" ~/.tmux/cht-command; then
        tmux neww -at 4 -n "cht.sh" bash -c "curl -s cht.sh/$selected | bat -p --paging=always;tmux kill-window"
    else
        mkfifo query
        (tmux command-prompt -p "Query:" "run-shell \"echo '%1' > query\"") &
        exec 3< query
        read -u 3 query
        rm query
        if [ "$query" = "" ]; then
            exit 0
        fi
        query=$(echo $query | tr ' ' '+')
        tmux neww -at 4 -n "cht.sh" bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query | bat -p --paging=always;tmux kill-window"
    fi
fi
