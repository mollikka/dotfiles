#cleanup
source ~/dotfiles/cleanup.sh

#load vundle, vim plugin manager
git clone https://github.com/gmarik/Vundle.vim.git ~/dotfiles/vimplugins/Vundle.vim

#link dotfiles to home directory
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/zshenv ~/.zshenv
ln -s ~/dotfiles/zsh/zshaliases ~/.zshaliases
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
