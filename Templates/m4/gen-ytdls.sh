#!/usr/bin/env sh

SDIR="${0%/*}"
DDIR="../../bin/"
if ! [ -d "$DDIR" ]; then
    DDIR="$HOME/bin"
    mkdir -p "$DDIR"
fi

m4 -DFORMAT='wv' "$SDIR/ytdls.m4" >"$DDIR/ytwv"
m4 -DFORMAT='bv' "$SDIR/ytdls.m4" >"$DDIR/ytbv"
m4 -DFORMAT='wa$ABR$LANG1/wa$ABR$LANG2' \
    "$SDIR/ytdls.m4" >"$DDIR/ytwa"
m4 -DFORMAT='ba$ABR$LANG1/ba$ABR$LANG2' \
    "$SDIR/ytdls.m4" >"$DDIR/ytba"

DF='(wa$ABR$LANG1/wa$ABR$LANG2)+wv/w$ABR$LANG1/w$ABR$LANG2/$b$ABR$LANG3'
m4 -DFORMAT="$DF" "$SDIR/ytdls.m4" >"$DDIR/ytww"
DF='(ba$ABR$LANG1/ba$ABR$LANG2)+bv/b$ABR$LANG1/b$ABR$LANG2/$b$ABR$LANG3'
m4 -DFORMAT="$DF" "$SDIR/ytdls.m4" >"$DDIR/ytbb"

chmod +x "$DDIR"/yt[bw]*
