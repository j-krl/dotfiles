#!/bin/sh

mkdir -p ~/.config

# zsh
touch ~/.zshrc
sed -i.old '1s;^;source ~/dotfiles/zsh/zshrc\n;' ~/.zshrc

# tmux
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# git
mkdir -p ~/.config/git
ln -s ~/dotfiles/git/ignore ~/.config/git/ignore
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig

# vim/neovim
mkdir -p ~/.local/share/nvim/site
git clone https://github.com/k-takata/minpac.git ~/.local/share/nvim/site/pack/minpac/opt/minpac
git clone https://github.com/k-takata/minpac.git ~/.local/share/vim/site/pack/minpac/opt/minpac
ln -s ~/dotfiles/vim ~/.config/nvim
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
mkdir -p ~/.cache/vim/

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install neovim \
	vim \
	git \
	tmux \
	tree \
	colima \
	bash \
	docker \
	kubectl \
	fd \
	bat \
	ripgrep \
	fzf \
	jq \
	yq \
	pipx

# other
git clone https://github.com/Aloxaf/fzf-tab ~/.fzf-tab
