#!/bin/sh
#xclip -o | xclip -selection clipboard -i
xclip -o -selection clipboard |
    xargs -0 $(dmenu_path | dmenu)
