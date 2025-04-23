#!/usr/bin/env sh

if [ -z "$1" ]; then
    echo "Give name of command" >/dev/stderr
    exit 1
fi
NAME="$1"

SDIR="${0%/*}"
DDIR="../../bin/"
if ! [ -d "$DDIR" ]; then
    DDIR="$HOME/bin"
    mkdir -p "$DDIR"
fi

DEFS="$SDIR/builds/$NAME"
EXE="$DDIR/auto-$NAME"

if ! [ -r "$DEFS" ]; then
    if ! [ -e "$DEFS" ]; then
        echo "\"$DEFS\" doesn't exist" >/dev/stderr
    else
        echo "Cannot read \"$DEFS\"" >/dev/stderr
    fi
    exit 1
fi

m4 \
    "$SDIR/autobuild-start.m4" \
    "$DEFS" \
    "$SDIR/autobuild-end.m4" >"$EXE"
chmod +x "$EXE"
