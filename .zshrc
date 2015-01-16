HISTFILE=~/.zsh/history
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob
setopt NO_HUP
bindkey -e

zstyle :compinstall filename '/home/nadrieril/.zshrc'

autoload -Uz compinit
compinit

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.zsh/oh-my-zsh
ZSH_THEME="robbyrussell"

# CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="yyyy-mm-dd"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colorize colored-man)

DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/home/nadrieril/.local/bin:$PATH"

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='${ret_status}%{$fg_bold[white]%}%n@%m %{$fg[cyan]%}%c%{$fg_bold[blue]%}%(!.#.$) %{$reset_color%}'
RPROMPT='%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%}'


if [ -f ~/.zsh/proxy ]; then
    . ~/.zsh/proxy
fi
if [ -f ~/.zsh/aliases ]; then
    . ~/.zsh/aliases
fi
