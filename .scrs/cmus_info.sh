#!/bin/sh
line="file"
if [ -n "$1" ]
then
	line=$1
fi

if [ "$line" = "left" ]
then
	cmus-remote -Q | awk "function pd() {for (de in d) print d[de]} BEGIN {c=0} /^dura|^posi/ {d[c]=\$2;c++} END {print \"left: \";pd();print \"- d 60 / n [:] n 60 % p\"}" | dc | dzen2 -p 2

elif [ "$line" = "total" ]
then
cmus-remote -Q | awk "/dura/ {print \$2, \"d 60 / n [:] n 60 % n\"}" | dc | dzen2 -p 2

elif [ "$line" = "curr" ]
then
cmus-remote -Q | awk "/posi/ {print \$2, \"d 60 / n [:] n 60 % n\"}" | dc | dzen2 -p 2

else
cmus-remote -Q | grep $line | dzen2 -p 2
fi
