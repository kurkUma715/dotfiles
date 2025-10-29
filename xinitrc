#!/bin/bash

xsetroot -cursor_name left_ptr &

dunst &
exec bspwm
