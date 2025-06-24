#!/usr/bin/env sh

SDIR="${0%/*}"
DDIR="../../bin/"
if ! [ -d "$DDIR" ]; then
    DDIR="$HOME/bin"
    mkdir -p "$DDIR"
fi

m4 -DRES=240 "$SDIR/ytdlv.m4" >"$DDIR/ytd2"
m4 -DRES=360 "$SDIR/ytdlv.m4" >"$DDIR/ytdl"
m4 -DRES=480 "$SDIR/ytdlv.m4" >"$DDIR/ytds"
m4 -DRES=570 "$SDIR/ytdlv.m4" >"$DDIR/ytdt"
m4 -DRES=720 "$SDIR/ytdlv.m4" >"$DDIR/ytdh"
m4 -DRES=1080 "$SDIR/ytdlv.m4" >"$DDIR/ytdf"
m4 -DRES=1440 "$SDIR/ytdlv.m4" >"$DDIR/ytdq"
m4 -DRES=2160 "$SDIR/ytdlv.m4" >"$DDIR/ytd4"
chmod +x "$DDIR"/ytd*
