#!/bin/sh

DIR='DIR'

while [ -z "`echo "$DIR" | egrep '^./$'`" ]
do
	DIR="`ls -Fap | \
		egrep '/$' | \
		dmenu`"
	sleep 0.1
	cd "$DIR"
done
pwd
