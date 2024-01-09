#!/usr/bin/env sh

grep -Evi "^[ \t]*(\\[ \t]*}[ \t]*(\".*)|\".*)?$" $@
