#!/bin/sh
win=`xdotool selectwindow`
echo -n "Window: `getwindowname $win`"
xdotool key Escape --window $win
xdotool keydown s --window $win
#xdotool mousemove $X $Y click --window $WINDOW 1 mousemove restore
