# Auto-tmux in SSH
if [ -n "$SSH_CLIENT" ]; then
    if [ "$PS1" != "" -a -z "$TMUX" -a "${SSH_TTY:-x}" != x ]; then
        command -v tmux 2>&1 && ((tmux ls | grep -vq attached && tmux at) || tmux new-session) && exit 0
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

function host_color {
    function in_array {
        local arr_name=$1
        [ ${(P)${arr_name}[(i)$2]} -le ${(P)#$(echo $arr_name)} ]
    }

    local HOST=$(hostname)
    hosts_local=(Nadri-PC G73Sw vostro)
    hosts_nadri=(nadrieril vps108484.ovh.net)
    hosts_br=(frankiz lunedenn envorenn lodan koun kvh galloudel koumoul deiz heol)

    (in_array "hosts_local" $HOST && echo "white") \
    || (in_array "hosts_nadri" $HOST && echo "cyan") \
    || (in_array "hosts_br" $HOST && echo "green") \
    || echo "red"
}

function mk_prompt {
    local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
    local user='%{$fg_bold[white]%}%n'
    local host='%{$fg_bold['$(host_color)']%}%m'
    local dir='%{$fg[cyan]%}%c'
    local symbol='%{$fg_bold[blue]%}%(!.#.$)'
    PROMPT="$ret_status$user@$host $dir$symbol %{$reset_color%}"
    RPROMPT='%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%}'
}
mk_prompt

source $ZSH_DIR/aliases
source $ZSH_DIR/proxy
