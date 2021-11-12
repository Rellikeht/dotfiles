#!/bin/sh
xclip -o | xargs -0 `dmenu_path | dmenu`
