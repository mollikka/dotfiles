#!/usr/bin/env bash

# Use strict error handling just like your 1Password script
set -euo pipefail

# 1. Get IDs of all hidden windows
hidden_ids=$(bspc query -N -n .hidden)

if [ -z "$hidden_ids" ]; then
    echo "No minimized windows found."
    exit 0
fi

# 2. Format the list: "ID|Title"
MATCHES=$(for id in $hidden_ids; do
    title=$(xprop -id "$id" WM_NAME 2>/dev/null | awk -F '"' '{print $2}')
    if [ -z "$title" ]; then
        title=$(xprop -id "$id" WM_CLASS 2>/dev/null | awk -F '"' '{print $4}')
    fi
    if [ -z "$title" ]; then
        title="Untitled Window"
    fi
    printf "%s|%s\n" "$id" "$title"
done)

SELECTION=$(echo "$MATCHES" | fzf --delimiter='\|' --with-nth=2 --reverse --prompt="Restore window: " --height=40%)

# Exit early if the user cancelled out of fzf (e.g., hit ESC)
if [[ -z "$SELECTION" ]]; then
    echo "No window selected."
    exit 0
fi

# Extract the ID safely (everything before the first '|')
win_id=$(echo "$SELECTION" | cut -d'|' -f1)

# Restore the selected window
bspc node "$win_id" -g hidden=off -f
