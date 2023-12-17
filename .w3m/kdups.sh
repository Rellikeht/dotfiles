#!/usr/bin/env sh

FILE="keymap"
[ -f "$1" ] && FILE="$1"

grep -Ev '^(#.*)?$' "$FILE" |\
    sed -E 's/^keymap ([^ ]*) .*/\1/' |\
    sort |\
    uniq -d
