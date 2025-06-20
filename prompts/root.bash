#!/usr/bin/env bash

__prompt_command() {
    # {{{
    local EX="$?"
    if [ -n "$TIME_PS1" ]; then
        local DURATION=$(__calc_command_duration)
    fi
    if [ -n "$EXIT" ]; then
        EX="$EXIT"
    fi
    PS1=""
    PS1+="${LCYAN}\w${RESET} "
    if [ -n "$TIME_PS1" ]; then
        PS1+="-> ${LWHITE}$DURATION${RESET}"
        PS1+="\n"
    fi
    if [ "$EX" != 0 ]; then
        PS1+="${LRED}"
    else
        PS1+="${LGREEN}"
    fi
    PS1+="[$EX]${RESET}"
    PS1+="${LYELLOW}$PSC${RESET} "
} # }}}
