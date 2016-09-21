#!/bin/sh

# vim

git clone https://github.com/VundleVim/Vundle.vim.git ~loki/.vim/bundle/Vundle.vim
mkdir -p ~loki/.vim/backup
mkdir -p ~loki/.vim/swap
mkdir -p ~loki/.vim/colors
mkdir -p ~loki/.vim/undo
cp vim/colors/* ~loki/.vim/colors/
cp vimrc ~loki/.vimrc
vim +PluginInstall +qall


# bash

cp bash_aliases ~loki/.bash_aliases
cp bash_profile ~loki/.bash_profile

# git

cp gitconfig ~loki/.gitconfig
cp gitignore_global ~loki/.gitignore_global

# stuff

cp tmux.conf ~loki/.tmux.conf
cp editorconfig ~loki/.editorconfig
