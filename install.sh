#!/bin/bash

cd ./home-manager/
./nix.sh
cd ..
bash home-manager/home.sh
bash scripts/font.sh
bash scripts/prestow.sh
bash scripts/stow.sh
if [ "$(basename $SHELL)" = "fish" ]; then
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
