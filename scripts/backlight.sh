#!/bin/bash
#this needs an entry in the sudoers to work
#http://unix.stackexchange.com/questions/68897/how-to-set-permissions-in-sys-permanent
BACKLIGHTFILE="/sys/class/backlight/intel_backlight/brightness"
LOWLIGHT="200"
HIGHLIGHT="2500" #3125 is max on my laptop

if grep -qw $LOWLIGHT "$BACKLIGHTFILE"; then
  echo $HIGHLIGHT | sudo tee $BACKLIGHTFILE;
else
  echo $LOWLIGHT | sudo tee $BACKLIGHTFILE;
fi

