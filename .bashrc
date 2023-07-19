eval "$(starship init bash)"

source ~/.nix-profile/etc/profile.d/hm-session-vars.sh

shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s extglob
shopt -s globasciiranges
shopt -s globstar

# >>> coursier install directory >>>
export PATH="$PATH:/home/yoolayna/.local/share/coursier/bin"
# <<< coursier install directory <<<
