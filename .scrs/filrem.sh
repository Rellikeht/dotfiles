#!/bin/sh
IFS="
"

if [ -z "$1" ]
then
	echo "Usage:"
	echo "$0 [options] <first_directory> [second_directory]"
	echo
	echo "-l switches	-	are switches to ls command used inside script, mainly for -A"
	echo "-r			-	if present, script will remove files instead of keeping only them"
	echo "-e			-	whether to check if files are extactly the same"
	echo Warning: script cant recognize multiple switches at once, like -rl
	exit
else

	sp=.
	sw=
	rev=
	switch=
	exa=
	for o in $@
	do
		if [ -n "$sw" ]
		then
			sw=
			switch=$o
			continue
		fi

		if [ -z "`echo \"$o \" | grep -E \"^-\"`" ]
		then
			if [ -z "$fp" ]
			then
				fp=$o
				continue
			else
				sp=$o
				continue
			fi

		else
			if [ -n "`echo $o | grep -E \"\-r\"`" ]
			then
				rev=1
				continue

			elif [ -n "`echo \"$o \" | grep -E \"\-e\"`" ]
			then
				exa=1
				continue

			elif [ -n `echo $o | grep -E "^-l .*"` ]
			then
				sw=1
				continue
			fi
		fi
	done
fi

if [ -n "$exa" ]
then

	if [ -n "$rev" ]
	then
		for f1 in $sp/*
		do
			cf=`echo $f1 | sed "s/$sp/$fp/"`
			if [ "`diff -q $f1 $cf 2>&1`" ]
			then
				continue
			fi
			rm $f1
		done

	else
		for f1 in $sp/*
		do
			cf=`echo $f1 | sed "s/$sp/$fp/"`
			if [ "`diff -q $f1 $cf 2>&1`" ]
			then
				rm $f1
			fi
		done
	fi

else

	if [ -n "$rev" ]
	then
		for f1 in $sp/*
		do
			cf=`echo $f1 | sed "s/$sp/$fp/"`
			if [ -e $cf ]
			then
				continue
			fi
			rm $f1
		done

	else
		for f1 in $sp/*
		do
			cf=`echo $f1 | sed "s/$sp/$fp/"`
			if [ -e $cf ]
			then
				rm $f1
			fi
		done
	fi

fi
