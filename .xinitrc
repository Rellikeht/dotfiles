#!/bin/sh
xrdb .Xresources
export QT_QPA_PLATFORM=xcb
export TERMINAL=st
xhost +
#urxvtd -o -f -q &
#[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
rm .config/nitrogen/nitrogen.cfg 
rm .config/nitrogen/bg-saved.cfg
ln .config/nitrogen/nitrogen.i3.cfg .config/nitrogen/nitrogen.cfg 
ln .config/nitrogen/bg-saved.i3.cfg .config/nitrogen/bg-saved.cfg 
nitrogen --restore
exec i3
