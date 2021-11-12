#!/bin/sh

rp () {
	if [ -z "`ps a | egrep \"$1$\" | grep -v grep`" ]
	then
		$2
	fi
}

nc () {
	nohup $1 > /dev/null &
}

ri () {
	rp $1 "nc $1"
}

ri "pipewire"
ri "pipewire-pulse"
ri "pipewire-media-session"
ri "~/.scrs/mic_lev_stab.sh"

# jackd -dalsa -dhw:1
