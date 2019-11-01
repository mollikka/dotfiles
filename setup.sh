#!/bin/bash
if [ -z "$HOME" ]; then
    echo "Home directory not detected."
    exit 1
fi

#cleanup
source $HOME/dotfiles/cleanup.sh

set -euf -o pipefail

#link dotfiles to home directory
mkdir -p $HOME/.config
ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/zshenv $HOME/.zshenv
ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/git/gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/x/xinitrc $HOME/.xinitrc
#link gui preference files
ln -s $HOME/dotfiles/awesome $HOME/.config/awesome
mkdir -p $HOME/.config/OpenSCAD/
ln -s $HOME/dotfiles/openscad/openscad.conf $HOME/.config/OpenSCAD/OpenSCAD.conf
ln -s $HOME/dotfiles/x/xscreensaver $HOME/.xscreensaver
ln -s $HOME/dotfiles/gimp $HOME/.gimp-2.8

#load vim plugins
if [ -x "$(command -v vim)" ] && [ -x "$(command -v git)" ]; then
  echo "Loading Vim plugins"
  #load vundle, vim plugin manager
  git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vimplugins/Vundle.vim

  #install plugins
  vim +PluginInstall +qall -u $HOME/dotfiles/vim/vimplugins
else
  echo "Skipped Vim plugins"
fi

#load zsh plugins
if grep -qE "/zsh$" /etc/shells && [ -x "$(command -v git)" ]; then
  echo "Loading Zsh plugins"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zshplugins/zsh-syntax-highlighting
else
  echo "Skipping Zsh plugins"
fi

#load awesome plugins
if [ -x "$(command -v awesome)" ] && [ -x "$(command -v git)" ]; then
  echo "Loading Awesome plugins"
  #load awesome plugins
  git clone http://git.sysphere.org/vicious $HOME/.awesomeplugins/vicious
  git clone https://github.com/copycat-killer/vain-again.git $HOME/.awesomeplugins/vain
else
  echo "Skipping Awesome plugins"
fi
