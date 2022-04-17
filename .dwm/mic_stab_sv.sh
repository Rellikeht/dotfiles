#!/bin/sh
lvl=`cat .mlevel`
lvl=$((lvl*65535/100))

if [ -z "$1" ]
then
	timeout=.05
else
	timeout=$1
fi

lpl=100
i=0
while true
do
	if [ $i -eq $lpl ]
	then
		lvl=`cat .mlevel`
		lvl=$((lvl*65535/100))
		i=0
	fi

	for s in `pactl list sources short | awk "/RUNNING/ {print \\\$2}"`
	do
		pactl set-source-volume $s $lvl
	done

	i=$((i+1))
	sleep $timeout
done
