#!/bin/bash
if [ -z "$HOME" ]; then
    echo "Home directory not detected."
    exit 1
fi

#cleanup
source $HOME/dotfiles/cleanup.sh

set -euf -o pipefail

ask() {
  local prompt="$1"
  local answer

  while true; do
    read -r -p "$prompt [Y/n] " answer
    answer="${answer:-y}"

    case "$answer" in
      [Yy]|[Yy][Ee][Ss])
        return 0
        ;;
      [Nn]|[Nn][Oo])
        return 1
        ;;
      *)
        echo "Please answer yes or no."
        ;;
    esac
  done
}

# basics

echo "Installing zsh, vim, git config"

ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/zshenv $HOME/.zshenv
ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/git/gitconfig $HOME/.gitconfig

if ask "Install Bspwm GUI configuration?"; then
  mkdir -p $HOME/.config
  mkdir -p $HOME/.config/bspwm
  mkdir -p $HOME/.config/sxhkd
  mkdir -p $HOME/.config/qutebrowser
  ln -s $HOME/dotfiles/x/xinitrc $HOME/.xinitrc
  ln -s $HOME/dotfiles/bspwm/bspwmrc $HOME/.config/bspwm/bspwmrc
  ln -s $HOME/dotfiles/bspwm/sxhkdrc $HOME/.config/sxhkd/sxhkdrc
  ln -s $HOME/dotfiles/qutebrowser/config.py $HOME/.config/qutebrowser/config.py
fi

if ask "Install Vim plugins?"; then
  #load vim plugins
  if [ -x "$(command -v vim)" ] && [ -x "$(command -v git)" ]; then
    echo "Loading Vim plugins"
    #load vundle, vim plugin manager
    git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vimplugins/Vundle.vim

    #install plugins
    vim +PluginInstall +qall -u $HOME/dotfiles/vim/vimplugins
  else
    echo "Skipped Vim plugins: vim or git not found"
  fi
fi

if ask "Install zsh plugins?"; then
  #load zsh plugins
  if grep -qE "/zsh$" /etc/shells && [ -x "$(command -v git)" ]; then
    echo "Loading Zsh plugins"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zshplugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-history-substring-search.git $HOME/.zshplugins/zsh-history-substring-search.git
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.zshplugins/zsh-autosuggestions.git
    git clone https://github.com/jeffreytse/zsh-vi-mode.git $HOME/.zshplugins/zsh-vi-mode.git
  else
    echo "Skipping Zsh plugins: zsh or git not found"
  fi
fi
