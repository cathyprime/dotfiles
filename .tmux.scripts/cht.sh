#!/usr/bin/env bash

if tmux list-windows | grep -q "cht.sh"; then
    id=$(tmux list-windows | grep "cht.sh" | sed "s#\([0-9]\+\):.*#\1#")
    tmux select-window -t "$id"
else
    mkfifo fzf_output
    (tmux neww "cat ~/.tmux/cht-languages ~/.tmux/cht-command | fzf > fzf_output") &
    exec 3< fzf_output
    read -u 3 selected
    echo $selected > ~/output
    if [ "$selected" = "" ]; then
        rm fzf_output
        exit 1
    fi
    if grep -qs "^$selected$" ~/.tmux/cht-command; then
        tmux neww -at 4 -n "cht.sh" bash -c "curl -s cht.sh/$selected | bat & while [ : ]; do sleep 1; done"
    else
        tmux command-prompt -p "Query:" "run-shell 'tmux setenv CHT_SH_QUERY %1'"
        query=$(tmux showenv CHT_SH_QUERY | sed "s#.*=\(.*\)#\1#")
        if tmux showenv CHT_SH_QUERY &> /dev/null; then
            query=$(echo $query | tr ' ' '+')
            tmux neww -at 4 -n "cht.sh" bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query | cat & while [ : ]; do sleep 1; done"
        fi
    fi
    tmux setenv -u CHT_SH_QUERY
    rm fzf_output
fi
