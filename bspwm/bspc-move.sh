#!/usr/bin/env bash
# $1 = key pressed (Left, Right, Up, Down)
case "$1" in
    Left) dir=west ;;
    Right) dir=east ;;
    Up) dir=north ;;
    Down) dir=south ;;
    *) exit 1 ;;
esac

# Swap inside monitor if neighbor exists, else move to next monitor
if bspc query -N -n "$dir.local" >/dev/null 2>&1; then
    bspc node -s "$dir.local"
else
    bspc node -m "$dir" --follow
fi
