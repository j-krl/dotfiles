#!/bin/sh

mkdir -p ~/.config

# zsh
touch ~/.zshrc
sed -i.old '1s;^;source ~/dotfiles/zsh/.zshrc\n;' ~/.zshrc
git clone https://github.com/Aloxaf/fzf-tab ~/.fzf-tab

# tmux
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

# git
mkdir -p ~/.config/git
ln -s ~/dotfiles/git/ignore ~/.config/git/ignore
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig

# vim/neovim
mkdir -p ~/.local/share/nvim/site
mkdir -p ~/.local/share/vim/site
git clone https://github.com/k-takata/minpac.git ~/.local/share/nvim/site/pack/minpac/opt/minpac
git clone https://github.com/k-takata/minpac.git ~/.local/share/vim/site/pack/minpac/opt/minpac
ln -s ~/dotfiles/vim ~/.config/nvim
ln -s ~/dotfiles/vim ~/.vim
mkdir -p ~/.cache/vim/
