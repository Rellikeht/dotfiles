#!/bin/sh
if [ -z "$1" ]
then
	lvl=26
else
	lvl=$1
fi
lvl=$((lvl*65535/100))

if [ -z "$2" ]
then
	timeout=.05
else
	timeout=$2
fi

while true
do
	for s in `pactl list sources short | awk "/RUNNING/ {print \\\$2}"`
	do
		pactl set-source-volume $s $lvl
	done
sleep $timeout
done
