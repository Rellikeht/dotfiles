#!/usr/bin/env sh

SDIR="${0%/*}"

m4 -DRES=360 "$SDIR/ytdlv.m4" >"$SDIR/../../bin/ytdl"
m4 -DRES=480 "$SDIR/ytdlv.m4" >"$SDIR/../../bin/ytds"
m4 -DRES=570 "$SDIR/ytdlv.m4" >"$SDIR/../../bin/ytdt"
m4 -DRES=720 "$SDIR/ytdlv.m4" >"$SDIR/../../bin/ytdh"
m4 -DRES=1080 "$SDIR/ytdlv.m4" >"$SDIR/../../bin/ytdf"
m4 -DRES=1440 "$SDIR/ytdlv.m4" >"$SDIR/../../bin/ytdq"

chmod +x "$SDIR"/../../bin/ytd*
