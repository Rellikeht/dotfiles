#!/usr/bin/env sh

BUILD_FILE="build_file()"
BUILD_DIR="def_build_dir()"
if [ -n "$1" ]; then
    BUILD_DIR="$1"
fi

while ! [ -e "$BUILD_FILE" ]; do
    cd .. || exit 1
    if [ "$PWD" = "/" ]; then
        echo "Reached /" >/dev/stderr
        exit 1
    fi
done

exec build_command
