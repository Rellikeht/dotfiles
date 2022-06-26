#!/bin/sh

DIR="`~/.dscripts/dsel.sh`"
sleep 0.1
FILE="`ls --color=never -d "$DIR"/* | dmenu`"
sleep 0.1
PROG="`dmenu_path | dmenu`"
"$PROG" "$FILE" &
