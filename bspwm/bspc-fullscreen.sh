#!/usr/bin/env bash

if [ -z "$(bspc query -N -n focused.fullscreen)" ]; then
  bspc node focused -t fullscreen;
else
  bspc node focused -t tiled;
fi
