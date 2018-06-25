#!/bin/bash

apt-get update

apt-get install git zsh vim 

apt-get autoclean

echo "Dein..."
mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/repos/github.com/Shougo/dein.vim
cd ~/.vim/dein/repos/github.com/Shougo/dein.vim/bin
./install.sh ~/.vim/.cache
cd

echo "zplug"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

# link
echo "Make link..."
./link.sh

echo "Finished!"
