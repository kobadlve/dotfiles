# Dotfiles

## Requirements

* zsh
* zplug
* vim
* dein.vim
* tmux

## Command

* `curl -sL zplug.sh/installer | zsh`

Install prezto
``` 
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```
