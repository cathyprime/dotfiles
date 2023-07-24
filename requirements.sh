#!/bin/bash

if ! [[ $(cat /etc/os-release | grep 'NAME="Debian GNU/Linux"') || $1 == "--force" ]]; then
	echo "this script is made for debian based distributions (apt)"
	echo "if you don't have apt then stop this script and install these packages:"
	echo "- curl"
	echo "- git"
	echo "- fish (optional)"
	echo "then run chsh -s path/to/fish <username>"
	echo "and reboot the pc"
	echo "if you use apt in your distribution invoke this script with --force"
	exit 0
fi

while true; do
	echo "do you want to use nala instead of apt? (Y/n)"
	read apt_choice
	case $apt_choice in
	"n" | "N")
		pkg=apt
		break
		;;
	"y" | "Y" | "")
		sudo apt install nala -y
		pkg=nala
		break
		;;
	*) ;;
	esac
done

case $pkg in
"nala")
	sudo nala install curl git fish zsh -y
	;;
"apt")
	sudo apt install curl git fish zsh -y
	;;
esac

zsh_path=$(grep -o '/.*zsh' /etc/shells)
fish_path=$(grep -o '/.*fish' /etc/shells)
while true; do
	echo "choose default shell (Bash/zsh/fish):"
	echo "all shells will be setup"
	read shell_choice
	case $shell_choice in
	"bash" | "")
		break
		;;
	"zsh")
		chsh -s $zsh_path $USER
		break
		;;
	"fish")
		chsh -s $fish_path $USER
		break
		;;
	*) ;;
	esac
done

while true; do
	echo "install nvidia drivers? (Y/n)"
	read nvidia_choice
	case $nvidia_choice in
	"n" | "N")
		break
		;;
	"y" | "Y" | "")
		case $pkg in
		"nala")
			sudo nala install linux-headers-amd64 sed -y
			sudo sed -i 's/^deb http:\/\/deb\.debian\.org\/debian\/ bookworm main non-free-firmware$/deb http:\/\/deb.debian.org\/debian\/ bookworm main contrib non-free non-free-firmware/' /etc/apt/sources.list
			sudo nala update
			sudo nala install nvidia-driver firmware-misc-nonfree
			;;
		"apt")
			sudo apt install linux-headers-amd64 sed -y
			sudo sed -i 's/^deb http:\/\/deb\.debian\.org\/debian\/ bookworm main non-free-firmware$/deb http:\/\/deb.debian.org\/debian\/ bookworm main contrib non-free non-free-firmware/' /etc/apt/sources.list
			sudo apt update
			sudo apt install nvidia-driver firmware-misc-nonfree
			;;
		esac
		break
		;;
	*) ;;
	esac
done

touch ~/.config/zsh/.zshenv
mkdir -p ~/.config/bash
pushd ~/.config/bash/
ln -s ~/.config/zsh/.zshenv ./.bashenv
popd

while true; do
	echo "reboot? required for chsh, you have to reboot before running install script (y/N)"
	read reboot_choice
	case $reboot_choice in
	"n" | "N" | "")
		break
		;;
	"y" | "Y")
		sudo reboot
		;;
	*) ;;
	esac
done

echo "please reboot the pc"
