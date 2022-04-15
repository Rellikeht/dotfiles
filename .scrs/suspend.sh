#!/bin/sh

if [ -z "$SUSPEND_TIME" ]
then
	SUSPEND_TIME=4
fi

C=`doas fgconsole`
N=`doas fgconsole -n`
doas chvt $N
sleep 1
loginctl suspend -i
sleep $SUSPEND_TIME
doas chvt $C
$@
