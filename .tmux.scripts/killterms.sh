#!/usr/bin/env bash

total_lines=$(tmux display-message -p "#{window_height}")
pane_lines=$(printf "%.0f" "$(echo "$total_lines*0.25" | bc -l)")

terms=$(tmux list-windows | grep -E "term_[0-9]+_pane" | sed "s#\([0-9]\+\):.*#\1#")
panes=$(tmux list-panes -a | grep -E "[0-9]{2,4}x$pane_lines" | sed "s#.*\(%[0-9]\+\).*#\1#")
echo $terms | xargs -I{} tmux kill-window -t {}
echo $panes | xargs -I{} tmux kill-pane -t {}
