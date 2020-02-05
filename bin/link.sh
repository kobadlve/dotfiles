#!/bin/bash

dir=~/dotfiles

# git
ln -snfv $dir/git/.gitignore_global

# vim
cp -r $dir/vim/colors ~/.vim/colors
ln -snfv $dir/vim/.vimrc ~/.vimrc
ln -snfv $dir/vim/.dein.toml ~/.vim/.dein.toml

# neovim
cp -r $dir/vim/colors ~/.config/nvim/colors
ln -snfv $dir/.vim/ ~/.config/nvim/.vim

# zsh
ln -snfv $dir/zsh/.zshrc ~/.zshrc

# tmux
ln -snfv $dir/tmux/.tmux.conf ~/.tmux.conf

# dev
ln -snfv $dir/dev/.pythonstartup.py ~/.pythonstartup.py

# hyper
ln -snfv $dir/hyper/.hyper.js ~/.hyper.js
