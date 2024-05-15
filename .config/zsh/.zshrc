fpath=($HOME/.config/zsh/completions $fpath)
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -U compinit;
autoload -U edit-command-line
compinit -i

HISTFILE=~/.config/zsh/zsh_history

stty -ixon

source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

polygon() {
    rm -rf ~/Polygon/(.*|*) 2>/dev/null
}

get_git() {
    local branch=$(git branch 2>/dev/null | grep '*' | sed "s/\* //g")
    if [[ -n "$branch" ]]; then
        echo "%F{27}git:(%F{196}$branch%F{27})%f "
    fi
}

jobs() {
    case "$1" in
        "") builtin jobs ;;
        "-P") builtin jobs -p | sed 's;\[[0-9]\+\]\s\s.\s\([0-9]\+\).*;\1;' ;;
        *) builtin jobs "$@" ;;
    esac
}

PROMPT='%F{208}cwd%f -> %F{160}$(get_cwd)%f %F{57}$(sudo -n -v >/dev/null 2>&1 && echo "#" || echo "$")%f %F{22}$(get_git)%f>>= '
RPROMPT='%F{red}$(check_exit_code)%f'

zle -N edit-command-line

bindkey "^[[3~" delete-char
bindkey "" beginning-of-line
bindkey "" end-of-line
bindkey "" edit-command-line
bindkey "" history-incremental-search-backward
bindkey "" history-incremental-search-forward
bindkey "" up-line-or-search
bindkey "" down-line-or-search
bindkey -e

setopt promptsubst
setopt promptpercent
setopt autolist
setopt sharehistory
unsetopt nointeractivecomments

alias clean-nvim='rm -rf ~/.local/share/nvim'
alias gs='git status'
alias la='eza -la --git --group-directories-first'
alias ls='eza --git --group-directories-first'
alias qmkcd='cd ~/Repositories/misc/qmk_firmware/'
alias ll='eza -l --git --group-directories-first'
alias nvide=neovide
alias man=batman

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
        eza --tree --long --icons --git --group-directories-first --level="$1" "${@:2}"
    else
        eza --tree --long --icons --git --group-directories-first "$@"
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

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

transflag
echo
echo
echo "$(date)"
echo "$(date +%Y) the year of linux desktop!"
echo "$(greeter)"
echo
export PATH=${$(cat <(tr ':' '\n' <<< $PATH | grep "$USER" | sort -u) <(tr ':' '\n' <<< $PATH | grep -v "$USER" | sort -u) | grep -v '^$' | tr '\n' ':')%:}
