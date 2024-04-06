#!/bin/sh

# vim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/undo
cp vim/colors/* ~/.vim/colors/
cp vimrc ~/.vimrc
vim +PluginInstall +qall


# bash

cp bash_aliases ~/.bash_aliases
cp bashrc ~/.bashrc

# git

cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore_global

# stuff

cp tmux.conf ~/.tmux.conf
cp editorconfig ~/.editorconfig
cp wezterm.lua ~/.wezterm.lua
