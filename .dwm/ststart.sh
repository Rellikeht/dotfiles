#!/bin/sh
seq 1 4 | dzen2 -p -m h -l 4 -w 200 -h 80 -e "entermaster=grabkeys;enterslave=grabkeys;key_Escape=exit;key_Return=exec:st;"
