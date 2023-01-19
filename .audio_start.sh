#!/bin/sh

rp () {
	if [ -z "`ps a | grep -E \"$1$\" | grep -v grep`" ]
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
ri "pipewire" "dbus-launch pipewire"
ri "pipewire-media-session" "dbus-launch pipewire-media-session"
ri "pipewire-pulse" "dbus-launch pipewire-pulse"
ri "mic_lev_stab.sh" ".dwm/mic_lev_stab.sh"

# jackd -dalsa -dhw:1
