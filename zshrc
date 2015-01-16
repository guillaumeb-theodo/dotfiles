# Auto-tmux in SSH
if [ -n "$SSH_CLIENT" ]; then
    if [ "$PS1" != "" -a -z "$TMUX" -a "${SSH_TTY:-x}" != x ]; then
        ((tmux ls | grep -vq attached && tmux at) || tmux new-session) && exit 0
        echo "Tmux failed! continuing with normal startup"
    else
        cat /var/run/motd.dynamic
    fi
fi


# Basic setup
ZSH_DIR=$HOME/.zsh

HISTFILE=$ZSH_DIR/history
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=10000
SAVEHIST=10000

setopt extendedglob
setopt NO_HUP
bindkey -e

zstyle :compinstall filename "$ZSH_DIR/zshrc"

autoload -Uz compinit
compinit

# CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"


# Oh-my-zsh
plugins=(colorize colored-man)

export ZSH=$ZSH_DIR/oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$HOME/.local/bin:$PATH"

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='${ret_status}%{$fg_bold[white]%}%n@%m %{$fg[cyan]%}%c%{$fg_bold[blue]%}%(!.#.$) %{$reset_color%}'
RPROMPT='%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%}'

source $ZSH_DIR/aliases
source $ZSH_DIR/proxy
