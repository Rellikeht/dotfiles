#!/usr/bin/env sh

#xclip -o | xclip -selection clipboard -i
xclip -o -selection clipboard |
    xargs -0 $(dmenu_path | dmenu)
