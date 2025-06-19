#!/usr/bin/env bash

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
        local SECS="$(printf "%02d\n" "$(($DD/10000000))")"
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

__prompt_command() {
    # {{{
    local EX="$?"
    local DURATION=$(__calc_command_duration)
    if [ -n "$EXIT" ]; then
        EX="$EXIT"
    fi
    PS1=""
    PS1+="${LBLUE}${SHLVL}=${RESET} "
    PS1+="${LMAGENTA}\w${RESET} "
    if [ "$EX" != 0 ]; then
        PS1+="${LRED}"
    else
        PS1+="${LGREEN}"
    fi
    PS1+="[$EX]${RESET} "
    PS1+="-> $DURATION"
    PS1+="\n"
    PS1+="${LYELLOW}$PSC${RESET} "
} # }}}
