#!/usr/bin/env bash

__prompt_command() {
    # {{{
    # Because sometimes z.lua fucks up
    local EXT="$?"
    if [ -n "$EXIT" ]; then
        EXT="$EXIT"
    fi
    if [ -n "$TIME_PS1" ]; then
        local DURATION=$(__calc_command_duration)
    fi
    PS1=""
    # PS1+="${BLUE}[${RESET}"
    # PS1+="${LBLUE}\u${RESET}"
    # PS1+="${LCYAN}@${RESET}"
    # PS1+="${LRED}\h${RESET}"
    # PS1+="${BLUE}]${RESET}"
    # PS1+="${LCYAN}:${RESET}"
    PS1+="${LCYAN}\w${RESET}"
    if [ -n "$TIME_PS1" ]; then
        PS1+=" -> $DURATION"
        PS1+="\n"
    fi
    if [ "$EXT" != 0 ]; then
        PS1+="${LRED}"
    else
        PS1+="${LGREEN}"
    fi
    PS1+="[$EXT]${RESET}"
    PS1+="${LYELLOW}$PSC ${RESET}"
} # }}}
