CONFIG="$HOME/.config"
standalone=(
    "$HOME/Repositories/"
    "$HOME/Downloads"
    "$HOME/Polygon"
    "$CONFIG/nvim"
)

function fd_search() {
    local path="$1"
    local depth="$2"
    /usr/bin/fd . "$path" --max-depth "$depth" --min-depth "$depth" -t d "${@:3}"
}

home=$(fd_search ~ 2 --ignore-file ~/.config/wezterm/.fdignore)
misc=$(fd_search ~/Repositories/misc 1)
school=$(fd_search ~/Repositories/school/ 1)

cat <(echo "$home") <(echo "$misc") <(echo "$school") <(printf '%s\n' "${standalone[@]}") | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2-
