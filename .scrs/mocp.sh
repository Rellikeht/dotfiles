#!/bin/sh
loc="`xdotool getmouselocation | sed \"s/ scr.*//;s/x://;s/y://\"`"
xdotool mousemove 0 0
#awk "{ print \"^ca(1, \", \$2, \")\", \$1, \"^ca()\" }" ~/.scrs/mocp.commands | dzen2 -p -w '401' -h '15' -bg '#01080b' -fg '#18de4a' -l `grep -c . ~/.scrs/mocp.commands` -m h -e "`sed -n -z \"s/\n//gp\" ~/.scrs/mocp.keys`"
cat ~/.scrs/mocp.commands | dzen2 -p -w '300' -h '15' -bg '#01080b' -fg '#18de4a' -l `grep -c . ~/.scrs/mocp.commands` -m h -e "`sed -n -z \"s/\n//gp\" ~/.scrs/mocp.keys`"
xdotool mousemove $loc 
