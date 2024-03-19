# set all the path variables inside this file
# source ~/.config/bash/.bashenv
# source ~/.config/bash/completion/git-completion.bash

# eval "$(starship init bash)"
PS1='\[\e[38;5;57m\]\u\[\e[0m\]@\[\e[38;5;196;3m\]\h\[\e[0m\]:\[\e[38;5;63m\]\W\[\e[38;5;45m\]\$\[\e[92m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2) \[\e[0;3m\]~>\[\e[0m\] '

bind "set completion-ignore-case on"

shopt -s cdspell
shopt -s dirspell
shopt -s extglob
shopt -s globasciiranges
shopt -s globstar

alias clean-nvim="rm -rf ~/.local/share/nvim"
alias la="ls -la --color"
alias ll="ls -l --color"
alias ls="ls --color"
alias gs="git status"

# >>> coursier install directory >>>
export PATH="$PATH:$USER/.local/share/coursier/bin"
# <<< coursier install directory <<<

function lg() {
	if [ $# -gt 0 ]; then
		lazygit -p "$@"
	else
		lazygit
	fi
}

function lt() {
	if [ "$1" -gt 0 ]; then
		eza --tree --level="$1" --long --icons --git --group-directories-first
	else
		eza --tree --level=2 --long --icons --git --group-directories-first
	fi
}

. "$HOME/.cargo/env"
