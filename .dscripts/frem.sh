#!/bin/sh
ls --color=never -d Pobrane/* | dmenu | xargs -d "\n" rm
