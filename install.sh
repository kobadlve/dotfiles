#!/bin/sh

echo "Start Installing..."

if [ "$1" = "macOS" ]
then
    echo "macOS"
    echo "brew updating..."
    brew update
    echo "brew installing..."
    brew install vim zsh tmux
elif [ "$1" = "Linux" ]
then
    echo "Linux"
    echo "apt-get updating..."
    sudo apt-get update
    echo "apt-get installing..."
    sudo apt-get install vim zsh tmux
else
    echo "Invalid argument"
    exit 1
fi

echo "Install dein"
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
cp vim/.vimrc ~/.vimrc
cp vim/.dein.yaml ~/.vim/

echo "Install zplug..."
curl -sL zplug.sh/installer | zsh
cp Zsh/.zshrc ~/.zshrc

cp tmux/.tmux.conf ~/.tmux.conf

exec $SHELL -l

