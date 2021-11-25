#!/bin/sh

if [ -n "$1" ]
then
	FILE="$1"
else
	FILE=/dev/stdin
fi
NL='\n'

#TODO awk version
sed -E \
	"s/: ?\{/: {$NL/g;
	s/\}/$NL}/g;
	s/, ?/,$NL/g" \
		$FILE #| \
#		awk "BEGIN {tc=1}
#			{for (i=0;i<tc;i++) {print \t};print \$0}" | \
		bat -l json
