#!/usr/bin/env sh

xclip -o |
    xargs -0 $(dmenu_path | dmenu)
