#!/bin/bash

#eval $(gnome-keyring-daemon --start)
#export SSH_AUTO_SOCK

#export GTK_USE_PORTAL=1
#export XDG_CURRENT_DESKTOP=GTK

#/usr/lib/polkit-kde-authentication-agent-1 &
#/usr/lib/kglovalaccel5 & 
#kdeconnectd &

dunst &

exec bspwm
