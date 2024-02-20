#!/bin/sh
loc="$(
    xdotool getmouselocation | sed \"s/ scr.*//
    s/x://
    s/y://\"
)"

xdotool mousemove 0 0
awk "{ print \$1 }" ~/.dwm/mocp.commands |
    dzen2 -p -w '200' -h '15' -bg '#01080b' -fg '#18de4a' -l \
        $(grep -c . ~/.dwm/mocp.commands) -m h -e \
        "$(sed -n -z \"s/\n//gp\" ~/.dwm/mocp.keys)"

xdotool mousemove $loc
