#!/usr/bin/env sh

SDIR="${0%/*}"
SDIR=$(readlink -f "$SDIR")
DDIR="$HOME"

if [ -n "$1" ] && [ -d "$1" ]; then
    DDIR="$1"
fi

find "$SDIR" -mindepth 1 -maxdepth 1 -name '\.*' |
    grep -Ev '/(.config|.git([^c].*)?)$' |
    xargs -d '\n' -I{} cp -frs "{}" "$DDIR"

mkdir -p "$DDIR/.config"
[ -d "$DDIR/.config/mpv" ] && MPV_DIR=1
ln -s "$SDIR/.config/"* "$DDIR/.config" 2>/dev/null

for dir in Templates bin; do
    ln -s "$SDIR/$dir" "$DDIR/"
done

touch "$DDIR/.config/mpv/local.conf"
touch "$DDIR/.config/vifm/vifmrc-local"

if [ -z "$MPV_DIR" ]; then
    rm "$DDIR/.config/mpv"
    mkdir -p "$DDIR/.config/mpv"
    for o in mpv.conf input.conf scripts script-opts formats; do
        ln -s "$SDIR/.config/mpv/$o" "$DDIR/.config/mpv"
    done
    cp "$SDIR/.config/mpv/additional.conf" "$DDIR/.config/mpv"
fi

for dir in \
    Backups Downloads Dbackup Desktop \
    Phone Phones Public Sync \
    Books Documents \
    Games Music Podcasts Pictures Videos; do
    mkdir -p "$DDIR/$dir"
done
