#!/bin/sh

C=`doas fgconsole`
N=`doas fgconsole -n`
doas chvt $N
sleep 1
loginctl suspend -i
sleep 4
doas chvt $C
xlock
