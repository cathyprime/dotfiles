#!/usr/bin/env bash

active_window=$(tmux list-windows -f "#{window_active}" -F "#{window_index}")

function get_main_pane() {
    tmux list-panes | sed "s#.*%\([0-9]\+\.*\).*#\1#" | sort -n | head -n1 | sed "s#\(.*\)#%\1#"
}

function get-lines () {
    size=0.25
    total_lines=$(tmux display-message -p "#{window_height}")
    pane_lines=$(echo "$total_lines * $size / 1" | bc)
    echo "$pane_lines"
}

function clean-vars () {
    if tmux showenv "WIN${active_window}_TERM" &>/dev/null; then
        tmux setenv -u "WIN${active_window}_TERM"
    fi
    if tmux showenv "WIN${active_window}_LAYOUT" &>/dev/null; then
        tmux setenv -u "WIN${active_window}_LAYOUT"
    fi
}

# NOTE: WIN<number>_TERM
function create-default () {
    clean-vars
    pane_lines=$(get-lines)
    id=$(tmux split-window -PF "#{pane_id}" -l "$pane_lines" -t "$(get_main_pane)" -c "#{pane_current_path}")
    tmux setenv "WIN${active_window}_TERM" "$id"
}

# NOTE: WIN<number>_LAYOUT
function join-panes () {
    tmux join-pane -l "$(get-lines)" -s "$1" -t "$(get_main_pane)"

    if tmux showenv "WIN${active_window}_LAYOUT" &>/dev/null; then
        layout=$(tmux showenv "WIN${active_window}_LAYOUT" | sed "s#.*=##")
        tmux select-layout "$layout"
        tmux setenv -u "WIN${active_window}_LAYOUT"
    fi
}

function break-panes () {
    # NOTE: I have to make it manually because for some reason it is overriten when -a is used
    target_win=$(tmux list-windows | sed "s#\(.*\):.*#\1#" | sort -nr | head -n1 | sed "s#\(.*\)#\1+1#" | bc)
    target_win=$(echo "$target_win 4" | tr ' ' '\n' | sort -nr | head -n 1)

    tmux setenv "WIN${active_window}_LAYOUT" "$(tmux list-windows -f '#{window_active}' -F '#{window_layout}')"
    tmux break-pane -ds "$1" -n "term_${active_window}_pane" -t "$target_win"
}

paneid=$(tmux showenv "WIN${active_window}_TERM" | sed "s#.*=##")

if [ -n "$paneid" ]; then
    if tmux list-panes -a | grep -qs "$paneid"; then
        if tmux list-panes -t "$active_window" | grep -qs "$paneid"; then
            break-panes "$paneid"
        else
            join-panes "$paneid"
        fi
    else
        create-default
    fi
else
    create-default
fi
