#!/usr/bin/env bash

# move $2 to $1

for desktop in $(bspc query -D -m $1)
do
  bspc desktop $desktop --to-monitor $2
done


bspc query -D -m --names
bspc monitor $1 -r
bspc desktop Desktop -r
