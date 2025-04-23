ifdef(`loop`,``,define(`loop`,`
while ifelse(`$1`,``,`loop_condition()`,`$1`); do
    cd .. || exit 1
    if [ "$PWD" = "/" ]; then
        echo "Reached /" >/dev/stderr
        exit 1
    fi
done
`))dnl

BUILD_FILE="build_file()"
BUILD_DIR="def_build_dir()"
if [ -n "$1" ]; then
    BUILD_DIR="$1"
fi

loop_pre()

loop()

loop_post()

if ! [ -d "$BUILD_DIR" ]; then
    setup_project()
fi

exec build_command
