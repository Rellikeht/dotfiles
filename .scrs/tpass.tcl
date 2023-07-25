#!/usr/bin/env tclsh

#This is simple tcl script for entering password
#to use with SUDO_ASKPASS=/path/to/this/script/ sudo -A command

package require Tk

set gfg "#02aacd"
set gbg "#01080b"

. configure -background $gbg
wm attributes . -topmost 1 -type dialog
set wd 9
set hd 11
set msize [wm maxsize .]
set mx [lindex $msize 0]
set my [lindex $msize 1]
set ww [expr 2*$mx/$wd]
set wh [expr 2*$my/$hd]
set geom $ww\x$wh+[expr round($mx*(1.0/2-1.0/$wd))]+[expr round($my*(1.0/2-1.0/$hd))]
wm geometry . =$geom

set etext "Enter your password:"
set fs 20
font create tfont -size $fs -family systemSystemFont

label .l -textvariable etext -foreground $gfg -background $gbg -font tfont
entry .e -font tfont -foreground $gbg -background $gfg -show "*" -textvariable pass
grid .l -row 0 -column 0 -sticky s
grid .e -row 1 -column 0 
grid columnconfigure . 0 -weight 1
grid rowconfigure . 0 -weight 2
grid rowconfigure . 1 -weight 3
focus .e

bind . <Escape> {exit}
bind . <Return> {puts $pass;exit}
bind .e <Return> {puts $pass;exit}
