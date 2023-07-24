#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

bash home-manager/nix.sh
bash home-manager/home.sh
bash scripts/font.sh
bash scripts/prestow.sh
bash scripts/stow.sh

if [ "$(basename $SHELL)" = "fish" ]; then
	echo -e "${RED}press <c-d> (ctrl + d) when you see: \"${GREEN}read${NC}>${RED}\"${NC}"
	fish scripts/fish.sh
	fish scripts/bob-nvim.sh
fi

if [ "$(basename $SHELL)" = "zsh" ]; then
	zsh scripts/zsh.sh
	zsh scripts/bob-nvim.sh
fi

if [ "$(basename $SHELL)" = "bash" ]; then
	bash scripts/bash.sh
	bash scripts/bob-nvim.sh
fi

while true; do
	echo "configure github cli?(Y/n)"
	read gh_choice
	case $gh_choice in
	"y" | "Y" | "")
		gh auth login
		break
		;;
	"n" | "N")
		break
		;;
	*) ;;
	esac
done

while true; do
	if [ "$gh_choice" = "n" ]; then
		break
	else
		echo "configure neovim?(Y/n)"
		read nvim_choice
		case $nvim_choice in
		"y" | "Y" | "")
			fish scripts/nvim.sh
			break
			;;
		"n" | "N")
			break
			;;
		*) ;;
		esac
	fi
done

bash systemd/install.sh
