#!/bin/sh

rp () {
	if [ -z "`ps a | egrep \"$1$\" | grep -v grep`" ]
	then
		$2
	fi
}

nc () {
	echo nc: $@
	nohup $@ > /dev/null &
}

ri () {
	if [ -n "$2" ]
	then
		PR="$2"
	else
		PR="$1"
	fi
	rp $1 "nc $PR"
}

cd
ri "pipewire"
ri "pipewire-pulse"
ri "pipewire-media-session"
ri "mic_lev_stab.sh" ".dwm/mic_lev_stab.sh"

# jackd -dalsa -dhw:1
