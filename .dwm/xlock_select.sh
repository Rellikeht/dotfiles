#!/bin/sh
XLOCK_MODE=`xlock -help |
	awk '/^[ ]{10}[^ ]/ {print $1}' |
	dmenu`
xlock -mode $XLOCK_MODE \
	-startCmd '~/.dwm/suspend.sh'
