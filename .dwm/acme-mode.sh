#!/bin/sh
loc="`xdotool getmouselocation | sed \"s/ scr.*//;s/x://;s/y://\"`"
xdotool mousemove 0 0
awk "{ print \$1 }" ~/.scrs/mocp.commands | dzen2 -p -w '200' -h '15' -bg '#01080b' -fg '#18de4a' -l `grep -c . ~/.scrs/mocp.commands` -m h -e "`sed -n -z \"s/\n//gp\" ~/.scrs/mocp.keys`"
xdotool mousemove $loc 
