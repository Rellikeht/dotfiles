#!/bin/sh
sleep 0.1
delay=3
xdotool keydown --delay $delay Super_L \
key --delay $delay 1 keydown --delay $delay Control_L \
key --delay $delay backslash keyup --delay $delay Control_L \
key --delay $delay 2 keydown --delay $delay Control_L \
key --delay $delay backslash keyup --delay $delay Control_L \
key --delay $delay 3 keydown --delay $delay Control_L \
key --delay $delay backslash keyup --delay $delay Control_L \
key --delay $delay 4 keydown --delay $delay Control_L \
key --delay $delay backslash keyup --delay $delay Control_L \
key --delay $delay 5 keydown --delay $delay Control_L \
key --delay $delay backslash keyup --delay $delay Control_L \
key --delay $delay 6 keydown --delay $delay Control_L \
key --delay $delay backslash keyup --delay $delay  Control_L \
key --delay $delay 1 keyup Super_L --delay $delay 
