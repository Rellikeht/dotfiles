#!/usr/bin/env sh
define(HF, ifdef(`RES', RES(), 570) )dnl
define(RF, ifdef(`ABR', ABR(), 56) )dnl

LANG=
[ -n "$YTL" ] && LANG="[language=$YTL]"
H=HF()
ABR=RF()
HSET="[height>=$H]"
# != doesn't work on it's own
CSET="[vcodec!*=av01]"

exec yts -f "(ba[abr>=$ABR]$LANG+bv$HSET$CSET)/b$HSET$CSET$LANG" $@
