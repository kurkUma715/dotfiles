#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars on specific monitors
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

# Primary monitor (adjust names according to your setup)
MONITOR=DP-0 polybar top -r >>/tmp/polybar1.log 2>&1 &

# Secondary monitor (if exists)
MONITOR=HDMI-2 polybar top -r >>/tmp/polybar2.log 2>&1 &

echo "Bars launched..."
