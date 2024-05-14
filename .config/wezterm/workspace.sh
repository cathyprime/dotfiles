CONFIG="$HOME/.config"
standalone=(
    "$CONFIG/nvim"
    "$HOME/.config/nvim"
    "$HOME/.config/nvim-test"
    "$HOME/Downloads"
    "$HOME/Polygon"
    "$HOME/Repositories/"
)

function fd_search() {
    local path="$1"
    local depth="$2"
    /usr/bin/fd . "$path" --max-depth "$depth" --min-depth "$depth" -t d "${@:3}"
}

home=$(fd_search ~ 2 --ignore-file ~/.config/wezterm/.fdignore)
misc=$(fd_search ~/Repositories/misc 1)
school=$(fd_search ~/Repositories/school/ 1)
nvim_plugins=$(fd_search ~/Repositories/neovim-plugins 1)

cat <(echo "$home") \
    <(echo "$misc") \
    <(echo "$school") \
    <(echo "$nvim_plugins") \
    <(printf '%s\n' "${standalone[@]}") \
    | awk '{ print length, $0 }' \
    | sort -ns \
    | uniq \
    | cut -d" " -f2-
