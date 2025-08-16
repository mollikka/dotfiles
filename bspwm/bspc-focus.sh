#!/usr/bin/env bash
case "$1" in
    Left) dir=west ;;
    Right) dir=east ;;
    Up) dir=north ;;
    Down) dir=south ;;
    *) exit 1 ;;
esac

bspc node -f "$dir"
