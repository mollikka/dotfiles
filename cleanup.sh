rm -rf ~/.vimplugins
rm -rf ~/.zshplugins

rm -r ~/old_dotfiles
mkdir ~/old_dotfiles
mv ~/.zshrc ~/old_dotfiles/
mv ~/.zshenv ~/old_dotfiles/
mv ~/.vimrc ~/old_dotfiles/
mv ~/.gitconfig ~/old_dotfiles/
mv ~/.config/xfce4/terminal/terminalrc ~/old_dotfiles/
mv ~/.tmux.conf ~/old_dotfiles/
mv ~/.config/OpenSCAD/OpenSCAD.conf ~/old_dotfiles/
