#!/bin/bash

pushd ~/.config/zsh
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
mkdir completion
pushd completion
git clone https://github.com/nix-community/nix-zsh-completions
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
popd
popd
sudo echo 'ZDOTDIR=$HOME/.config/zsh' >> /etc/zsh/zshenv
