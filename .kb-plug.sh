#!/bin/sh

cd ~
killall xcape

xmodmap .xmodmap/qwerty_start 2>/dev/null
xmodmap .xmodmaprc 2>/dev/null
xmodmap .xmodmaprc_local 2>/dev/null

~/.xcape_run.sh
