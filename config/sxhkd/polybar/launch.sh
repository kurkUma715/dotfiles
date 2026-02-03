#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

MONITOR=DP-0 polybar top -r >>/tmp/polybar1.log 2>&1 &

echo "Bars launched..."
