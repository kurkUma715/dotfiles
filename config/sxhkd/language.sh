#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/$USER/.Xauthority

current_layout=$(setxkbmap -query | awk '/layout/{print $2}')

if [ "$current_layout" = "us" ]; then
    setxkbmap ru
else
    setxkbmap us
fi
