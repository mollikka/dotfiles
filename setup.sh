#cleanup
source ~/dotfiles/cleanup.sh

#load vundle, vim plugin manager
git clone https://github.com/gmarik/Vundle.vim.git ~/.vimplugins/Vundle.vim

#link dotfiles to home directory
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/zshenv ~/.zshenv
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
mkdir -p ~/.config/xfce4/terminal/
ln -s ~/dotfiles/xfce4/terminalrc ~/.config/xfce4/terminal/terminalrc
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

#load vim plugins
vim +PluginInstall +qall

#load zsh plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zshplugins/zsh-syntax-highlighting
