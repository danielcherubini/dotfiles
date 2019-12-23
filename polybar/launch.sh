#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for m in $(xrandr --listactivemonitors | grep "DP" | cut -d " " -f6); do
	echo $m
	MONITOR=$m polybar --reload main &
done
