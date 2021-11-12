#!/bin/sh

kl () {
	killall $1 pipewire-pulse
	killall $1 pipewire-media-session
	killall $1 pipewire
	killall $1 mic_lev_stab.sh
}

kl

if [ -n "top -b | grep pipewire" ]
then
	kl -9
fi
