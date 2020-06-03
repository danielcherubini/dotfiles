#!/bin/bash

declare -a monitors
i=0
for m in $(xrandr --listactivemonitors | grep "DP" | cut -d " " -f6); do
# for m in $(bspc query -M); do
	monitors[$i]=$m
	((i++))
done

echo ${monitors[0]}
echo ${monitors[1]}

if [[ ${#monitors[@]} == 1 ]]; then
	xrandr --output eDP-1 --auto --primary
else
	xrandr --output eDP-1 --auto --primary --output DP-2 --auto --output ${monitors[1]} --left-of eDP-1
fi
