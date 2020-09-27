#!/bin/sh
xrdb .Xresources
export QT_QPA_PLATFORM=xcb
#[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
exec enlightenment_start
#picom &
#urxvt
#qterminal
