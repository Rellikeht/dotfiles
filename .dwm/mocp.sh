#!/bin/sh
loc="`xdotool getmouselocation | sed \"s/ scr.*//;s/x://;s/y://\"`"
xdotool mousemove 0 0
#awk "{ print \"^ca(1, \", \$2, \")\", \$1, \"^ca()\" }" ~/.dwm/mocp.commands | dzen2 -p -w '401' -h '15' -bg '#01080b' -fg '#18de4a' -l `grep -c . ~/.dwm/mocp.commands` -m h -e "`sed -n -z \"s/\n//gp\" ~/.dwm/mocp.keys`"
cat ~/.dwm/mocp.commands | dzen2 -p -w '300' -h '15' -bg '#01080b' -fg '#18de4a' -l `grep -c . ~/.dwm/mocp.commands` -m h -e "`sed -n -z \"s/\n//gp\" ~/.dwm/mocp.keys`"
xdotool mousemove $loc 
