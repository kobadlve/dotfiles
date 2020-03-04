#!/bin/bash

dir=$(cd $(dirname $0/); cd ../; pwd)

# git
ln -snfv $dir/git/.gitignore_global ~/.gitignore_global

# vim
cp -r $dir/vim/colors ~/.vim/
ln -snfv $dir/vim/.vimrc ~/.vimrc
ln -snfv $dir/vim/.dein.toml ~/.vim/.dein.toml

# neovim
mkdir -p ~/.config/nvim/.vim
cp -r $dir/vim/colors ~/.config/nvim/
ln -snfv $dir/.vim/ ~/.config/nvim/.vim

# zsh
ln -snfv $dir/zsh/.zshrc ~/.zshrc

# tmux
ln -snfv $dir/tmux/.tmux.conf ~/.tmux.conf

# dev
ln -snfv $dir/dev/.pythonstartup.py ~/.pythonstartup.py

# hyper
ln -snfv $dir/hyper/.hyper.js ~/.hyper.js
