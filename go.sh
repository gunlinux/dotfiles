#!/bin/sh

# vim

git clone https://github.com/VundleVim/Vundle.vim.git ~loki/.vim/bundle/Vundle.vim
cp -R vim/ ~loki/.vim
mkdir -p ~loki/backup
mkdir -p ~loki/swap
mkdir -p ~loki/undo

cp vimrc ~loki/.vimrc
vim +PluginInstall +qall


# bash

cp bash_aliases ~loki/.bash_aliases
cp bash_profile ~loki/.bash_profile

# git 

cp gitconfig ~loki/.gitconfig
cp gitignore_global ~loki/.gitignore_global

# stuff

cp editorconfig ~loki/.editorconfig
