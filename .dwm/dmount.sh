#!/usr/bin/env sh

DOWNS=~/Downloads

rm -rf "$DOWNS"/*
doas mount \
    -o rw,uid="$(id -u)",size=16G \
    -t tmpfs none $DOWNS
