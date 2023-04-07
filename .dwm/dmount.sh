#!/bin/sh
DOWNS=~/Pobrane

rm -rf $DOWNS/*
doas mount \
	-o rw,uid=$(id -u),size=16G \
	-t tmpfs none $DOWNS
