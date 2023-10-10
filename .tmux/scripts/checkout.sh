#!/usr/bin/env bash

if ! git rev-parse > /dev/null 2>&1 ; then
	exit 0
fi

locals=$(git ls | sed 's/..//')
remotes=$(git ls -r | grep -v HEAD | sed 's/[[:space:]]*//' | sed 's/\(.*\)\///')
remotes=$(echo "$remotes" | grep -vF -f <(echo "$locals"))

locals=$(echo "$locals" | sed "s#^#[Local]: #" | awk '{ print length, $0 }' | sort -n | cut -d" " -f2-)
remotes=$(echo "$remotes" | sed "s#^#[Remote]: #" | awk '{ print length, $0 }' | sort -n | cut -d" " -f2-)

rm -f /tmp/tmux_checkout_temp
mkfifo /tmp/tmux_checkout_temp
( tmux neww -at 4 "cat <(echo \"$locals\") <(echo \"$remotes\") | fzf --no-sort --tac | tr -d '\n' > /tmp/tmux_checkout_temp") &
exec 3< /tmp/tmux_checkout_temp
read -ru 3 selected
rm -f /tmp/tmux_checkout_temp

type=$(echo "$selected" | cut -d ' ' -f1 | sed 's#\[\(.*\)\]:.*#\1#')
branch=$(echo "$selected" | cut -d ' ' -f2)

curr_branch=$(git branch | grep "\* " | sed 's#..##')

git stash -aum "tmux-checkout-autostash-${curr_branch}" >/dev/null 2>&1

if [[ "Local" == "$type" ]]; then
	git switch "$branch" >/dev/null 2>&1
	if git stash list | grep -qs "tmux-checkout-autostash-${branch}"; then
		stash=$(git stash list | grep "tmux-checkout-autostash-${branch}" | sed 's#\([^:]*\).*#\1#')
		git stash pop "$stash" >/dev/null 2>&1
	fi
	tmux send-keys "git status"
	tmux send-keys Enter
else
	git checkout -b "$branch" >/dev/null 2>&1
	tmux send-keys "git status"
	tmux send-keys Enter
fi
