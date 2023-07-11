#!/bin/bash

# Options
help=0
connect=0
disconnect=0
status=0
update=0
timer=0

while getopts cdhsu: param; do
	case $param in
	c)
		if [[ $disconnect == 1 ]]; then
			echo "You can't connect and disconnect at the same time!"
			exit 1
		fi
		connect=1
		;;
	d)
		if [[ $connect == 1 ]]; then
			echo "You can't connect and disconnect at the same time!"
			exit 1
		fi
		disconnect=1
		;;
	h)
		echo "script that connects headphones[94:DB:56:6E:8F:9B] to this pc along"
		echo "with un/blocking using rfkill"
		echo
		echo
		echo -e "\t-c \t-- to connect headphones via bluetooth"
		echo -e "\t-d \t-- to disconnect headphones via bluetooth"
		echo -e "\t-h \t-- to see this help page"
		echo -e "\t-s \t-- to display connection status"
		echo -e "\t-u \t-- to update the connection status in X seconds, defaults to 15s"
		echo -e "\t\t\t"
		exit 0
		;;
	u)
		if [ $# -eq 0 ]; then
			timer=15
		else
			timer=$OPTARG
		fi
		update=1
		;;
	s)
		status=1
		;;
	*)
		echo -e "$(echo $0 | rev | cut -d / -f 1 | rev): invalid option -- '$(echo $key | rev | cut -d - -f 1 | rev)"\'
		echo "use -h or --help to see available options"
		exit 1
		;;
	esac
done

if [[ $connect == 1 ]]; then
	if headp -s | grep -q "connecting...\|diconnecting...\|killed\|have fun! :)\|done|connected"; then
		exit 0
	fi
	sleep 2
	echo "connecting..." >$HOME/.config/polybar/headp-status
	rfkill unblock bluetooth
	sleep 1
	/sbin/expect /home/yoolayn/.config/polybar/connect.exp
	echo "have fun! :)" >$HOME/.config/polybar/headp-status
	sleep 1
	echo "connected" >$HOME/.config/polybar/headp-status
	exit 0
fi

if [[ $disconnect == 1 ]]; then
	if headp -s | grep -q "connecting...\|diconnecting...\|killed\|have fun! :)\|done|disconnected"; then
		exit 0
	fi
	echo "disconnecting..." >$HOME/.config/polybar/headp-status
	bluetoothctl disconnect 94:DB:56:6E:8F:9B
	bluetoothctl power off
	rfkill block bluetooth
	echo "done        " >$HOME/.config/polybar/headp-status
	sleep 0.5
	echo "disconnected" >$HOME/.config/polybar/headp-status
	exit 0
fi

if [[ $status == 1 ]]; then
	cat $HOME/.config/polybar/headp-status
fi

if [[ $update == 1 ]]; then
	if [[ $timer -eq 0 ]]; then
		true
	else
		sleep $timer
	fi
	if bluetoothctl devices | cut -f2 -d' ' | bluetoothctl info | grep -q "Connected: yes"; then
		echo "connected" >$HOME/.config/polybar/headp-status
	else
		echo "disconnected" >$HOME/.config/polybar/headp-status
	fi
fi
