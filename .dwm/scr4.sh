#!/bin/sh
xclip -o -selection clipboard | xargs -0 xdotool type
