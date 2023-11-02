#!/usr/bin/env bash

rm -f /tmp/git_clipboard
mkfifo /tmp/git_clipboard
( tmux popup -E -h 50% -w 100% -y W -x W "git log --oneline --all\
    | fzf --preview 'git show --color=always {+1}'\
    | sed 's#\([0-9a-f]\{7\}\) .*#\1#'\
    | tr -d '\n' > /tmp/git_clipboard") &
exec 3< /tmp/git_clipboard
read -ru 3 hash
tmux send "$hash"
rm /tmp/git_clipboard
