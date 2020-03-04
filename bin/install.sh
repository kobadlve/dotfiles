#!/bin/bash

# Install dependencies
if [ "$(uname)" == 'Darwin' ]; then
  echo "Check Homebrew..."
  if ! which brew >/dev/null 2>&1; then
    echo "Homebrew install..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "Homebrew update..."
  brew update

  formulas=(
    git
    zsh
    zsh-completions
    zsh-syntax-highlighting
    zlib
    vim
    neovim
    the_silver_searcher
    tmux
    fzf
  )

  echo "Homebrew install fomulas..."
  for formula in "${formulas[@]}"; do
      brew install $formula
  done

  echo "Homebrew cleanup"
  brew cleanup
else
  formulas=(
    git
    zsh
    zsh-completions
    zsh-syntax-highlighting
    zlib
    vim
    neovim
    tmux
    fzf
  )

  echo "apt install fomulas..."
  for formula in "${formulas[@]}"; do
      sudo apt install -y $formula
  done
fi

echo "Dein Install..."
mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/repos/github.com/Shougo/dein.vim
cd ~/.vim/dein/repos/github.com/Shougo/dein.vim/bin
./install.sh ~/.vim/.cache
cd

echo "zplug install..."
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

echo "Finished!"
