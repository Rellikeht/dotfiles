#!/bin/sh
CONFFILE=.buttons.conf
HELP="
This is simple script for simple tasks (exiting meeting, mute/unmute, ...) in\n
online conferencing platforms (teams, zoom, discord, ...).\n
\t\n
\tUsage:\n
\t$0 [options] command\n
\n
\tAvailable options:\n
\t\t-h - this help message\n
\t\t-b file - file with positions of buttons\n
\t\tdefaults to $CONFFILE\n
\t\t-w window - window with platform\n
\t\t-s - select window via xdotool\n
\t\t-d args - write standard output\n
\t\tvia prog given by -p option\n
\t\t(defaults to dzen2)\n
\t\t-f file - file with number of window\n
\t\twith teams\n
\t\t-n name - name of platform to click\n
\t\tit is also used for selecting window\n
\n
\tAvaliable commands:\n
\t\tbuttons (b, btn)\n
\t\tconfigure (con, c)\n
\t\thand (h)\n
\t\tleave (l)\n
\t\tmute (m)\n
"

#PNAME="Microsoft Teams"
WINFILE=win
#OUTPROG=dzen2
BTNS="exit mute time accept hand"

get_field ()
{
	echo $@ | cut -f $(($1+1)) -d " "
}

get_btnx ()
{
	echo $`$1`X
}

get_btny ()
{
	echo $`$1`Y
}

btn_add ()
{
	read b
	BTNS=`echo $btns $b`
}

btns_sel ()
{
	echo Current list of buttons:
	echo $BTNS
	echo -n "Do you want to define more (y/n): "
	read c
	while [ -n `echo $c | grep y` ]
	do
		btn_add
		echo -n "Do you want to define more (y/n): "
		read c
	done
}

win_sel ()
{
	WINDOW=`xdotool selectwindow`
}

calibrate ()
{
	for btn in BTNS
	do
		echo Select button for $btn
		CONF=`xdotool selectwindow getmouselocation --shell`
		export `echo $CONF | sed "s/X/$btnX/;s/Y/$btnY/"`
		echo $CONF >> $CONFFILE
	done
	
	if [ -n "$WINDOW" ]
	then
		win_sel
	fi
}

#write_conf ()
#{
#	
#}

i=1
while [ -n "`get_field $i $@ | grep -E '^-'`" ]
do

	case `get_field $i $@` in
		"-h")
			echo $HELP
			exit
		;;

		"-b")
			if [ -e $3 ]
			then
				i=$((i+1))
				export `cat get_field $i $@`
			fi
		;;

		"-n")
			i=$((i+1))
			PNAME=get_field $i $@		
		;;

		"-w")
			i=$((i+1))
			WINDOW=get_field $i $@		
		;;

		"-s")
			win_sel
		;;
	esac
	i=$((i+1))
done

echo $WINDOW
echo $PNAME
echo $CONFFILE

#if [ -e $CONFFILE ]
#then
#	export `cat $CONFFILE`
#else
#	calibrate
#fi
#
#if [ -e $WINFILE -a -n `cat $WINFILE | xdotool getwindowname - | grep '$NAME'` ]
#then
#	WINDOW=`cat $WINFILE`
#fi

#case "$1" in
#	c(onf)?)
#		calibrate
#	;;
#	
#	m(ute)?)
#		xdotool mousemove $MUTEX $MUTEY click --window $WINDOW 1 mousemove restore
#	;;
#	
#	l(eave)?)
#		xdotool mousemove $LEAVEX $LEAVE click --window $WINDOW 1 mousemove restore
#	;;
#	
#	h(and)?)
#		xdotool mousemove $HANDX $HANDY click --window $WINDOW 1 mousemove restore
#	;;
#
#esac
