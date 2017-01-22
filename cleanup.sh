#!/bin/sh
if [ -z "$HOME" ]; then
    echo "Home directory not detected."
    exit 1
fi

rm -rf $HOME/.vimplugins
rm -rf $HOME/.zshplugins
rm -rf $HOME/.awesomeplugins

rm -r $HOME/old_dotfiles
mkdir $HOME/old_dotfiles
mv $HOME/.zshrc $HOME/old_dotfiles/
mv $HOME/.zshenv $HOME/old_dotfiles/
mv $HOME/.vimrc $HOME/old_dotfiles/
mv $HOME/.gitconfig $HOME/old_dotfiles/
mv $HOME/.xinitrc $HOME/old_dotfiles/
mv $HOME/.config/awesome $HOME/old_dotfiles/
mv $HOME/.config/xfce4/terminal/terminalrc $HOME/old_dotfiles/
mv $HOME/.config/OpenSCAD/OpenSCAD.conf $HOME/old_dotfiles/
mv $HOME/.xscreensaver $HOME/old_dotfiles/
mv $HOME/.gimp-2.8 $HOME/old_dotfiles/
