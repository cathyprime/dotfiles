#!/usr/bin/env bash
pager="less"

if command -v bat >/dev/null 2>&1; then
    pager="bat -pl bash --paging=always"
fi

get_input () {
    temp_file=$(mktemp)
    (tmux command-prompt -p "$@" "run-shell \"echo '%1' > $temp_file\"") &
    wait
    selected=$(cat "$temp_file")
    rm "$temp_file"
    echo "$selected"
}

if tmux list-windows | grep -q 'help'; then
    id=$(tmux list-windows | grep 'help' | sed 's#\([0-9]\+\):.*#\1#')
    tmux select-window -t "$id"
else
    selected=$(get_input "enter query for --help command:")
    if [ "$selected" = "" ]; then
        exit 0
    fi
    selected=$(echo "$selected" | sed 's#\(.*\)#\1 --help#')
    tmux neww -at 4 -n "help" bash -c "eval '$selected' | $pager && tmux kill-window"
fi
