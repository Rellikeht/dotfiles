#!/bin/sh

DIFC=diff
if [ $(uname) = "FreeBSD" ]; then
    DIFC=gdiff
fi

echo $DIFC

for i in .[a-z]*; do
    if [ -e "$HOME/$i" ]; then
        DIFF=$($DIFC --color=always -r "$i" "$HOME/$i")
        if [ -n "$DIFF" ]; then
            echo "$DIFF" |
                sed "1i $i\n" |
                less -r
        fi
    fi
done
