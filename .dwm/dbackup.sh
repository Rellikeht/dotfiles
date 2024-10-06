#!/usr/bin/env sh

TARS="t(ar)?(\.?(gz|xz|bz2|bz))?"
ARCHS="rar|zip|lzma|xz|gz|bz2"
IMGS="png|jpe?g|gif|webp|bmp"
DOCS="pdf|djvu|epub|chm|mobi|az3"
TEXT="sha256|sha1|crc|sum|txt|torrent"
VIDS="webm|mp4|mkv|avi|ogv|m4a"
MUSIC="mp3|wav|opus|ogg"
DISKS="iso|ova|ovs|vdi|raw"
EDITS="docx?|pptx?|pot|od[pt]|xlsx?"
LANG="html?|css"
REST="out|download|crdownload|part"

# '^[^.]*$ without extensions?
# '[^.]{8,} maybe, maybe with $ (4 should be enough,
# but torrent and maybe other long extensions

EXTS="$TARS|$ARCHS|$IMGS|$DOCS|$TEXT|$VIDS|$MUSIC|$DISKS|$EDITS|$LANG|$REST"
DOWNS=~/Downloads/
DBD=~/Dbackup/

mkdir -p "$DBD"
mkdir -p "$DBD/pdf"

backup() {
    ls --color=never $DOWNS |
        grep -Ei $3 "\.($1)$" |
        xargs -I{} cp -rn "$DOWNS"/{} "$2"
}

backup "$EXTS" "$DBD" -v
backup "$DOCS" "$DBD/pdf/"
