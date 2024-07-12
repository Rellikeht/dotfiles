#!/usr/bin/env sh

grep -h --color=never -EriI \
    '^[nv]?(nore)?map (<silent> )?<leader>' \
    .vim/*.vim .vim/plug-handlers/ |
    sed -E '
    s/(v|n|nore|nnore|vnore)map/map/;
    s/<silent> //;
    s/L/l/;
    /^".*/d;
    s/^[\t ]*//;
    s/(^map <leader>[^ ]*) .*/\1/;
    ' |
    sort |
    uniq
