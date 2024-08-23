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
# cp -frs --update=none "$SDIR/.config/"* "$DDIR/.config"
ln -s "$SDIR/.config/"* "$DDIR/.config" 2>/dev/null

for dir in Templates bin; do
    mkdir -p "$DDIR/$dir"
    # ln -fs "$DDIR/$dir/"* "$DDIR/$dir"
    ln -s "$SDIR/$dir" "$DDIR/$dir"
done

touch "$DDIR/.config/mpv/local.conf"
# touch "$DDIR/.config/vifm/vifmrc-local"
