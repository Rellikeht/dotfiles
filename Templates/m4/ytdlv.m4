#!/usr/bin/env sh
define(HF, ifdef(`RES', RES(), 580) )dnl
define(RF, ifdef(`ABR', ABR(), 56) )dnl

LANG=
[ -n "$YTL" ] && LANG="[language=$YTL]"
H=HF()
ABR=RF()

exec yts -f "ba[abr>=$ABR]$LANG+bv[height>=$H]/best[height>=$H]$LANG" $@
