#! /bin/dash
pip install --upgrade `pip list | grep -oE "^.*\s" | grep -vE "^Package|^[-]+" | grep $1` $2
