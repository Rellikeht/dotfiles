#!/bin/sh

#INF=2500000
#doas rtcwake -m mem -s $INF

C=$(doas fgconsole)

$@ &
#sleep 0.25
sleep 0.2

doas chvt 63
echo mem | doas tee /sys/power/state > /dev/null

#sleep 0.25
sleep 0.2
doas chvt $C

#if [ -z "$SUSPEND_TIME" ]
#then
#	SUSPEND_TIME=3
#fi
#C=`doas fgconsole`
#N=`doas fgconsole -n`

#$@ &
#sleep 0.5
#doas chvt 63 #$N
#sleep 0.5
#dbus-launch loginctl suspend -i
#sleep $SUSPEND_TIME
#doas chvt $C
#echo | dzen2 -p 1
