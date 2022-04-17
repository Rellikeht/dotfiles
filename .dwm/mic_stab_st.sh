#!/bin/sh

nlvl=`wjt | awk "BEGIN {RS=\";\"} {print \\$NF}"`
echo $nlvl > .mlevel
