#!/bin/sh

$HOME/dotfiles/autorandr/autorandr-cycle

query=`bspc query -M`
read -a monitors <<<$query

for monitor in ${monitors[@]}; do
	bspc monitor ${monitor} -r
done

bspc desktop Desktop -r
bspc wm -r

bspc wm -o
