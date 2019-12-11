#!/bin/sh
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off --output DP-2 --off --output DP3 --off --output VIRTUAL1 --off
~/dotfiles/polybar/launch.sh
nitrogen --restore
