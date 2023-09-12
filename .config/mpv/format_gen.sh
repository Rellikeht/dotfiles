#!/bin/sh

DEFS="grep -Ev '^[ 	]*(#.*)?$' format_defs.m4"

# Debug macros
# exec sh -c "$DEFS | m4 -DNM=FNAME -DHG=420" ; exit

grep -E '^include=~~home/formats/.*\.conf # ' mpv.conf | \
    sed 's/^.*\///;s/\.conf #//' | \
    sed -E 's/([^ ]*) ([^ ]*)/m4 -DNM=\1 -DHG=\2 > formats\/\1.conf/' | \
    xargs -I {} sh -c "$DEFS | {}"
