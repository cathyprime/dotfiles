#!/usr/bin/env bash

function get_main_pane() {
    echo $(tmux list-panes | sed "s#.*%\([0-9]\+\.*\).*#\1#" | sort -n | head -n1 | sed "s#\(.*\)#%\1#")
}

size="25%"
total_lines=$(tmux display-message -p "#{window_height}")
pane_lines=$(printf "%.0f" "$(echo "$total_lines*0.25" | bc -l)")

active_window=$(tmux list-windows | grep -E "active" | sed "s#\([0-9]\+\):.*#\1#")

if tmux list-windows | grep -qs "term_${active_window}_pane"; then
    term_window=$(tmux list-windows | grep "term_${active_window}_pane" | sed "s#\(.\).*#\1#")
    source_pane=$(tmux list-panes -t "$term_window" | grep "active" | sed "s#.*\(%[0-9]\+\).*#\1#")
    tmux join-pane -s "$source_pane" -l "$size" -t "$(get_main_pane)"
else
    if [ "$(tmux list-panes | wc -l)" -gt 1 ]; then
        if tmux list-panes | grep -qsE "[0-9]{2,4}x$pane_lines"; then
            paneid=$(tmux list-panes | grep -E "[0-9]{2,4}x$pane_lines" | sed "s#.*\(%[0-9]\+\).*#\1#")
            target_win=$(tmux list-windows | sed "s#\(.*\):.*#\1#" | sort -nr | head -n1 | sed "s#\(.*\)#\1+1#" | bc)
            target_win=$(echo "$target_win 4" | tr ' ' '\n' | sort -nr | head -n 1)
            tmux break-pane -ds "$paneid" -n "term_${active_window}_pane" -t "$target_win"
        else
            tmux split-window -l "$size" -t $(get_main_pane)
        fi
    else
        tmux split-window -l "$size" -t $(get_main_pane)
    fi
fi
