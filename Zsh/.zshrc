# -- zplug --
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "yous/lime"

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

export HISTFILE=${HOME}/.zhistory
export HISTSIZE=1000
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
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew"
alias gcm="git commit -m"

# -- Lang Settings --

## go
export PATH="/usr/local/sbin:$PATH"
export GOPATH=$HOME/.go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export GOROOT=/usr/local/opt/go/libexec

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

## rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

## dein.vim
export XDG_CONFIG_HOME="$HOME/.config"

## iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
source ~/.iterm2_shell_integration.`basename $SHELL`

# -- END --

