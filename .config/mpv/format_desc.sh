#!/bin/sh

grep --color=always -E '^\[NAME\(.*\]|^profile-desc' format_template.m4 | \
    sed -E 's/(profile-desc.*$)/\1\n/g'
