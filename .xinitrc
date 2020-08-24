#!/bin/sh
xrdb .Xresources
#[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
exec i3
#picom &
#urxvt
#qterminal
