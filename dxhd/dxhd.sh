#!/bin/sh

# super + Return
kitty

# super + @space
rofi -show

# super + alt + {q,r}
bspc {quit,wm -r}

# super + shift + q
bspc node -c

# super + p
$HOME/dotfiles/bspwm/swap-monitors.sh

# super + P
$HOME/dotfiles/bspwm/swap-monitors.sh

# super + shift + plus
flameshot gui -d 500

# super + {t,shift + t,s,f}
bspc node -t {tiled,pseudo_tiled,floating,fullscreen}

# super + ctrl + {m,x,y,z}
bspc node -g {marked,locked,sticky,private}

# super + {_,shift + }{h,j,k,l}
bspc node -{f,s} {west,south,north,east}

# super + {p,b,comma,period}
bspc node -f @{parent,brother,first,second}

# super + {_,shift + }c
bspc node -f {next,prev}.local

# super + bracket{left,right}
bspc desktop -f {prev,next}.local

# super + {grave,Tab}
bspc {node,desktop} -f last

# super + shift + {1-9,0}
bspc node -d '^{1-9,10}' -f

# super + {1-9,0}
bspc desktop -f '^{1-9,10}'

## preselect the direction
# super + ctrl + {h,j,k,l}
bspc node -p {west,south,north,east}

## preselect the ratio
# super + ctrl + {1-9}
bspc node -o 0.{1-9}

## cancel the preselection for the focused node
# super + ctrl + space
bspc node -p cancel

## cancel the preselection for the focused desktop
# super + ctrl + shift + space
bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel


## expand a window by moving one of its side outward
# super + alt + {Left,Down,Up,Right}
bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}

## contract a window by moving one of its side inward
# super + alt + shift + {Left,Down,Up,Right}
bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}

## move a floating window
# super + {Left,Down,Up,Right}
bspc node -v {-20 0,0 20,0 -20,20 0}



## Media Keys
#XF86AudioMute
$HOME/dotfiles/utils/volume.sh mute
#XF86AudioRaiseVolume
$HOME/dotfiles/utils/volume.sh up
#XF86AudioLowerVolume
$HOME/dotfiles/utils/volume.sh down

#XF86MonBrightnessUp
$HOME/dotfiles/utils/brightness.sh up
#XF86MonBrightnessDown
$HOME/dotfiles/utils/brightness.sh down
