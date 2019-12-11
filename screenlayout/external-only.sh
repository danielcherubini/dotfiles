#!/bin/sh
xrandr --output eDP-1 --off --output DP-1 --off --output DP-2 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-3 --off
~/dotfiles/polybar/launch.sh
nitrogen --restore
