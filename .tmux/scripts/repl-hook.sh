#!/usr/bin/env bash

repls=$(tmux showenv | grep REPL)

for i in $repls; do
	if ! tmux list-panes -F '#{pane_id}' | grep -qs "${i//*=/}"; then
		tmux setenv -u "${i//=*/}"
	fi
done
