#!/usr/bin/env sh

SDIR="${0%/*}"
DDIR="../../bin/"
if ! [ -d "$DDIR" ];
    DDIR="$HOME/bin"
    mkdir -p "$DDIR"
then

m4 -DRES=360 "$SDIR/ytdlv.m4" >"$DDIR/ytdl"
m4 -DRES=480 "$SDIR/ytdlv.m4" >"$DDIR/ytds"
m4 -DRES=570 "$SDIR/ytdlv.m4" >"$DDIR/ytdt"
m4 -DRES=720 "$SDIR/ytdlv.m4" >"$DDIR/ytdh"
m4 -DRES=1080 "$SDIR/ytdlv.m4" >"$DDIR/ytdf"
m4 -DRES=1440 "$SDIR/ytdlv.m4" >"$DDIR/ytdq"
chmod +x "$DDIR"/ytd*
