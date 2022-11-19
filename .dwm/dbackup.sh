#!/bin/sh

TARS="t(ar)?(\.?(gz|xz|bz2|bz))?"
ARCHS="rar|zip|lzma|xz|gz|bz2"
IMGS="png|jpe?g|gif"
DOCS="pdf|djvu|epub|chm|mobi|az3"
REST="out|txt|torrent"

# '^[^.]*$ without extensions?
# '[^.]{8,} maybe, maybe with $ (4 should be enough,
# but torrent and maybe other long extensions

EXTS="$IMGS|$TARS|$ARCHS|$DOCS|$REST"
DOWNS=~/Pobrane/

backup ()
{
	ls $DOWNS | \
		grep -Ei $3 "\.($1)$" | \
		xargs -I{} cp -rn "$DOWNS"/{} "$2"
}

backup "$EXTS" ~/Dwns/ -v
backup "$DOCS" ~/Dwns/pdf/
