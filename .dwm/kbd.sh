#!/usr/bin/env sh

TEMP1="$(mktemp)"
TEMP2="$(mktemp)"

clean() {
  rm -fr "$TEMP1" "$TEMP2"
  exit 0
}
trap clean EXIT INT

kbs() {
  xinput |
    sed -En '/keyboard/s#^ *. ?(.+)[ \t]*id=.*#\1#gp' |
    sort |
    uniq
}

plug() {
  # To balance startup time of some (chinise) keyboards
  sleep 4
  echo plugged
  ~/.kb-plug.sh
}

kbs >"$TEMP2"
while true; do
  cat "$TEMP2" >"$TEMP1"
  kbs >"$TEMP2"
  diff -q "$TEMP1" "$TEMP2" >/dev/null || plug &
  sleep 1
done
