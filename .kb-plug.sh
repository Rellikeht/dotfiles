#!/bin/sh

cd ~
killall xcape

xmodmap .xmodmap/qwerty_start
xmodmap .xmodmaprc

#xmodmap -e 'keycode 23 = Mode_switch ISO_Left_Tab Tab ISO_Left_Tab Tab ISO_Left_Tab'
xmodmap -e 'keycode 23 = Mode_switch'
xmodmap -e 'keycode any = Tab'
~/.xcape_run.sh
