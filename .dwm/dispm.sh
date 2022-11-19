#!/bin/sh
# Script for automatically setting laptop and one external
# screen (names are from my setup) next to each other with
# "maximum" settings

# Resolution and refresh rate for my laptop screen
LRES=1920x1080
LRATE=120

# And names of laptop and external screen
LAPTOP=eDP-1
EXTERNAL=HDMI-1-0

if [ -n "`xrandr | grep HDMI | grep disconnect`" ]
then
	# My default setting, xrandr --output $LAPTOP --auto may set
	# the same, but I didn't fully trust it
	xrandr --output $EXTERNAL --off
	xrandr --output $LAPTOP --mode $LRES --pos 0x0 --rate $LRATE --primary

else
	# Info about external screen and topmost (hopefully highest) resolution
	INFO="`xrandr | 
		grep -A1 $EXTERNAL | 
		sed 1d`"

	# Rates for that resolution
	RATES="`echo $INFO | \
		sed -z 's/^[ \t]*[^ \t]*[ \t]*//;
			s/[*+]//g;
			s/[ \t]\+/\n/g'`"

	# Best resolution and rate
	HRES=`echo $INFO | awk '{print $1}'`
	HRATE=`echo "$RATES" | awk '$0>x{x=$0};END{print x}'`

	# Positions, laptop on the right
	HPOS=0x0
	LPOS="`echo $HRES | sed 's/x.*//'`x0"
	MONP="--primary"
	LAPP=""

	for i in "$@"
	do
		if [ "$i" = "-l" ]
		then
			# Laptop on the left if -l is present
			HPOS=1920x0
			LPOS=0x0

		elif [ "$i" = "-p" ]
		then
			# Laptop as primary if -p is present
			LAPP="--primary"
			MONP=""
		fi
	done

	# Setting all of that
	xrandr --output $EXTERNAL --mode $HRES --pos $HPOS --rate $HRATE $MONP
	xrandr --output $LAPTOP --mode $LRES --pos $LPOS --rate $LRATE $LAPP
fi

# I use nitrogen for desktop background, so it needs to adjust
# after changing setup
nitrogen --restore
