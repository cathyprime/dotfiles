#!/bin/bash

repl=${1^^}
repl_id=""

if [ -z "$TMUX" ]; then
	echo "tmux is not on"
	exit 1
fi

if ! tmux showenv | grep -qs REPL; then
	repl_id=$(tmux splitw -h -PF '#{pane_id}' "$1")
	tmux setenv "REPL_${repl}" "$repl_id"
else
	repl_id=$(tmux showenv "REPL_${repl}" | sed "s/.*=//")
fi

IFS=''
while read -r line; do
	tmux send-keys -t "$repl_id" "$line"
	tmux send-keys -t "$repl_id" Enter
done
