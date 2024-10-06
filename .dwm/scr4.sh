#!/usr/bin/env sh

xclip -o -selection clipboard | xargs -0 xdotool type
