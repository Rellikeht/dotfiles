#!/usr/bin/env sh

line="file"
if [ -n "$1" ]; then
    line=$1
fi

if [ "$line" = "left" ]; then
    cmus-remote -Q | awk "/^dura|^posi/ {print \$2} END \
	{print \"- [0 n] sz 60 ~ r n [:] n d 10 >z n [\n] n\"}" | dc | dzen2 -p 2

elif [ "$line" = "total" ]; then
    cmus-remote -Q | awk "/dura/ {print \$2, \"d [0 n] sz 60 ~ r n [:] n d 10 >z n [\n] n\"}" | dc | dzen2 -p 2

elif [ "$line" = "curr" ]; then
    cmus-remote -Q | awk "/posi/ {print \$2, \"d [0 n] sz 60 ~ r n [:] n d 10 >z n [\n] n\"}" | dc | dzen2 -p 2

else
    cmus-remote -Q | grep $line | dzen2 -p 2
fi
