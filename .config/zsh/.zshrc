fpath=($HOME/.config/zsh/completions $fpath)
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -U compinit;
compinit -i

# eval $(starship init zsh)

HISTFILE=~/.config/zsh/zsh_history

source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.nix-profile/etc/profile.d/hm-session-vars.sh

HISTSIZE=10000
SAVEHIST=10000

check_exit_code() {
    local exit_code=$?

    if [[ $exit_code -ne 0 ]]; then
        echo $exit_code
    else
        echo ""
    fi
}

get_cwd() {
    if [[ $(pwd) == $HOME ]]; then
        echo "~"
    else
        echo $(basename $(pwd))
    fi
}

colors() {
    columns=16
    for code in {0..255}; do
        printf "\e[38;5;%dm%4d\e[0m " "$code" "$code"
        if (( (code + 1) % columns == 0 )); then
            echo
        fi
    done
}

get_git() {
    local branch=$(git branch 2>/dev/null | grep '*' | sed "s/\* //g")
    if [[ -n "$branch" ]]; then
        echo "%F{27}git:(%F{196}$branch%F{27})%f "
    fi
}

PROMPT='%F{208}%n%f@%F{160}%m%f $(get_cwd) %F{57}$(sudo -n -v >/dev/null 2>&1 && echo "#" || echo "$")%f %F{22}$(get_git)%f~> '
RPROMPT='%F{red}$(check_exit_code)%f'

search-history() {
    local selected=$(fc -l -n -1 0 | awk '!seen[$0]++' | fzf +s -x --preview-window=hidden --height=40%)
    if [[ -n $selected ]]; then
        zle -U "$selected"
    fi
}

zle -N search-history

bindkey '^R' search-history
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

setopt PROMPT_SUBST
setopt PROMPT_PERCENT
# setopt autocd
setopt autolist
setopt SHARE_HISTORY

alias amm=amm-31
alias :q="exit"
alias cat=bat
alias clean-nvim='rm -rf ~/.local/share/nvim'
alias clip='xclip -sel c'
alias gs='git status'
alias la='exa -la --git --group-directories-first'
alias ls='exa --git --group-directories-first'
alias qmkcd='cd ~/Repositories/qmk_firmware/'
# alias man=batman
MANPAGER="sh -c 'col -bx | bat -l man -p'"
alias tree='erd -HId physical -s name -y inverted'

# >>> coursier install directory >>>
export PATH="$PATH:$USER/.local/share/coursier/bin"
# <<< coursier install directory <<<

alias ll='exa -l --git --group-directories-first'
function llg() {
    git rev-parse --is-inside-work-tree > /dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        git status
    fi
    exa -l --git --group-directories-first "$@"
}

grep_commit() {
    git log --oneline --all | fzf | grep -Eo '[a-f0-9]{7}' | tr ' ' '\n' | head | tr -d '\n' | xclip -sel c
}

function lt() {
    if (( $# > 0 )); then
        exa --tree --long --icons --git --group-directories-first --level="$1" 
    else
        exa --tree --level=2 --long --icons --git --group-directories-first
    fi
}

function tw() {
    if (( $# > 0 )); then
        tmux-workspace $1
    else
        tmux-workspace
    fi
}

function lg() {
    if (( $# > 0 )); then
        lazygit -p "$@"
    else
        lazygit
    fi
}

function addToPath() {
    if (( $# == 0)); then
        echo "Provide a path!"
    elif [[ $1 == "." ]]; then
        echo -e "PATH=\"\$PATH:$cwd\"" >> ~/.config/zsh/.zshenv
    else
        echo -e "PATH=\"\$PATH:$cwd$@\"" >> ~/.config/zsh/.zshenv
    fi
}

function nvimf () {
    local selected=$(fd . -H --exclude=.git | fzf)
    nvim $selected
}

function nvimt () {
    NVIM_APPNAME=nvim-test nvim "$@"
}

echo
echo
echo "$(date)"
echo "$(date +%Y) the year of linux desktop!"
echo
