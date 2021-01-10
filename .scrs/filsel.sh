#!/bin/sh
if [ -n "$2" ]
then
	if [ -z "`echo $2 | grep -E \"/$\"`" ]
	then
		spd="/"
	fi
	dirs="`ls -AFL \"$2$spd\" | nl -s "$2$spd" -n ln | sed -z \"s/\n/\\\\\n/g\"`"
	#  sed \"s/(.*)/\0/\" |
else
	dirs="`ls -AFL | sed -n \"/\//s/\///gp\" | nl -n ln | sed -z \"s/\n/\\\\\n/g\"`"
fi
#echo $dirs
echo $dirs | sed -n "/\/$/s/\/$//p"
echo

IFS="
"
opts="
 l (list)	- list directories\n
d (del)	- delete file\n
s (skip)	- skip file\n
q (quit)	- quit\n
o (opts)	- list options\n
r (run)	- open file with program\n
"

rn()
{
	read prog
	$prog $1
}

files=`ls -FAL1p "$1" | sed -z "s/\n/\\\\\n/g"`
if [ -z "$1" ]
then
	files=`ls -FAL | grep -vE "[\*/@]"`
fi
#echo $files
#echo

sp=""
if [ "$1" = "\." ]
then
	sp="/"
elif [ -z "`echo $1 | grep -E \"/$\"`" ]
then
	sp="/"
fi

for f in `echo $files`
do
	while true
	do
		echo $f
		read c

		if [ -z "$c" ]
		then
			continue

		elif [ $c = "q" ] 
		then
			exit
		elif [ $c = "quit" ]
		then
			exit

		elif [ $c = "o" ]
		then
			echo $opts
		elif [ $c = "opts" ]
		then
			echo $opts
		elif [ $c = "options" ]
		then
			echo $opts

		elif [ $c = "l" ]
		then
			echo $dirs | sed -n "/\/$/s/$\///p"
		elif [ $c = "list" ]
		then
			echo $dirs | sed -n "/\/$/s/\/$//p"

		elif [ $c = "s" ]
		then
			break
		elif [ $c = "skip" ]
		then
			break

		elif [ $c = "r" ]
		then
			echo -n "Enter name of the program: "
			rn "$1$sp$f"
		elif [ $c = "run" ]
		then
			echo -n "Enter name of the program: "
			rn "$1$sp$f"

		elif [ $c = "d" ]
		then
			rm "$1$sp$f"
			break
		elif [ $c = "del" ]
		then
			rm "$1$sp$f"
			break
		elif [ $c = "delete" ]
		then
			rm "$1$sp$f"
			break

		elif [ -n "`echo $c | grep -E \"^[0-9]+$\"`" ]
		then
			break
		fi
	done

	if [ $c = "s" ]
	then 
		continue
	elif [ $c = "skip" ]
	then
		continue
	elif [ $c = "d" ]
	then
		continue
	elif [ $c = "del" ]
	then
		continue
	elif [ $c = "delete" ]
	then
		continue
	fi

	mv "$1$sp$f" "`echo $dirs | sed -n \"/^$c/{s/$c //;s/^[\t ]*//gp}\"`"
done

