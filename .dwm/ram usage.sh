#!/bin/sh
free -h | grep -m 1 -E "[0-9]" | awk '{/\<[0-9,]{1,5}/;print " RAM < Used: " $3 " | Avail: " $7 " | All: " $2 " > "}'
