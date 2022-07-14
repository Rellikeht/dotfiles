#!/bin/sh

cd ~
killall xcape

xmodmap .xmodmap/qwerty_start
xmodmap .xmodmaprc

~/.xcape_run.sh
