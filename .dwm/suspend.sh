#!/bin/sh

if [ -z "$SUSPEND_TIME" ]
then
	SUSPEND_TIME=3
fi
C=`doas fgconsole`
N=`doas fgconsole -n`

$@ &
sleep 0.3

doas chvt $N
sleep 1
loginctl suspend -i
sleep $SUSPEND_TIME
doas chvt $C
