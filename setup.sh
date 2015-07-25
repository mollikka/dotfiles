#cleanup
source ~/dotfiles/cleanup.sh

#load vundle, vim plugin manager
git clone https://github.com/gmarik/Vundle.vim.git ~/.vimplugins/Vundle.vim

#link dotfiles to home directory
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/zshenv ~/.zshenv
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
mkdir -p ~/.config/terminator
ln -s ~/dotfiles/terminator/config ~/.config/terminator/config

vim +PluginInstall +qall
