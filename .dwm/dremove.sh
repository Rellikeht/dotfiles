#!/bin/sh

DOWNLOADS=~/Downloads/

find $DOWNLOADS -regextype egrep \
    -iregex ".*\.(png|jpe?g)" -a -cmin +60 -delete
    # -exec rm -rf {}
