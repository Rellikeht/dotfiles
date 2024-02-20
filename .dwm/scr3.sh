#!/bin/sh
wget -O - $(xclip -o -selection CLIPBOARD) |
    $(dmenu_path | dmenu) -
