#!/bin/sh
stime=`date +%s%N`
bc=0
c=

pr=3
if [ -n "$1" ]
then
	pr=$1
fi

echo 3 seconds to start...
sleep 3
echo start

while [ "$c" != "q" ]
do
	read c
	bc=$(($bc + 1))
done

etime=`date +%s%N`
dtime=$(($etime - $stime))
dtimes=`dc -e "$pr k $dtime 1000000000 / p"`
bps=`dc -e "$pr k $bc $dtime 1000000000 / / p"`
bpm=`dc -e "$pr k $bps 60 * p"`
echo $dtimes seconds elapsed
echo Your bpm is $bps bps
echo or $bpm bpm
