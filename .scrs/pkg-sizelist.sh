#!/bin/sh
pacman -Qi | \
	awk 'BEGIN {ORS="	"} /Rozmiar/ {print $5, $6}  /Nazwa/ {print $3}' | \
	sed -E 's/(B)	([a-z])/\1\n\2/g' | \
	awk 'BEGIN {OFS=""} {print $2, $3, " ", $1}' | \
	sort -hr
