#!/bin/sh

DEFCONFFILE=.buttons.conf
DEFWINFILE=.win
CONFFILE=$DEFCONFFILE
WINFILE=$DEFWINFILE
INTERACT=0

HELP="
Usage:\n
\t$0 [options] command [arguments]\n
\n
\tAvalialbe options\n
\t(elements in square brackets aren't\n
\tavailable in interactive mode):\n
\t\t-h - show this help\n
\t\t-g - print window number\n
\t\t-c file - configuration file\n
\t\t-C file - configuration file (create if doesn't exist)\n
\t\t-w [number] - number of window\n
\t\t-W file - file for storing number of window\n
\t\t-i - run commands interactively\n
\t\t-d - create default files\n
\n
\tAvailable commands\n
\t(elements in square brackets aren't\n
\tavailable in interactive mode):\n
\t\thelp (h)\n
\t\tselect (s, sel)\n
\t\tbuttons (b, btn)\n
\t\taction (a, act) [args]\n
\t\tadd (a) [name] [args]\n
\t\tdel (d) [name]\n
"

get_field ()
{
	echo $@ | cut -f $(($1+1)) -d " "
}

win_sel ()
{
	WINDOW=`xdotool selectwindow`
}

print_conf ()
{
	sed "s/=/:/" $CONFFILE
}

actions_ref ()
{
	if [ -e "$CONFFILE" ]
	then
		ACTIONS="`sed -z "s/\n/\\\\\n/" $CONFFILE`"
	fi
}

action_add ()
{
	echo $@ >> $CONFFILE
	actions_ref
}

action_del ()
{
	cat $CONFFILE | sed "/$1/d;w $CONFFILE"
	actions_ref
}

action_add_int ()
{
	echo Actions already defined:
	echo $ACTIONS
	echo -n 'Enter name: '
	read name
	echo -n 'Do you want to enter coordinates from keyboard (y/n): '
	read c

	if [ -n "`echo $c | grep y`" ]
	then
		echo -n 'Enter x: '
		read X
		echo -n 'Enter y: '
		read Y
	else
		export `xdotool selectwindow getmouselocation --shell | grep -E "[XY]"`
	fi
	
	echo -n 'Enter action (default is xdotool click --window $WINDOW 1): '
	read action
	if [ -z "$action" ]
	then
		action='xdotool click --window $WINDOW 1'
	fi
	echo $name $X $Y $action >> $CONFFILE
}

action_del_int ()
{
	echo Select action to delete:
	echo $ACTIONS
}

if [ -e "$WINFILE" ]
then
	WINDOW=`cat $WINFILE`
fi

actions_ref

i=1
while [ -n "`get_field $i $@ | grep -E '^-'`" ]
do
	case `get_field $i $@` in

		"-h")
			echo $HELP
			exit
		;;

		"-g")
			echo $WINDOW
			exit
		;;

		"-d")
			touch $DEFCONFFILE
			touch $DEFWINFILE			
		;;

		"-i")
			if [ $INTERACT -eq 1 ]
			then
				INTERACT=0
			else
				INTERACT=1
			fi
		;;

		"-w")
			i=$((i+1))
			if [ $INTERACT -eq 1 ]
			then
				win_sel
			else
				WINDOW=`get_field $i $@`
			fi
			echo $WINDOW > $WINFILE
			continue
		;;

		"-W")
			i=$((i+1))
			if [ -e "`get_field $i $@`" ]
			then
				WINFILE=`get_field $i $@`
				WINDOW=`cat $WINFILE`
			fi
			continue
		;;

		"-c")
			i=$((i+1))
			if [ -e "`get_field $i $@`" ]
			then
				export `cat get_field $i $@`
				CONFFILE=`cat get_field $i $@`
				actions_ref
			fi
			continue
		;;

		"-C")
			i=$((i+1))
			if [ -e "`get_field $i $@`" ]
			then
				export `cat get_field $i $@`
				CONFFILE=`cat get_field $i $@`
			else
				touch $CONFFILE
			fi
			actions_ref
			continue
		;;

	esac
	i=$((i+1))
done

while [ -n "`get_field $i $@`" ]
do
	case `get_field $i $@` in

		"h"|"help")
			echo $HELP
			exit
			;;

		"s"|"sel"|"select")
			if [ $INTERACT -eq 1 ]
			then
				win_sel
			else
				i=$((i+1))
				WINDOW=`get_field $i $@`
			fi
			echo $WINDOW > $WINFILE
			continue
		;;

		"b"|"btn"|"buttons")
			if [ -e $CONFFILE ]
			then
				print_conf
				exit
			fi
		;;

		"d"|"del")
			if [ $INTERACT -eq 1 ]
			then
				action_del_int
			else
				action_del
			fi
		;;

		"a"|"add")
			if [ $INTERACT -eq 1 ]
			then
				action_add_int
			else
				action_add
			fi
		;;

		*)
			i=$((i+1))
			NAME=`get_field $i $@`
			if [ -z "$NAME" ]
			then
				continue
			fi

#			echo $ACTIONS
			ACTION=`echo $ACTIONS | grep $NAME`
			if [ -n "$ACTION" ]
			then
				X=`echo $ACTION | awk "{print \\\$2}"`
				Y=`echo $ACTION | awk "{print \\\$3}"`
				export `xdotool getmouselocation --shell | sed -E "/^[^XYW]/d;s/[A-Z]+/\0b/g"`
				xdotool windowfocus $WINDOW mousemove $X $Y
				EXE=`echo $ACTION | sed -E "s/^([^ ]*[ ]){3}//"`
				sh -c "export WINDOW=$WINDOW;$EXE"
				xdotool mousemove $Xb $Yb windowfocus $WINDOWb
			fi
			continue
		;;

	esac
	i=$((i+1))
done
