#!/bin/sh
#xclip -o | xclip -selection clipboard -i
xclip -o | xargs `dmenu_path | dmenu`
