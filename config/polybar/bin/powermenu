#!/bin/env bash

choice=$(printf "Logout\nReboot\nShutdown" | rofi -dmenu)
case "$choice" in
  Logout) pkill -KILL -u "$USER" ;;
  Reboot) systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
