#!/bin/sh
if [ -n "$1" ]
then
	sleep $1
fi

DDIR=~/.autom
$DDIR/iclick.sh $DDIR/discord-img/`ls --color=never $DDIR/discord-img | awk "BEGIN {FS=\"[ 	.]\"} {print \\\$1}" | dmenu`.png 0
