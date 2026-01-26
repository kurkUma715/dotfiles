#!/bin/bash

xrdb merge ~/.Xresources

setxkbmap -option grp:alt_shift_toggle us,ru
xsetroot -cursor_name left_ptr

dunst &
exec bspwm
