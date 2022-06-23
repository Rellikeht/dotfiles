#!/bin/sh
GEOM=`slop`
sleep 0.1
shotgun -g $GEOM ~/.shot.png
mtpaint ~/.shot.png
rm ~/.shot.png
