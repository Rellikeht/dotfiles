#!/bin/sh
alias echo="echo -e"
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
echo $dirs
#echo $dirs | sed -n "/\/$/s/\/$//p"
echo

cf=0
IFS="
"
opts="
l (list)	- list directories\\n
d (del)	- delete file\\n
s (skip)	- skip file\\n
q (quit)	- quit\\n
o (opts)	- list options\\n
r (run)	- open file with program\\n
c (cp)		- copy file
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

		elif [ $c = "c" ] 
		then
			cf=1
			read c
			while [ -z "`echo $c | grep -E \"^[0-9]+$\"`" ]
			do
				read c
				if [ $c = "q" ]
				then
					cf=2
					break
				fi
			done
			if [ $cf -eq 2 ]
			then
				cf=0
				continue
			fi
			break

		elif [ $c = "cp" ]
		then
			cf=1
			read c
			while [ -z "`echo $c | grep -E \"^[0-9]+$\"`" ]
			do
				read c
				if [ $c = "q" ]
				then
					cf=2
					break
				fi
			done
			if [ $cf -eq 2 ]
			then
				cf=0
				continue
			fi

		elif [ $c = "copy" ]
		then
			cf=1
			read c
			while [ -z "`echo $c | grep -E \"^[0-9]+$\"`" ]
			do
				read c
				if [ $c = "q" ]
				then
					cf=2
					break
				fi
			done
			if [ $cf -eq 2 ]
			then
				cf=0
				continue
			fi

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
			#echo $dirs | sed -n "/\/$/s/$\///p"
			echo $dirs
		elif [ $c = "list" ]
		then
			#echo $dirs | sed -n "/\/$/s/\/$//p"
			echo $dirs

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
			if [ -z `echo $f | grep -E "[^\\\\]/$"` ]
			then
				rm "$1$sp$f"
			else
				rm -r "$1$sp$f"
			fi
			break
		elif [ $c = "del" ]
		then
			if [ -z `echo $f | grep -E "[^\\\\]/$"` ]
			then
				rm "$1$sp$f"
			else
				rm -r "$1$sp$f"
			fi
			break
		elif [ $c = "delete" ]
		then
			if [ -z `echo $f | grep -E "[^\\\\]/$"` ]
			then
				rm "$1$sp$f"
			else
				rm -r "$1$sp$f"
			fi
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

	if [ $cf -eq 1 ]
	then
		cp "$1$sp$f" "`echo $dirs | sed -n \"/^$c/{s/$c //;s/^[\t ]*//gp}\"`"
		cf=0
		continue
	fi
	mv "$1$sp$f" "`echo $dirs | sed -n \"/^$c/{s/$c //;s/^[\t ]*//gp}\"`"
done
