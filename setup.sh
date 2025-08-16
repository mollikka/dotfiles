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
mkdir -p $HOME/.config/bspwm
mkdir -p $HOME/.config/sxhkd
ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/zshenv $HOME/.zshenv
ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/git/gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/x/xinitrc $HOME/.xinitrc
ln -s $HOME/dotfiles/bspwm/bspwmrc $HOME/.config/bspwm/bspwmrc
ln -s $HOME/dotfiles/bspwm/sxhkdrc $HOME/.config/sxhkd/sxhkdrc

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
  git clone https://github.com/zsh-users/zsh-history-substring-search.git $HOME/.zshplugins/zsh-history-substring-search.git
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.zshplugins/zsh-autosuggestions.git
  git clone https://github.com/jeffreytse/zsh-vi-mode.git $HOME/.zshplugins/zsh-vi-mode.git
else
  echo "Skipping Zsh plugins"
fi
