#!/usr/bin/env sh

BAT_SCRIPT="$HOME/.local/dwm/helpers/bat"
S=" "
SLEEP="0.5"
if [ -n "$1" ]; then
    SLEEP="$1"
fi
if ! [ -x "$BAT_SCRIPT" ]; then
    BAT_SCRIPT=
fi

while true; do
    DATE="$(date +"%H:%M:%S %d.%m.%Y")"
    xsetroot -name " < $(eval $BAT_SCRIPT)$S$DATE < "
    sleep $SLEEP
done
