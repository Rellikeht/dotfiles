#!/bin/sh
delay=3
sleep_time=0.05
sleep $sleep_time

xdotool keydown --delay $delay Super_L \
key --delay $delay 1 keydown --delay $delay Control_L \
key --delay $delay backslash keyup --delay $delay Control_L \
key --delay $delay 2 keydown --delay $delay Control_L \
key --delay $delay backslash keyup --delay $delay Control_L \
key --delay $delay 3 keydown --delay $delay Control_L \
key --delay $delay backslash keyup --delay $delay Control_L \
key --delay $delay 4 keydown --delay $delay Control_L \
key --delay $delay backslash keyup --delay $delay Control_L \
key --delay $delay 5 keydown --delay $delay Control_L \
key --delay $delay backslash keyup --delay $delay Control_L \
key --delay $delay 6 keydown --delay $delay Control_L \
key --delay $delay backslash keyup --delay $delay  Control_L \
key --delay $delay 1 keyup Super_L --delay $delay

sleep $sleep_time
xdotool type tmux
xdotool key --delay $delay Return

#xdotool \
#keydown --delay $delay Control_L \
#keydown --delay $delay Alt_L \
#key Return --delay $delay \
#keyup --delay $delay Alt_L \
#keyup --delay $delay Control_L 

#sleep $sleep_time
#xdotool type tmux
#xdotool key --delay $delay Return

#xdotool \
#keydown --delay $delay Control_L \
#keydown --delay $delay Alt_L \
#key Return --delay $delay \
#keyup --delay $delay Alt_L \
#keyup --delay $delay Control_L 

#sleep $sleep_time
#xdotool type tmux
#xdotool key --delay $delay Return

#echo done | dzen2 -p 4
