#!/usr/bin/env sh
# This all will be easier and more reliable than sedding
# config + will be resistant to immutable config (nix)
# https://github.com/alacritty/alacritty-theme

# TODO better switching (some form of cycling)
THEMES=$(readlink -f ~/.config/alacritty/themes)
DEFAULT='default.toml'
ADDITIONAL='inferno.toml'
DEST=~/.alacritty.theme.toml

if ! [ -e "$DEST" ]; then
    ln -s "$THEMES/$DEFAULT" "$DEST"
else
    CUR=$(readlink -f "$DEST")
    rm -f "$DEST"
    if [ "$CUR" = "$THEMES/$DEFAULT" ]; then
        ln -s "$THEMES/$ADDITIONAL" "$DEST"
    else
        ln -s "$THEMES/$DEFAULT" "$DEST"
    fi
fi
