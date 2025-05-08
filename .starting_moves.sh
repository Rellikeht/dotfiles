#!/bin/sh
delay=3
sleep_time=0.05
sleep $sleep_time

sleep $sleep_time
xdotool keydown --delay $delay Super_L \
    key --delay $delay Return \
    keyup --delay $delay Super_L
