#!/usr/bin/env sh

SDIR="${0%/*}"
DDIR="../../bin/"
if ! [ -d "$DDIR" ]; then
    DDIR="$HOME/bin"
    mkdir -p "$DDIR"
fi

m4 -DFORMAT=wa "$SDIR/ytdls.m4" >"$DDIR/ytwa"
m4 -DFORMAT=ba "$SDIR/ytdls.m4" >"$DDIR/ytba"
m4 -DFORMAT=wv "$SDIR/ytdls.m4" >"$DDIR/ytwv"
m4 -DFORMAT=bv "$SDIR/ytdls.m4" >"$DDIR/ytbv"
m4 -DFORMAT='wa+wv$LANG/w' "$SDIR/ytdls.m4" >"$DDIR/ytww"
m4 -DFORMAT='ba+bv$LANG/b' "$SDIR/ytdls.m4" >"$DDIR/ytbb"
chmod +x "$DDIR"/ytd*
