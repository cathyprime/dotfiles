fpath=($HOME/.config/zsh/completions $fpath)
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -U compinit;
autoload -U edit-command-line
compinit -i

HISTFILE=~/.config/zsh/zsh_history

stty -ixon

source ~/.cargo/env
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

function polygon() {
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
bindkey '' edit-command-line
bindkey "" history-incremental-search-backward
bindkey "" history-incremental-search-forward
bindkey "" up-line-or-search
bindkey "" down-line-or-search

setopt promptsubst
setopt promptpercent
setopt autolist
setopt sharehistory
unsetopt nointeractivecomments

alias amm=amm-31
alias clean-nvim='rm -rf ~/.local/share/nvim'
alias clip='xclip -sel c'
alias gs='git status'
alias la='eza -la --git --group-directories-first'
alias ls='eza --git --group-directories-first'
alias qmkcd='cd ~/Repositories/misc/qmk_firmware/'
alias ll='eza -l --git --group-directories-first'
alias nvide=neovide

function cocker() {
    case "$1" in
        "") docker compose ;;
        "raise") docker compose up -d "${@:2}" ;;
        "raze") docker compose down "${@:2}" ;;
        *) docker compose "$@" ;;
    esac
}

function man() {
    /usr/bin/man "$@" | col -b | bat --paging=always --style=plain -l man
}

function llg() {
    git rev-parse --is-inside-work-tree > /dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        git status
    fi
    eza -l --git --group-directories-first "$@"
}

function git-grep() {
    git log --oneline --all | fzf --preview 'git show --color=always {+1}' | sed 's#\([0-9a-f]\{7\}\) .*#\1#' | tr -d '\n' | xclip -sel c
}

function spath() {
    echo $PATH | sed 's/:/\n/g'
}

function docker() {
    case "$1" in
        "") command docker ;;
        "lazy") lazydocker ;;
        *) command docker "$@" ;;
    esac
}

function git() {
    case "$1" in
        "") command git ;;
        "lazy") lazygit ;;
        *) command git "$@" ;;
    esac
}

function start-gentoo() {
( qemu-system-x86_64 -m 8G -enable-kvm \
                     -cdrom ~/Downloads/gentoo-amd64-minimal-20230903T170202Z.iso \
                     -drive file=/home/yoolayna/qemu/gentoo.cow,format=qcow2 \
                     -boot order=d) &
                   disown
}

function lt() {
    if (( $# > 0 )); then
        eza --tree --long --icons --git --group-directories-first --level="$1"
    else
        eza --tree --long --icons --git --group-directories-first
    fi
}

function tw() {
    if tmux list-sessions 2>&1 | grep -Eqs "(no server running|no sessions|error connecting)"; then
        tmux-workspace
    else
        tmux attach
    fi
}

function task() {
    case "$1" in
        "") command task ;;
        "sync")
            pushd ~/Documents/task/
            make sync
            popd
            ;;
        *) command task "$@" ;;
    esac
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

function greeter() {
    local messages=(
        "VI VI VI"
    )
    local rand=$(( $RANDOM % ${#messages[@]} + 1))
    echo "${messages[$rand]}"
}

echo
echo
echo "$(date)"
echo "$(date +%Y) the year of linux desktop!"
echo "$(greeter)"
echo
export PATH=$(echo -n $PATH | tr ':' '\n' | sort -u | tr '\n' ':')
