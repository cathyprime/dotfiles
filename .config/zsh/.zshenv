export EDITOR="nvim"
export GOPATH="$(go env GOPATH)"
PATH="${PATH}:${GOPATH}/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
PATH="$PATH:$HOME/.local/share/coursier/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.emacs.d/bin"

export PATH
