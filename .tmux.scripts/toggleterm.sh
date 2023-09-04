#!/usr/bin/env bash

total_lines=$(tmux display-message -p "#{window_height}")
pane_lines=$(printf "%.0f" "$(echo "$total_lines*0.25" | bc -l)")

if [ "$(tmux list-panes | wc -l)" -gt 1 ]; then
    if tmux list-panes | grep -qsE "[0-9]{2,4}x$pane_lines"; then
        paneid=$(tmux list-panes | grep -E "[0-9]{2,4}x$pane_lines" | sed "s#.*\(%[0-9]\+\).*#\1#")
        tmux kill-pane -t $paneid
    else
        tmux split-window -l 25%
    fi
else
    tmux split-window -l 25%
fi
