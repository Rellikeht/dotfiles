#!/bin/sh
xrdb -load .Xresources
#[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
exec i3 #xmonad
#xrandr --output LVDS-1 --off
#nitrogen --restore
#picom &
#urxvtd &
#urxvt
