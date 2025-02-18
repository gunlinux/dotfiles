#!/bin/sh

# bash

ln -s ~/dotfiles/bash_aliases ~/.bash_aliases
cp -f ~/dotfiles/bashrc ~/.bashrc

# git
ln -s gitconfig ~/.gitconfig
ln -s gitignore_global ~/.gitignore_global

# stuff
mkdir -p ~/.config
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/editorconfig ~/.editorconfig
ln -s ~/dotfiles/wezterm.lua ~/.wezterm.lua
ln -s ~/dotfiles/nvim ~/.config/nvim

# tmux tpm manage
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [ "$EUID" -eq 0 ] ; then
  prefix=''
else
  prefix='sudo'
fi

# install deps
if [ -z "$DOCKER" ] && [ -f /etc/debian_version ]; then
  $prefix apt install -y ripgrep tmux fd-find
fi

# deps for arch
if [ -z "$DOCKER" ] && [ -f /etc/arch-release ]; then
  echo "i use arch btw"
  $prefix pacman -S ripgrep eza tmux
fi

nvim --headless "+Lazy! sync" +qa
~/.tmux/plugins/tpm/bin/install_plugins
