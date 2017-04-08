# -- zplug --
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "sorin-ionescu/prezto"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# Then, source plugins and add commands to $PATH
zplug load --verbose

# -- Functions --
## Auto Launch tmux
if [ -z "$TMUX" -a -z "$STY" ]; then
      if type tmuxx >/dev/null 2>&1; then
              tmuxx
    elif type tmux >/dev/null 2>&1; then
        if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
                tmux attach && echo "tmux attached session "
        else
            tmux new-session && echo "tmux created new session"
        fi
    elif type screen >/dev/null 2>&1; then
            screen -rx || screen -D -RR
    fi
fi

# -- Alias --
alias aizu-ssh="ssh s1230194@sshgate.u-aizu.ac.jp"
alias aizu-sftp="sftp s1230194@sshgate.u-aizu.ac.jp"
alias py="python"
alias py2="python2.7"
alias py3="python3"

ln -s $HOME/.zplug/repos/sorin-ionescu/prezto $HOME/.zprezto

# -- Settings --
## go
export PATH="/usr/local/sbin:$PATH"
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export GOBIN=$GOPATH/bin
export GOROOT=/usr/local/Cellar/go/1.7.3/libexec

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
## dein.vim
export XDG_CONFIG_HOME="$HOME/.config"

## iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
source ~/.iterm2_shell_integration.`basename $SHELL`

# -- END --
