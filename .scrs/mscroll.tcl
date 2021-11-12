#!/bin/wish
#package require Tk

# cursor position
# winfo pointerxy .
# 
# screen size
# winfo screenwidth .
# winfo screenheight .

set LTIME 100
set WSIZE 32
set WINX [expr [winfo pointerx .]+$WSIZE/2]
set WINY [expr [winfo pointery .]+$WSIZE/2]
set WIN .

set FNAME "mc.png"
#if {[file exists $FNAME]} \
#{
#	set IFILE $FNAME
#} else {
#	set IFILE ""
#}
set IFILE $FNAME

proc setupWindow {} \
{
	global LTIME WSIZE WINX WINY WIN IFILE

	# needs compositor
	wm attributes $WIN -alpha 0.2
	wm attributes $WIN -fullscreen 0 -topmost 1
	focus $WIN
	wm geometry $WIN \
		"${WSIZE}x$WSIZE+[expr $WINX-$WSIZE]+[expr $WINY-$WSIZE]"
	wm resizable $WIN 0 0

	bind $WIN <q> exit
	bind $WIN <ButtonRelease-2> exit

	set IMGO [image create photo -file $IFILE]
	set IMW [image width $IMGO]
	set IMH [image height $IMGO]
	set IMG [image create photo]
	$IMG copy $IMGO -subsample [expr $IMW/$WSIZE] [expr $IMH/$WSIZE]
	canvas .c -width $WSIZE -height $WSIZE
	.c create image [expr $WSIZE/2] [expr $WSIZE/2] -image $IMG
	pack .c
}

proc mainLoop {} \
{
	global LTIME WIN WINX WINY WSIZE
	set ML 20
	after $LTIME

	for {set i 0} {$i < $ML} {incr i} \
	{
		after $LTIME
		set cursor_pos_x [winfo pointerx $WIN]
		set cursor_pos_y [winfo pointery $WIN]
		set horizontal_move [expr $cursor_pos_x-$WINX+$WSIZE/2]
		set vertical_move [expr $cursor_pos_y-$WINY+$WSIZE/2]
		puts "$vertical_move $horizontal_move"
	}
}

setupWindow
after 50 mainLoop

#after 2000 exit
