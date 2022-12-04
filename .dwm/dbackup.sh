#!/bin/sh

TARS="t(ar)?(\.?(gz|xz|bz2|bz))?"
ARCHS="rar|zip|lzma|xz|gz|bz2"
IMGS="png|jpe?g|gif|webp|bmp"
DOCS="pdf|djvu|epub|chm|mobi|az3"
TEXT="sha256|sha1|crc|sum|txt|torrent"
VIDS="webm|mp4|mkv|avi|ogv|m4a"
MUSIC="mp3|wav|opus|ogg"
DISKS="iso|ova|ovs|vdi|raw"
EDITS="docx?|pptx?|pot|od[pt]|xlsx?"
REST="out|download|crdownload|part"

# '^[^.]*$ without extensions?
# '[^.]{8,} maybe, maybe with $ (4 should be enough,
# but torrent and maybe other long extensions

EXTS="$TARS|$ARCHS|$IMGS|$DOCS|$TEXT|$VIDS|$MUSIC|$EDITS|$DISKS|$REST"
DOWNS=~/Pobrane/

backup ()
{
	ls $DOWNS | \
		grep -Ei $3 "\.($1)$" | \
		xargs -I{} cp -rn "$DOWNS"/{} "$2"
}

backup "$EXTS" ~/Dwns/ -v
backup "$DOCS" ~/Dwns/pdf/
