#!/bin/bash

pushd ~/.config/zsh
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
mkdir completion
pushd completion
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
popd
popd
echo "paste this into /etc/zsh/zshenv"
echo "ZDOTDIR=$HOME/.config/zsh"
