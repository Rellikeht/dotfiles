#!/bin/sh
wget -O - `xclip -o` | `dmenu_path | dmenu` -
