#!/usr/bin/env bash

terms=$(tmux list-windows | grep -E "term_._pane" | sed "s#.*term_\(.\)_pane.*#\1#")
for i in $terms; do
    if tmux list-windows | grep -qsE "$i:"; then
        :
    else
        tmux kill-window -t "$(tmux list-windows | grep "term_${i}_pane" | sed "s#\([0-9]\+\):.*#\1#")"
    fi
done
