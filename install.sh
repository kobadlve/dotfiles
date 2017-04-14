#!/bin/sh

echo "Start Installing..."

if [ "$1" = "macOS" ]
then
    echo "macOS"
    echo "brew updating..."
    #brew update
    echo "brew installing..."
    #brew install vim zsh tmux
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

