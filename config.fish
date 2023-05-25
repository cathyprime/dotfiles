if status is-interactive
    starship init fish | source
end

# aliases
alias vi="nvim"
alias clip="xclip -selection c"
alias lg="lazygit"
alias ll="exa -l"
alias la="exa -la"
alias l="exa -la"
alias cat="bat"
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias man="batman"
alias tree="erd -HId physical -s name --inverted"
alias gs="git status"
alias vimdiff="nvim -d"

bind \cx nvim
bind \cg lazygit
