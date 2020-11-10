#!/bin/sh
loc="`xdotool getmouselocation | sed \"s/ scr.*//;s/x://;s/y://\"`"
cmdl="`grep -Ecv \"^\#\" ~/.scrs/$1.commands`"

if [ -n "$3" ]
then
	fn=$3
else
	fn=6
fi

if [ -n "$4" ]
then
	chrs=$4
else
	chrs=4
fi

if [ -n "$2" ]
then 
	w=$2
else
	w=$((`dc -e "4k $fn 0.3 ^ 0k 1/ p"`*$chrs*$cmdl*10+40))
	echo "w2: $w"
fi

xdotool mousemove 0 0
sed "/^#/d" ~/.scrs/$1.commands | dzen2 -p -fn 'MesloLGS NF-$fn' -w $w -h $((2*$fn+5)) -bg '#01080b' -fg '#18de4a' -l $cmdl -m h -e "`sed -n -z \"s/\n//gp\" ~/.scrs/$1.keys`"
xdotool mousemove $loc 
