#!/bin/sh

# vim

#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#mkdir -p ~/.vim/backup
#mkdir -p ~/.vim/swap
#mkdir -p ~/.vim/colors
#mkdir -p ~/.vim/undo
#cp vim/colors/* ~/.vim/colors/
#cp vimrc ~/.vimrc
##vim +PluginInstall +qall


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

~/.tmux/plugins/tpm/bin/install_plugins
