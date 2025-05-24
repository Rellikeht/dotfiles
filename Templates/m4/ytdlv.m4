define(HF, ifdef(`RES', RES(), 570))dnl
#!/usr/bin/env sh

LANG=
[ -n "$YTL" ] && LANG="[language=$YTL]"
[ -n "$YTABR" ] && ABR="[abr>=$YTABR]"
# != doesn't work on it's own
[ -n "$YTNOCODEC" ] && CODEC="[vcodec!*=$YTNOCODEC]"
HSET="[height>=HF()]"

exec yt-dlp -S size -f "(ba$ABR$LANG+wv$HSET$CODEC)/w$HSET$CODEC$LANG" "$@"
