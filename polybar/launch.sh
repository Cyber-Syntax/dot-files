#!/usr/bin/env bash

# Kill running bar
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
#polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar mybar 2>&1 | tee -a /tmp/polybar1.log & disown
polybar mybar2 2>&1 | tee -a /tmp/polybar2.log & disown
polybar mybar3 2>&1 | tee -a /tmp/polybar3.log & disown


# Launch indicator-sound-switcher
#       indicator-sound-switcher
echo "Bars launched..."
