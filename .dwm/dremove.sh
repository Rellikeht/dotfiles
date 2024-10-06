#!/usr/bin/env sh

DOWNLOADS=~/Downloads/

if [ $(uname) = "FreeBSD" ]; then
    find -E $DOWNLOADS -iregex ".*\.(png|jpe?g)" -a -cmin +60 -delete

else
    find $DOWNLOADS -regextype egrep \
        -iregex ".*\.(png|jpe?g)" -a -cmin +60 -delete

fi
