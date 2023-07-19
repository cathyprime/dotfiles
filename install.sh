#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

pushd ./home-manager/
./nix.sh
popd

bash home-manager/home.sh
bash scripts/font.sh
bash scripts/prestow.sh
bash scripts/stow.sh
if [ "$(basename $SHELL)" = "fish" ]; then
	echo -e "${RED}press <c-d> (ctrl + d) when you see: \"${GREEN}read${NC}>${RED}\"${NC}"
	fish scripts/fish.sh
	fish scripts/bob-nvim.sh
fi

while true; do
	echo "configure github cli?(y/n)"
	read gh_choice
	case $gh_choice in
	"y")
		gh auth login
		break
		;;
	"n")
		break
		;;
	*) ;;
	esac
done

while true; do
	if [ "$gh_choice" = "n" ]; then
		break
	else
		echo "configure neovim?(y/n)"
		read nvim_choice
		case $nvim_choice in
		"y")
			fish scripts/nvim.sh
			break
			;;
		"n")
			break
			;;
		*) ;;
		esac
	fi
done
