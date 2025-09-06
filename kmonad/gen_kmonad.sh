#!/usr/bin/env sh

if ! [ -r "$1" ]; then
    echo "First argument must be name of file containing configuration"
    exit 1
fi

if ! [ -e "$2" ]; then
    echo "Second argument must be a block device of keyboard"
    exit 1
fi

sed "s#\"BLOCK_DEVICE\"#\"$2\"#" "$1"
