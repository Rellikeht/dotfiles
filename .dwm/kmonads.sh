#!/usr/bin/env sh

which kmonad >/dev/null 2>/dev/null || exit 1
[ -x "$HOME/bin/perpetual" ] || exit 1
cd "$HOME/.kmonad" || exit 1

for file in *.kbd; do
    FILE="$(readlink -f "$file")"
    pgrep -f "perpetual kmonad $FILE" >/dev/null && continue
    "$HOME/bin/perpetual" kmonad "$FILE" & 
done
