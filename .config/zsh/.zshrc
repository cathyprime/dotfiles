fpath=($HOME/.config/zsh/completions $fpath)
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -U compinit; compinit

eval $(starship init zsh)

HISTFILE=~/.config/zsh/zsh_history

source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.nix-profile/etc/profile.d/hm-session-vars.sh

HISTSIZE=10000
SAVEHIST=10000

bindkey '^R' history-incremental-search-backward

setopt autocd
setopt autolist
setopt appendhistory

alias amm=amm-31
alias cat=bat
alias clean-nvim='rm -rf ~/.local/share/nvim'
alias clip='xclip -sel c'
alias gs='git status'
alias la='exa -la --git --group-directories-first'
alias ll='exa -l --git --group-directories-first'
alias ls='exa --git --group-directories-first'
alias man=batman
alias tree='erd -HId physical -s name -y inverted'

# >>> coursier install directory >>>
export PATH="$PATH:$USER/.local/share/coursier/bin"
# <<< coursier install directory <<<

function lt() {
    if (( $# > 0 )); then
        exa --tree --long --icons --git --group-directories-first --level="$1" 
    else
        exa --tree --level=2 --long --icons --git --group-directories-first
    fi
}

function lg() {
	if (( $# > 0 )); then
		lazygit -p "$@"
	else
		lazygit
	fi
}

echo
echo
echo "  $(date)"
echo "  $(date +%Y) the year of linux desktop!"
echo
