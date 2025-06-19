#!/usr/bin/env bash

__prompt_command() {
    # {{{
    local EX="$?"
    local DURATION=$(__calc_command_duration)
    if [ -n "$EXIT" ]; then
        EX="$EXIT"
    fi
    PS1=""
    PS1+="${LCYAN}\w${RESET} "
    if [ "$EX" != 0 ]; then
        PS1+="${LRED}"
    else
        PS1+="${LGREEN}"
    fi
    PS1+="[$EX]${RESET} "
    PEND="${LYELLOW}$PSC${RESET} "
    PS1=$(__ps1_with_duration "$DURATION" "$PEND")
} # }}}
