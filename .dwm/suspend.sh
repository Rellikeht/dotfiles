#!/bin/sh

#INF=2500000
#doas rtcwake -m mem -s $INF

C=$(doas fgconsole)

$@ &
#sleep 0.25
sleep 0.2

doas chvt 63
echo mem | doas tee /sys/power/state >/dev/null

#sleep 0.25
sleep 0.2
doas chvt $C
