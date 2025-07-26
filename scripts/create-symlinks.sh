#variables
dotfiles_dir=~/dotfiles

#removing existing profiles
sudo rm -rf ~/.tmux > /dev/null 2>&1
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1
sudo rm -rf ~/.config > /dev/null 2>&1

#creating .config folder
mkdir -p ~/.config

#linking dotfiles to config files
ln -sf $dotfiles_dir/tmux ~/.config/tmux
ln -sf $dotfiles_dir/git/.gitconfig ~/.gitconfig
ln -sf $dotfiles_dir/git/.gitignore_global ~/.gitignore_global
ln -sf $dotfiles_dir/config ~/.config
