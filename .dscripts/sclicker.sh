#!/bin/sh
if [ -z "$1" ]
then
	echo 5 seconds...
	sleep 5
else
	echo $1 seconds...
	sleep $1
fi

if [ -z "$2" ]
then
	interval=5
else
	interval=$2
fi

eval `xdotool getmouselocation --shell`
echo -n "Window: "
xdotool getwindowname $WINDOW
echo Position: $X $Y

while true
do
	xdotool mousemove $X $Y click --window $WINDOW 1 mousemove restore
	sleep $interval
done
