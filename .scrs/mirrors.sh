#!/bin/sh

THS=200

#CMD="reflector --threads $THS --fastest 10 --sort delay --protocol https"
CMD="reflector --threads $THS --latest 40 --fastest 10 --sort age --protocol https"

if [ -n "$1" ]
then
    eval $CMD --save "$1"
else
    eval $CMD
fi
