#!/bin/bash

for f in .??*; do
    [ "$f" = ".git" ] && continue
done

dir=`pwd`

# vim
cp -r $dir/vim/colors ~/.vim/colors
ln -snfv $dir/vim/.vimrc ~/.vimrc
ln -snfv $dir/vim/.dein.toml ~/.vim/.dein.toml

# zsh
ln -snfv $dir/zsh/.zshrc ~/.zshrc

# dev
ln -snfv $dir/dev/.pythonstartup.py ~/.pythonstartup.py

