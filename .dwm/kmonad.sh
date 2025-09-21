#!/usr/bin/env sh

if [ "$#" -lt 1 ]; then
    exit 1
fi

BLOCK_DEV="$(sed -En '/^ *input/s/[^\"]+\"([^\"]+)\"[^\"]+/\1/p' "$1")"
if ! [ -e "$BLOCK_DEV" ]; then
    exit 1
fi

kmonad "$1"
