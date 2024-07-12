#!/usr/bin/env sh

grep -Evi "^[ 	]*(\\[ 	]*}[ 	]*(\".*)|\".*)?$" $@
