#!/usr/bin/env sh

kill_if_exists() {
    pkill -U "$(id -u)" -xf "$1" >/dev/null
}

MIC_STAB="$HOME/.local_scrs/mic_lev_stab.sh"

for prog in pipewire wireplumber pipewire-pulse; do
    kill_if_exists "$prog"
done
[ -x "$MIC_STAB" ] && kill_if_exists "sh $MIC_STAB"
