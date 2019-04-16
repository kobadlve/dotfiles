# First load tmux
[[ -z "$TMUX" && ! -z "$PS1" ]] && exec tmux

# -- zplug --
source ~/.zplug/init.zsh
if [[ -a ~/.zsh/private.zsh ]]; then
  source ~/.zsh/private.zsh
fi

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# Then, source plugins and add commands to $PATH
zplug load --verbose

# -- Options --
autoload -U compinit
compinit

autoload -Uz colors; colors 

export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true

export HISTFILE=${HOME}/.zhistory
export HISTSIZE=10000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
setopt inc_append_history
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1

# -- Alias --
alias py="python"
alias py2="python2.7"
alias py3="python3"
alias gcm="git commit -m"
alias gt="git status"
alias gl="git log"
alias vim="nvim"

# -- ENV --

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

### python startup
export PYTHONSTARTUP=~/.pythonstartup.py

### rust
export PATH=${PATH}:"$HOME/.cargo/bin"
export RUST_SRC_PATH="$HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"

### go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

## rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

## dein.vim
export XDG_CONFIG_HOME="$HOME/.config"

## brew
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

## fzf
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

source $HOME/.cargo/env
export PATH=$PATH:/Users/koba/Library/Android/sdk/platform-tools

## Docker
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

