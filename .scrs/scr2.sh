#!/bin/sh
xdotool mousemove 0 0
echo "^ca(1, echo 1)  1  ^ca()\n^ca(2, st)  2  ^ca()" | dzen2 -p -m h -l 2 -w 100 -h 30 # -e "entermaster=grabkeys;enterslave=grabkeys;key_Escape=exit;key_Super_L=exec:sh ~/.scrs/ststart.sh;"
