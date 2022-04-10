#!/bin/sh
CAT=cat
bat /dev/null > /dev/null && CAT=bat

for i in $@
do
	if [ -d "$i" ]
	then
		ls $i
	else
		$CAT $i
	fi
done
