#!/usr/bin/env bash

if tmux list-windows | grep -q 'man'; then
    id=$(tmux list-windows | grep 'man' | sed 's#\([0-9]\+\):.*#\1#')
    tmux select-window -t "$id"
else
    tmux command-prompt -p "Enter man query:" "run-shell 'tmux setenv USER_INPUT_MAN_SH %1'"
    selected=$(tmux showenv USER_INPUT_MAN_SH | sed "s#.*=\(.*\)#\1#")
    if tmux showenv USER_INPUT_MAN_SH &> /dev/null; then
        tmux neww -n 'man' -at 4 bash -c "man $selected & sleep infinity"
    fi
    tmux setenv -u USER_INPUT_MAN_SH
fi
