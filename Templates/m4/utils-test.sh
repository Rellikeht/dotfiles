#!/usr/bin/env sh

SDIR="${0%/*}"

m4 -I "$SDIR" "$SDIR/utils.m4" |
    sed -Ez 's/^\n+/start\n/'
