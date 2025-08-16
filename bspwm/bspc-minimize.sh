#!/bin/bash
# Toggle bspwm hidden flag and EWMH _NET_WM_STATE_HIDDEN property

wid=$(bspc query -N -n focused)

if [ -z "$wid" ]; then
    exit 1
fi

# Check if hidden in bspwm
if bspc query -N -n "${wid}.hidden" >/dev/null; then
    # Currently hidden → unhide
    bspc node "$wid" --flag hidden=off
    xprop -id "$wid" -remove _NET_WM_STATE
else
    # Currently visible → hide
    bspc node "$wid" --flag hidden=on
    xprop -id "$wid" -f _NET_WM_STATE 32a -set _NET_WM_STATE _NET_WM_STATE_HIDDEN
fi