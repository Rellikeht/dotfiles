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
    if [ -n "$USER_PS1" ]; then
        # PS1+="${MAGENTA}[${RESET}"
        PS1+="${CYAN}\u${RESET}"
        PS1+="${LRED}@${RESET}"
        PS1+="${LCYAN}\h${RESET} "
        # PS1+="${MAGENTA}]${RESET}"
        PS1+="${LBLUE}${RESET}"
    fi
    PS1+="${LBLUE}\w${RESET}"
    if [ -n "$TIME_PS1" ]; then
        PS1+=" ${LWHITE}[$DURATION]${RESET}"
    fi
    if [ -n "$USER_PS1" ] || [ -n "$TIME_PS1" ]; then
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
