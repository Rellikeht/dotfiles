#!/usr/bin/env bash

# {{{ intro

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f "$HOME/.commonrc" ]; then
    source "$HOME/.commonrc"
fi

# }}}

# {{{ sourcing

conditional_source ~/.aliasrc.bash
conditional_source ~/.funcrc.bash
conditional_source "$HOME/.local/.bashrc"

# }}}

# {{{ settings

HISTFILE=~/.bash_history

# nice history settings
HISTCONTROL=ignoredups:erasedups

# shared history
shopt -s histappend

# type dir to cd
shopt -s autocd

# for colors in completion to work better
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32'

# }}}

# {{{ prompt

PSC='$'
[ "$(id -u)" -eq 0 ] && PSC='#'
PROMPT_COMMAND=__prompt_command
PS2=">"
PS3=""
PS4="+"

# prompt file, something like p10k but simpler
if ! conditional_source ~/.prompt.bash &>/dev/null; then
    __prompt_command() {
        # {{{

        # this has to be first
        if [ -z "$EXIT" ]; then
            EXIT="$?"
        fi
        PS1=""

        # {{{ colors
        local RESET='\[\e[0m\]'

        local BLACK='\[\e[0;30m\]'
        local RED='\[\e[0;31m\]'
        local GREEN='\[\e[0;32m\]'
        local YELLOW='\[\e[0;33m\]'
        local BLUE='\[\e[0;34m\]'
        local MAGENTA='\[\e[0;35m\]'
        local CYAN='\[\e[0;36m\]'
        local WHITE='\[\e[0;37m\]'

        local LBLACK='\[\e[1;30m\]'
        local LRED='\[\e[1;31m\]'
        local LGREEN='\[\e[1;32m\]'
        local LYELLOW='\[\e[1;33m\]'
        local LBLUE='\[\e[1;34m\]'
        local LMAGENTA='\[\e[1;35m\]'
        local LCYAN='\[\e[1;36m\]'
        local LWHITE='\[\e[1;37m\]'
        # }}}

        PS1+="${MAGENTA}[ ${RESET}"
        PS1+="${CYANj}\u${RESET}"
        PS1+="${LRED}@${RESET}"
        PS1+="${LCYAN}\h${RESET}"
        PS1+="${MAGENTA} ]${RESET}"
        PS1+="${LBLUE}:${RESET}"
        PS1+="${LMAGENTA}\w${RESET}"

        if [ "$EXIT" != 0 ]; then
            PS1+="${RED}"
        else
            PS1+="${GREEN}"
        fi

        PS1+="[$EXIT]${RESET}"
        PS1+="${LCYAN}$PSC ${RESET}"
    }
# }}}
fi

# }}}

# {{{ bindings

# better up and down
bind '"[A" history-search-backward'
bind '"[B" history-search-forward'
bind '"" history-search-backward'
bind '"" history-search-forward'

# may be better, but is acceptable
bind '"\ei":"**	"'

# }}}

# {{{ hooks

if fzf --bash &>/dev/null; then
    eval "$(fzf --bash)"
fi

if direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi

# z.lua or plain old z as fallback
if whichp z.lua &>/dev/null; then
    # {{{ Because doing this normal way messes $?

    eval "$(z.lua --init bash once enhanced echo fzf)"
    # It is exported as $EXIT
    # TEMP="$(mktemp)"
    # z.lua --init bash once enhanced echo fzf >"$TEMP"
    # patch "$TEMP" .bash_zlua_patch &>/dev/null
    # eval "$(cat $TEMP)"
    # rm "$TEMP"
    # TEMP=

# }}}
elif whichp z &>/dev/null; then
    . "$(whichp z)"
fi

# }}}

# {{{ other

# Compatibility between tmux and direnv
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
    # unset env vars starting with DIRENV_
    unset "${!DIRENV_@}"
fi

# Because opam env is expansive at some places
opam() {
    if [ -z "$OPAM_SWITCH_PREFIX" ] &&
        whichp opam &>/dev/null &&
        [ -f "$HOME/.opam" ]; then
        eval "$(/usr/bin/env opam env --shell bash)"
    fi
    /usr/bin/env opam $@
}

# }}}

# {{{ shit
if [ -z "$__CONDA_SETUP" ]; then
    __conda_setup=$("$HOME/.conda/bin/conda" 'shell.bash' 'hook' 2>/dev/null)
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/.conda/etc/profile.d/conda.sh" ]; then
            . "$HOME/.conda/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/.conda/bin:$PATH"
        fi
    fi
    unset __conda_setup
    export __CONDA_SETUP=1
fi
# }}}
