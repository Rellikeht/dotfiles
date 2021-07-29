#!/bin/sh
DIR="`~/.dscripts/dsel.sh`"
FILE=`ls --color=never -d "$DIR"/* | dmenu`
PROG="`dmenu_path | dmenu`"
$PROG $FILE
