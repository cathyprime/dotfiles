# set all the path variables inside this file
# source ~/.config/bash/.bashenv
# source ~/.config/bash/completion/git-completion.bash

# eval "$(starship init bash)"
if ! command -V oh-my-posh &> /dev/null; then
    PS1='\[\e[38;5;57m\]\u\[\e[0m\]@\[\e[38;5;196;3m\]\h\[\e[0m\]:\[\e[38;5;63m\]\W\[\e[38;5;45m\]\$\[\e[92m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2) \[\e[0;3m\]~>\[\e[0m\] '
else
    eval "$(oh-my-posh init bash --config $HOME/.config/ohmyposh/omp.toml)"
fi

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
