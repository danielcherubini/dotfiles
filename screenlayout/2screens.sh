#!/bin/sh
xrandr --output eDP-1 --mode 1920x1080 --pos 0x360 --rotate normal --output DP1 --off --output DP-2 --primary --mode 2560x1440 --pos 1920x0 --rotate normal --output DP3 --off --output VIRTUAL1 --off
~/dotfiles/polybar/launch.sh
nitrogen --restore
