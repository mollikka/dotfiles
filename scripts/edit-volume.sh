wpctl set-volume @DEFAULT_AUDIO_SINK@ $1

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

notify-send -h string:x-dunst-stack-tag:edit-volume-script "$volume"
