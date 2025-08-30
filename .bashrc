#!/usr/bin/env bash

# intro {{{

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f "$HOME/.commonrc" ]; then
    source "$HOME/.commonrc"
fi

# }}}

# sourcing {{{

source_if_exists ~/.aliasrc.bash
source_if_exists ~/.funcrc.bash
source_if_exists "$HOME/.local/.bashrc"

# }}}

# settings {{{

HISTFILE=~/.bash_history

# nice history settings
HISTCONTROL=ignoredups:erasedups

# shared history
shopt -s histappend

# type dir to cd
shopt -s autocd

# just in case
shopt -s expand_aliases

# for colors in completion to work better
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32'

# https://www.reddit.com/r/bash/comments/y3rmqs/fuzzy_file_completion_in_bash/
shopt -s cdspell
shopt -s dirspell
shopt -s cdable_vars

set -o pipefail

# }}}

# prompt {{{

# colors {{{
RESET='\[\e[0m\]'

BLACK='\[\e[0;30m\]'
RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
YELLOW='\[\e[0;33m\]'
BLUE='\[\e[0;34m\]'
MAGENTA='\[\e[0;35m\]'
CYAN='\[\e[0;36m\]'
WHITE='\[\e[0;37m\]'

LBLACK='\[\e[1;30m\]'
LRED='\[\e[1;31m\]'
LGREEN='\[\e[1;32m\]'
LYELLOW='\[\e[1;33m\]'
LBLUE='\[\e[1;34m\]'
LMAGENTA='\[\e[1;35m\]'
LCYAN='\[\e[1;36m\]'
LWHITE='\[\e[1;37m\]'
# }}}

# command running time calculation {{{

# file to write, shm to cause least delay possible
TIME_FILE="/dev/shm/$USER.bash.$$"
clean_time_pipe() {
    rm -fr "$TIME_FILE"
}
touch "$TIME_FILE"
trap clean_time_pipe TERM QUIT EXIT
# starting time of command
PS0='$(date +%s%N > $TIME_FILE)'

__calc_command_duration() {
    local LAST_TIME="$(cat "$TIME_FILE")"
    local NEW_TIME="$(date +%s%N)"
    if [ -n "$LAST_TIME" ]; then
        echo >"$TIME_FILE"
        DURATION="$((NEW_TIME - LAST_TIME))"
        local DI="$((DURATION / 1000000000))"
        local DD="$((DURATION % 1000000000))"
        local HOUR="$(date -d "@$(($DI - 3600))" +%T)"
        local SECS="$(printf "%02d\n" "$(($DD / 10000000))")"
        # local SECS="$(printf "%03d\n" "$(($DD / 1000000))")"
        local DAY="$(($(date -d "@$DI" +%j) - 1))"
        local YEAR="$(($(date -d "@$DI" +%y) - 70))"
        DURATION="$HOUR.$SECS"
        if [ "$YEAR" -gt 0 ]; then
            DURATION="${YEAR}y ${DAY}d $DURATION"
        elif [ "$DAY" -gt 0 ]; then
            DURATION="${DAY}d $DURATION"
        fi
        echo $DURATION
    else
        echo --:--:--
    fi
}
# }}}

PSC='$'
[ "$(id -u)" -eq 0 ] && PSC='#'
PS2=">"
PS3=""
PS4="+"

# prompt file
if ! source_if_exists ~/.prompt.bash &>/dev/null; then
    __prompt_command() {
        # {{{
        # Because sometimes z.lua fucks up
        local EX="$?"
        if [ -n "$EXIT" ]; then
            EX="$EXIT"
        fi
        PS1=""
        PS1+="${LMAGENTA}\w${RESET}"
        if [ "$EX" != 0 ]; then
            PS1+="${RED}"
        else
            PS1+="${GREEN}"
        fi
        PS1+="[$EX]${RESET}"
        PS1+="${LCYAN}$PSC${RESET} "
    }
# }}}
fi
PROMPT_COMMAND=__prompt_command

# }}}

# bindings {{{

# better up and down
bind '"[A" history-search-backward'
bind '"[B" history-search-forward'
bind '"" history-search-backward'
bind '"" history-search-forward'

# may be better, but is acceptable
bind '"\ei":"**	"'
bind 'Space:magic-space'

# }}}

# hooks {{{

if fzf --bash &>/dev/null; then
    FZF_COMPLETION_TRIGGER='**'
    eval "$(fzf --bash)"
fi

if [ -z "$__Z_INITIALIZED" ]; then
    activate_z_lua() {
        # {{{
        # Because doing this normal way messes in some cases $?
        # Here it is exported as $EXIT
        if [ -r "$HOME/.bash/zlua_patch" ]; then
            local TEMP
            TEMP="$(mktemp)"
            "$@" bash once enhanced echo fzf >"$TEMP"
            patch -u "$TEMP" -i "$HOME/.bash/zlua_patch" &>/dev/null
            rm -f "$TEMP.orig"
            eval "$(cat "$TEMP")"
            rm "$TEMP"
        else
            eval "$("$@" bash once enhanced echo fzf)"
        fi
        # }}}
    }

    # z.lua or plain old z as fallback
    ZLUA_FILE="$HOME/.local/share/z.lua/z.lua"
    if [ -r "$ZLUA_FILE" ] && has_exe lua; then
        activate_z_lua lua "$ZLUA_FILE"
    elif has_exe z.lua; then
        activate_z_lua z.lua --init
    elif has_exe z; then
        . "$(whichp z)"
    fi
    __Z_INITIALIZED=1
fi

if has_exe direnv; then
    eval "$(direnv hook bash)"
fi

# }}}

# other {{{

# Compatibility between tmux and direnv
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
    # unset env vars starting with DIRENV_
    unset "${!DIRENV_@}"
fi

# }}}

# shit {{{

if [ -z "$__CONDA_SETUP" ]; then
    if [ -d "$HOME/.conda" ]; then
        __conda_setup=$("$HOME/.conda/bin/conda" 'shell.bash' 'hook' 2>/dev/null)
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "$HOME/.conda/etc/profile.d/conda.sh" ]; then
                . "$HOME/.conda/etc/profile.d/conda.sh"
            else
                pathinsert "$HOME/.conda/bin:$PATH"
            fi
        fi
        unset __conda_setup
    fi
    export __CONDA_SETUP=1
fi

# }}}
