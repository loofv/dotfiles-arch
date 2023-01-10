#!/usr/bin/env bash
# sh ~/.config/polybar/pywal.sh ~/Downloads/national-park-4k-by-ai-1366×768.jpg
# Terminate already running bar instances
killall -q polybar
# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 5; done
# while pgrep -u $UID -x polybar >/dev/null; do sleep 5; done
while pgrep -x wal >/dev/null; do sleep 1; done
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch bar1 and bar2
#echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# echo "---" | tee -a /tmp/bar1.log
# polybar bar1 2>&1 | tee -a /tmp/bar1.log & disown
# polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

# Set pywal colors

source "${HOME}/.cache/wal/colors.sh"
background=$color15
# background=#FFFFFF
background_alt=$color15
foreground=$color15
primary=$color15
secondary=$color2
background_alt=$color3
foreground_alt=$color4
foreground_alt2=$color5

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload bar1 &
  done
else
  polybar --reload bar1 &
fi

echo "Bars launched..."
