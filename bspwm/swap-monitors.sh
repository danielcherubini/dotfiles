#!/usr/bin/env bash

$HOME/dotfiles/autorandr/autorandr-cycle

if [[ $(autorandr --current) == "big" ]]; then
	$HOME/dotfiles/bspwm/monitor.sh eDP-1 DP-2
else
	$HOME/dotfiles/bspwm/monitor.sh DP-2 eDP-1
fi

$HOME/dotfiles/polybar/launch.sh
nitrogen --restore
