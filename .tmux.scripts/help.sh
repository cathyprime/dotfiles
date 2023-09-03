#!/usr/bin/env bash

if tmux list-windows | grep -q 'help'; then
    id=$(tmux list-windows | grep 'help' | sed 's#\([0-9]\+\):.*#\1#')
    tmux select-window -t "$id"
else
    tmux command-prompt -p "enter query for --help command:" "run-shell \"tmux setenv USER_INPUT_HELP_SH '%1'\""
    selected=$(tmux showenv USER_INPUT_HELP_SH | sed 's#.*=\(.*\)#\1 --help#')
    if tmux showenv USER_INPUT_HELP_SH &> /dev/null; then
        tmux neww -at 4 -n "help" bash -c "eval '$selected' | bat && sleep infinity"
    fi
    tmux setenv -u USER_INPUT_HELP_SH
fi
