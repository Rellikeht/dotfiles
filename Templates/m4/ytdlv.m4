define(HF, ifdef(`RES', RES(), 570))dnl
#!/usr/bin/env sh

LANG=
[ -n "$YTL" ] && LANG="[language=$YTL]"
[ -n "$YTABR" ] && ABR="[abr>=$YTABR]"
# != doesn't work on it's own
[ -n "$YTNOCODEC" ] && CODEC="[vcodec!*=$YTNOCODEC]"
H=HF()
HSET="[height>=$H]"

exec yts -f "(ba$ABR$LANG+bv$HSET$CODEC)/b$HSET$CODEC$LANG" "$@"
