#!/usr/bin/env sh
# Suspend script for systems without systemd,
# when for some reason loginctl fails
# Also added some nvidia shit,
# because it is fucked and needs special care
# And tee is here because it was the easiest
# way to use some minimal auth and provide it
# without typing password at the same time

C=$(doas fgconsole)

$@ &
#sleep 0.25
sleep 0.2

doas chvt 63
[ -f /proc/driver/nvidia/suspend ] &&
    echo suspend | doas tee /proc/driver/nvidia/suspend >/dev/null
echo mem | doas tee /sys/power/state >/dev/null

#sleep 0.25
sleep 0.2
doas chvt $C
[ -f /proc/driver/nvidia/suspend ] &&
    echo resume | doas tee /proc/driver/nvidia/suspend >/dev/null
