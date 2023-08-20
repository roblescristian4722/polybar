#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
sleep 0.5
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
# echo "---" | tee -a /tmp/polybar1.log
# polybar base #2>&1 | tee -a /tmp/polybar1.log & disown
# polybar secondary 2>&1 | tee -a /tmp/polybar2.log & disown

if type "xrandr"; then
    MONITOR=$m polybar --reload base &
    for m in $(xrandr --query | grep " connected" | awk -F ' ' 'NR > 1 {print $1}'); do
        MONITOR=$m polybar --reload secondary &
        sleep 0.2
    done
else
    polybar --reload base &
fi

echo "Bars launched..."
