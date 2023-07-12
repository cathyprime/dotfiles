#!/usr/bin/env sh

killall headp
killall expect
rfkill unblock bluetooth
sleep 0.5
echo "killed" > ~/.config/polybar/headp-status
sleep 2
echo "disconnected" > ~/.config/polybar/headp-status
bluetoothctl remove 94:DB:56:6E:8F:9B
rfkill block bluetooth
