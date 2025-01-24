#!/usr/bin/env sh

GEOM=$(slop)
DIR="~/Downloads"

sleep 0.1
shotgun -g "$GEOM" "$DIR/.shot.png"
$PROG "$DIR/.shot.png"
rm "$DIR/.shot.png"
