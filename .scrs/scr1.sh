#!/bin/sh
#xclip -o | xclip -selection clipboard -i
xclip -o -selection CLIPBOARD | xargs `dmenu_path | dmenu`
