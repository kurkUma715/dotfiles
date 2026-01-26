#!/bin/bash

MOUSE_NAME=10

xinput set-prop ${MOUSE_NAME} "libinput Accel Profile Enabled" 0, 0, 1 &
xinput set-prop ${MOUSE_NAME} "libinput Accel Speed" 0 &

xinput set-prop 8 "libinput Accel Profile Enabled" 0, 0, 1 &
xinput set-prop 8 "libinput Accel Speed" 0 &


xinput set-prop 18 "libinput Accel Profile Enabled" 0, 0, 1 &
xinput set-prop 18 "libinput Accel Speed" 0 &
