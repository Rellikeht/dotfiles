#!/usr/bin/env sh

export LANG=en

acpi -b |
    sed -Ez '
    s/.*Discharging,/BAT/;
    s/.*[Cc]harging,/AC/g;
    s/, ([^ ]*) .*/ \1 |/;
    s/\n/ NOT CHARGING |/'

#acpi -b | \
#    sed -Ez 's/.* ([0-9]{1,3}%).*/\1/'
