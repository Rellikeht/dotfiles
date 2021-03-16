#!/bin/sh
n=$1
if [ -z $n ]
then 
	n=10
fi
time "for i in \`seq 1 $n\`; do read b; done"
