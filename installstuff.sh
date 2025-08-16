#!/bin/sh

if [ $# == 1 ] && [ $1 == "visual" ]; then
  echo "Installing cli and visual stuff"
elif [ $# == 1 ] && [ $1 == "cli" ]; then
  echo "Installing cli stuff"
else
  echo "Usage: $0 [cli|visual]"
  exit;
fi

if [ -x "$(command -v pacman)" ]; then
  echo "Using pacman to install stuff"
  sudo pacman -S zsh git gvim openssh
  if [ $1 == "visual" ]; then
    sudo pacman -S bspwm sxhkd rxvt-unicode alsa-utils urxvt-perls xfce4-panel
  fi
else
  echo "I don't know how to install stuff for you :("
fi
