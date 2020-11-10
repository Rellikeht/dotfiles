#!/bin/sh
displays=
resols=[]
cp display.user.commands display.commands
xrandr | awk "BEGIN { OFS=\"\" } / connect/ { print \"^ca(1, xrandr --output \",\$1,\" --auto) \",\$1,\"+ ^ca()\n^ca(1, xrandr --output \",\$1,\" --off) \",\$1,\"- ^ca()\" }" >> display.commands
~/.scrs/mode.sh display 600 6
