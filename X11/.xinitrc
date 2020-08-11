/etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export XDG_CONFIG_HOME = "$HOME/.config"
export SSH_AUTH_SOCK
export XDG_CURRENT_DESKTOP=XFCE
exec cinnamon-session
