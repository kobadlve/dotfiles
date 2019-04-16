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

# tmux
ln -snfv $dir/tmux/.tmux.conf ~/.tmux.conf

# dev
ln -snfv $dir/dev/.pythonstartup.py ~/.pythonstartup.py

# hyper
ln -snfv $dir/hyper/.hyper.js ~/.hyper.js
