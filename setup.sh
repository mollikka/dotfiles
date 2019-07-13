#!/bin/bash
if [ -z "$HOME" ]; then
    echo "Home directory not detected."
    exit 1
fi

#cleanup
source $HOME/dotfiles/cleanup.sh

set -euf -o pipefail

#load vundle, vim plugin manager
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vimplugins/Vundle.vim

#link dotfiles to home directory
mkdir -p $HOME/.config
ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/zshenv $HOME/.zshenv
ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/git/gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/x/xinitrc $HOME/.xinitrc

#load vim plugins
vim +PluginInstall +qall -u $HOME/dotfiles/vim/vimplugins

#load zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zshplugins/zsh-syntax-highlighting

#load gui stuff
if [ "${1:-nope}" == "gui" ];
then
  #link dotfiles to home directory
  ln -s $HOME/dotfiles/awesome $HOME/.config/awesome
  mkdir -p $HOME/.config/OpenSCAD/
  ln -s $HOME/dotfiles/openscad/openscad.conf $HOME/.config/OpenSCAD/OpenSCAD.conf
  ln -s $HOME/dotfiles/x/xscreensaver $HOME/.xscreensaver
  ln -s $HOME/dotfiles/gimp $HOME/.gimp-2.8

  #load awesome plugins
  git clone http://git.sysphere.org/vicious $HOME/.awesomeplugins/vicious
  git clone https://github.com/copycat-killer/vain-again.git $HOME/.awesomeplugins/vain
fi

