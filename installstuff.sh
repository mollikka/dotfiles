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
  sudo pacman -S zsh git vim openssh
  if [ $1 == "visual" ]; then
    sudo pacman -S bspwm sxhkd xscreensaver imagemagick chromium rxvt-unicode alsa-utils urxvt-perls compton
  fi
elif [ -x "$(command -v apt-get)" ]; then
  echo "Using apt to install stuff"
  sudo apt-get install vim zsh git
  if [ $1 == "visual" ]; then
    sudo apt-get install xscreensaver rxvt-unicode unclutter chromium-browser compton
  fi
elif [ -x "$(command -v zypper)" ]; then
  echo "Using zypper to install stuff"
  sudo zypper install zsh git vim
  if [ $1 == "visual" ]; then
    sudo zypper install unclutter xscreensaver ImageMagick chromium rxvt-unicode alsa-utils urxvt-perls compton
  fi
else
  echo "I don't know how to install stuff for you :("
fi
