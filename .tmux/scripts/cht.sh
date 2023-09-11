#!/usr/bin/env bash

get_input () {
    temp_file=$(mktemp)
    (tmux command-prompt -p "$@" "run-shell \"echo '%1' > $temp_file\"") &
    wait
    selected=$(cat "$temp_file")
    rm "$temp_file"
    echo "$selected"
}

if tmux list-windows | grep -q "cht.sh"; then
    id=$(tmux list-windows | grep "cht.sh" | sed "s#\([0-9]\+\):.*#\1#")
    tmux select-window -t "$id"
else
    rm -f /tmp/fzf_output
    mkfifo /tmp/fzf_output
    (tmux neww "cat ~/.tmux/cht-languages ~/.tmux/cht-command | fzf > /tmp/fzf_output") &
    exec 3< /tmp/fzf_output
    read -u 3 selected
    rm -f /tmp/fzf_output
    if [ "$selected" = "" ]; then
        exit 0
    fi
    if grep -qs "^$selected$" ~/.tmux/cht-command; then
        tmux neww -at 4 -n "cht.sh" bash -c "curl -s cht.sh/$selected | bat -p --paging=always;tmux kill-window"
    else
        query=$(get_input "Query:")
        if [ "$query" = "" ]; then
            exit 0
        fi
        query=$(echo $query | tr ' ' '+')
        tmux neww -at 4 -n "cht.sh" bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query | bat -p --paging=always;tmux kill-window"
    fi
fi
