#!/usr/bin/env sh

if [ -n "$1" ]; then
    cat "$1"
else
    cat -
fi | awk '
/^.{7}(  .{7}){2}: sourcing / {gsub(":","",$3);print $3, $5}
' | sort -nr
