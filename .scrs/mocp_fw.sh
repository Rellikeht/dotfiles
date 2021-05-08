#!/bin/sh

read c

while [ "$c" != "q" ]
do
	if [ "$c" = "b" ]
	then
		mocp -r
	else
		mocp -f
	fi
	read c
done
