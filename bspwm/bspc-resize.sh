#!/usr/bin/env bash
# Usage: bspc-resize.sh <Left|Right|Up|Down> [amount]
# direction = which side to resize
# amount = pixels to resize (default: 20)

KEY="$1"
AMOUNT="${2:-20}"  # default resize step is 20 pixels

# Determine resize arguments
case "$KEY" in
    Left)  dir="west"; ;;
    Right) dir="east"; ;;
    Up)    dir="north"; ;;
    Down)  dir="south"; ;;
    *) exit 1 ;;
esac

# Resize the focused node
# -z <dx> <dy> where dx/dy are positive or negative depending on direction
case "$dir" in
    west)  bspc node -z left "-$AMOUNT" 0 ;;
    east)  bspc node -z right "$AMOUNT" 0 ;;
    north) bspc node -z top 0 "-$AMOUNT" ;;
    south) bspc node -z bottom 0 "$AMOUNT" ;;
esac
