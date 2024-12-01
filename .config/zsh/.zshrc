# vim: ft=sh

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -U compinit;
autoload -U edit-command-line
compinit -i

HISTFILE=~/.config/zsh/zsh_history

stty -ixon

source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/completion/oh-my-posh/_oh-my-posh.zsh

HISTSIZE=10000
SAVEHIST=10000

colors() {
    columns=16
    for code in {0..255}; do
        printf "\e[38;5;%dm%4d\e[0m " "$code" "$code"
        if (( (code + 1) % columns == 0 )); then
            echo
        fi
    done
}

jobs() {
    case "$1" in
        "") builtin jobs ;;
        "-P") builtin jobs -p | sed 's;\[[0-9]\+\]\s\s.\s\([0-9]\+\).*;\1;' ;;
        *) builtin jobs "$@" ;;
    esac
}
if ! command -V oh-my-posh &> /dev/null; then
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

    get_git() {
        local branch=$(git branch 2>/dev/null | grep '*' | sed "s/\* //g")
        if [[ -n "$branch" ]]; then
            echo "%F{27}git:(%F{196}$branch%F{27})%f "
        fi
    }

    PROMPT='%F{208}cwd%f -> %F{160}$(get_cwd)%f %F{57}$(sudo -n -v >/dev/null 2>&1 && echo "#" || echo "$")%f %F{22}$(get_git)%f>>= '
    RPROMPT='%F{red}$(check_exit_code)%f'
else
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/omp.toml)"
fi

bindkey -e
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey '^U' backward-kill-line
bindkey '^[[1;5A' up-line-or-search
bindkey '^[[1;5B' down-line-or-search
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

setopt promptsubst
setopt promptpercent
setopt autolist
setopt sharehistory
unsetopt nointeractivecomments

alias clean-nvim='rm -rf ~/.local/share/nvim'
alias gs='git status'
alias la='eza -la --group-directories-first'
alias ls='eza --group-directories-first'
alias qmkcd='cd ~/Repositories/misc/qmk_firmware/'
alias ll='eza -l --group-directories-first'
alias man=batman

nvide() {
    zsh -c "neovide &; disown"
}

spath() {
    echo $PATH | sed 's/:/\n/g'
}

docker() {
    case "$1" in
        "") command docker ;;
        "lazy") lazydocker ;;
        *) command docker "$@" ;;
    esac
}

git() {
    case "$1" in
        "") command git ;;
        "lazy") lazygit ;;
        *) command git "$@" ;;
    esac
}

lt() {
    if [[ $# -gt 0 && $1 -eq $1 ]]; then
        eza --tree --long --icons --group-directories-first --level="$1" "${@:2}"
    else
        eza --tree --long --icons --group-directories-first "$@"
    fi
}

tw() {
    case "$1" in
        "") if tmux list-sessions 2>&1 | grep -Eqs "(no server running|no sessions|error connecting)"; then
                tmux-workspace
            else
                tmux attach
            fi
        ;;
        *) tmux-workspace "$@" ;;
    esac
}

lg() {
    if (( $# > 0 )); then
        lazygit -p "$@"
    else
        lazygit
    fi
}

nvimt () {
    NVIM_APPNAME=nvim-test nvim "$@"
}

greeter() {
    local messages=(
        "VI VI VI"
        "Trans lives matter"
        "Trans rights are human rights"
        ":3 :3 :3"
    )

    local rand=$(( $RANDOM % ${#messages[@]} + 1))
    echo ${messages[$rand]}
}

transflag
echo
echo
echo "$(date)"
echo "$(date +%Y) the year of linux desktop!"
echo "$(greeter)"
echo
export PATH=${$(cat <(tr ':' '\n' <<< $PATH | grep "$USER" | sort -u) <(tr ':' '\n' <<< $PATH | grep -v "$USER" | sort -u) | grep -v '^$' | tr '\n' ':')%:}
