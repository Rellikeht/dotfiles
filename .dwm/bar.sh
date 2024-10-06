#!/usr/bin/env sh

if [ -x ~/.local_scrs/bat.sh ]; then
    BAT="~/.local_scrs/bat.sh"
    S=" "
fi

while true; do
    xsetroot -name " < $(eval $BAT)$S$(date +"%H:%M:%S %d.%m.%Y") < "
    sleep 0.5
done
