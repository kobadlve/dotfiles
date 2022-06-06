# kill detached tmux session
type tmux > /dev/null 2>&1
if [ $? -eq 0 ] ; then
  session_exist="`tmux list-sessions | grep -v attached`"
  if [[ $session_exist ]] ; then
    echo $session_exist
    echo "Do you close detached tmux session?(y/N): "
    if read -q; then
      echo "Closing detaching session"
      tmux list-sessions | grep -v attached | cut -d: -f1 |  xargs -t -n1 tmux kill-session -t
    else
      echo "Session existing"
    fi
  fi
fi
# First load tmux
if [ -t 0 ] && [[ -z $TMUX ]] && [[ $- = *i* ]]; then
  echo "Start tmux"
  exec tmux
fi

# -- zplug --
source ~/.zplug/init.zsh
if [[ -a ~/.zsh/private.zsh ]]; then
  source ~/.zsh/private.zsh
fi

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug "rupa/z", use:z.sh

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

export LC_ALL=en_US.UTF-8
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

KEYTIMEOUT=1

# ^o = z + fzf (directory search)
fzf-z-search() {
    local res=$(z | sort -rn | cut -c 12- | fzf)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
    fi
}
zle -N fzf-z-search
bindkey '^o' fzf-z-search

# -- Alias --
alias py="python"
alias py2="python2.7"
alias py3="python3"
alias gcm="git commit -m"
alias gt="git status"
alias gl="git log"
alias vim="nvim"

# hub command
# function git(){hub "$@"}

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
source $HOME/.cargo/env

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
  BUFFER=$(history -n -r 1 | fzf +m --no-sort --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

function select-sort-history() {
  BUFFER=$(history -n -r 1 | fzf +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-sort-history
bindkey '^u' select-sort-history

## Android
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools
export PATH=$PATH:$HOME/Library/Android/sdk/build-tools/30.0.3

## Docker
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

## nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

## ITerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

## ctags
alias ctags='/usr/local/Cellar/universal-ctags/HEAD-9b28d8c/bin/ctags'

## z command
. ~/z/z.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi

source ~/google-cloud-sdk/path.zsh.inc
source ~/google-cloud-sdk/completion.zsh.inc

# The next line enables shell command completion for ggit remote add google \
# https://source.developers.google.com/p/[PROJECT_NAME]/r/[REPO_NAME]cloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
# export MONO_GAC_PREFIX="/usr/local"

# AWS CLI completion
# complete -C '/usr/local/bin/aws_completer' aws
# complete -C `which aws_completer` awslocal
#
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/local/bin/terraform terraform

# Omnisharp
export PATH=/usr/local/share/dotnet/dotnet:$PATH

# Unity
# export JAVA_HOME="/Applications/Unity/Hub/Editor/2020.3.18f1/PlaybackEngines/AndroidPlayer/OpenJDK"
# export ANDROID_HOME=/Applications/Unity/Hub/Editor/2020.3.18f1/PlaybackEngines/AndroidPlayer/SDK
# export ANDROID_SDK_HOME=/Applications/Unity/Hub/Editor/2020.3.18f1/PlaybackEngines/AndroidPlayer/SDK
# export ANDROID_AVD_HOME=/Users/$USER/.android/avd
# export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_AVD_HOME

# Flutter
export PATH="$PATH:$HOME/dev/flutter/flutter/bin"
