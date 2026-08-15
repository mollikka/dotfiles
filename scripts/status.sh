#!/bin/sh

battery=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n1)
time=$(date '+%Y-%m-%d %H:%M:%S')
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

notify-send -h string:x-dunst-stack-tag:status-script \
"Status" \
"Time: $time
$volume
Battery: ${battery:-?}%"
