# set all the path variables inside this file
source ~/.bashenv

eval "$(starship init bash)"

bind "set completion-ignore-case on"

source ~/.nix-profile/etc/profile.d/hm-session-vars.sh

shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s extglob
shopt -s globasciiranges
shopt -s globstar

alias amm=amm-31
alias cat=bat
alias clean-nvim='rm -rf ~/.local/share/nvim'
alias clip='xclip -sel c'
alias find=fd
alias gs='git status'
alias la='exa -la --git --group-directories-first'
alias ll='exa -l --git --group-directories-first'
alias ls='exa --git --group-directories-first'
alias lt4='exa --tree --level=4 --long --icons --git --group-directories-first'
alias lt='exa --tree --level=2 --long --icons --git --group-directories-first'
alias man=batman
alias new-nvim='begin; set -lx NVIM_APPNAME new-nvim; nvim; end;'
alias tree='erd -HId physical -s name -y inverted'
alias v-clean='begin; set -lx NVIM_APPNAME lazy-clean; nvim; end;'
alias z=zellij
alias za='zellij attach'
alias zl='zellij -l compact'
alias zr='zellij run --'

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
	if [ $1 -gt 0 ]; then
		exa --tree --level=$1 --long --icons --git --group-directories-first
	else
		exa --tree --level=2 --long --icons --git --group-directories-first
	fi
}
