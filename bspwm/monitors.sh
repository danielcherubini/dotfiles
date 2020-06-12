#!/bin/bash

declare -a monitorarr
monitors=0
monitor_order=""
for m in $(xrandr --listactivemonitors | grep "DP" | cut -d " " -f6); do
# for m in $(bspc query -M --names); do
	monitorarr[$monitors]=$m
	monitor_order+="$m "
	((monitors++))
done


case "$monitors" in
	"1" )
		echo "1"
		echo $monitor_order
		bspc monitor ${monitorarr[0]} -d 1 2 3 4 5 6 7 8 9 10
		;;
	"2" )
		echo "2"
		echo $monitor_order

		xrandr --output ${monitorarr[0]} --auto --primary --output ${monitorarr[1]} --auto --output ${monitorarr[1]} --left-of ${monitorarr[0]}
		bspc monitor ${monitorarr[1]} -d 1 2 3 4 5
		bspc monitor ${monitorarr[0]} -d 6 7 8 9 10
		# bspc monitor ${monitorarr[1]} -s ${monitorarr[0]}
		;;
esac
