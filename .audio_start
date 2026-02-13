#!/usr/bin/env sh

run_if_exists() {
    pgrep -U "$(id -u)" -x "$1" >/dev/null && return
    dbus-launch "$1" >/dev/null 2>/dev/null &
}

shell_if_exists() {
    pgrep -U "$(id -u)" -xf "sh $1" >/dev/null && return
    sh "$1" >/dev/null 2>/dev/null &
}

MIC_STAB="$HOME/.local_scrs/mic_lev_stab.sh"

for prog in pipewire wireplumber pipewire-pulse; do
    run_if_exists "$prog"
done
[ -x "$MIC_STAB" ] && shell_if_exists "$MIC_STAB"
sleep 0.2

# jackd -dalsa -dhw:1
