#!/usr/bin/env sh

wget -O - $(xclip -o -selection CLIPBOARD) |
    $(dmenu_path | dmenu) -
