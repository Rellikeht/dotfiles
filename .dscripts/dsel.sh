#!/bin/sh
while DIR="`ls --color=never -dap * | grep -E "/$" | dmenu`";do cd "$DIR";done
pwd
