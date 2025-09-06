#!/usr/bin/env sh

m4 -DBLOCK_DEVICE="$2" "${0%/*}/helpers.m4" "$1"
