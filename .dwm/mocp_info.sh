#!/bin/sh
line="File"
if [ -n "$1" ]
then
	line=$1
fi

if [ -n "$2" ]
then
	if [ $2 -eq -1 ]
	then
		while true;do mocp -i | grep $line;sleep 1;done | dzen2 -e "onstart=grabkeys;key_Escape=exit,xdotool mousemove 1 1;key_q=exit,xdotool mousemove 1 1"
	else
		for i in `seq 1 $2`;do mocp -i | grep $line;sleep 1;done | dzen2 -e "onstart=grabkeys;key_Escape=exit;key_q=exit"
	fi
else
	#mocp -i | awk "BEGIN {FS=\": \"} /$line/ {print \$2}" | dzen2 -p 2
	mocp -i | grep $line | dzen2 -p 2
fi
