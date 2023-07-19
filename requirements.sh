#!/bin/bash

if ! [[ $(cat /etc/os-release | grep 'NAME="Debian GNU/Linux"') || $1 == "--force" ]]; then
	echo "this script is made for debian based distributions (apt)"
	echo "if you don't have apt then stop this script and install these packages:"
	echo "- curl"
	echo "- git"
	echo "- fish"
	echo "then run chsh -s path/to/fish <username>"
	echo "and reboot the pc"
	echo "if you use apt in your distribution invoke this script with --force"
	exit 0
fi
echo "do you want to use nala instead of apt? (y/n)"

while true; do
	read apt_choice
	case $apt_choice in
	"n")
		pkg=apt
		break
		;;
	"y")
		sudo apt install nala -y
		pkg=nala
		break
		;;
	*)
		echo "do you want to use nala instead of apt? (y/n)"
		;;
	esac
done

case $pkg in
"nala")
	sudo nala install curl git fish -y
	;;
"apt")
	sudo apt install curl git fish -y
	;;
esac

echo

fish_path=$(grep -o '/.*fish' /etc/shells)
chsh -s $fish_path $USER

echo "install nvidia drivers? (y/n)"
while true; do
	read nvidia_choice
	case $nvidia_choice in
	"n")
		break
		;;
	"y")
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
	*)
		echo "install nvidia drivers? (y/n)"
		;;
	esac
done

echo "reboot? required for chsh, you have to reboot before running install script (y/n)"
while true; do
	read reboot_choice
	case $reboot_choice in
	"n")
		break
		;;
	"y")
		sudo reboot
		;;
	*)
		echo "reboot? required for chsh, you have to reboot before running install script (y/n)"
		;;
	esac
done

echo "please reboot the pc"
