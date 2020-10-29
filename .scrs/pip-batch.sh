#! /bin/dash
pip $1 `pip list | grep -oE "^.*\s" | grep -vE "^Package|^[-]+" | grep $2` $3
