#!/usr/bin/env sh

SDIR="${0%/*}"
SDIR=$(readlink -f "$SDIR")
DDIR="$HOME"

if [ -n "$1" ] && [ -d "$1" ]; then
    DDIR="$1"
fi

find "$SDIR" -mindepth 1 -maxdepth 1 -name '\.*' |
    grep -Ev '(/.sw[op]|/.config|/.git([^c].*)?)$' |
    xargs -d '\n' -I{} cp -frs "{}" "$DDIR"

mkdir -p "$DDIR/.config"
find "$SDIR/.config" -mindepth 1 -maxdepth 1 |
    grep -Ev '/(mpv|neovide)/?$' |
    xargs -d '\n' -I{} ln -fs "{}" "$DDIR/.config/" 2>/dev/null
# xargs -d '\n' -I{} echo "{}"

cp -r "$SDIR/.config/neovide" "$DDIR/.config"
mkdir -p "$DDIR/.config/mpv"
for o in mpv.conf input.conf scripts script-opts formats; do
    # if [ -e "$DIR/.config/$f" ]; then
    #     continue
    # fi
    ln -fs "$SDIR/.config/mpv/$o" "$DDIR/.config/mpv" 2>/dev/null
done
cp --update=none "$SDIR/.config/mpv/additional.conf" "$DDIR/.config/mpv"

# mkdir -p "$DDIR/.config/git"
# for f in config ignore; do
#     cp --update=none "$SDIR/.config/git/$f" "$DDIR/.config/git"
# done

for dir in Templates bin; do
    # if [ -e "$DIR/$dir" ]; then
    #     continue
    # fi
    ln -fs "$SDIR/$dir" "$DDIR/"
done
for f in "mpv/local.conf" "vifm/vifmrc-local"; do
    if [ -e "$DIR/.config/$f" ]; then
        continue
    fi
    touch "$DDIR/.config/$f"
done

for dir in \
    Backups Downloads Dbackup Desktop \
    Phone Phones Public Sync \
    Books Documents \
    Games Music Podcasts Pictures Videos \
    .tmux_sessions; do
    mkdir -p "$DDIR/$dir"
done

exit 0
