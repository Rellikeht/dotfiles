# Main functions
define(MAINF, '$1audio+$1video[height$2=HEIGHT()]/$1[height$2=HEIGHT()]$3')dnl
define(NAME, NM()$@)dnl
define(HEIGHT, HG())dnl

# Shortcut functions
define(BESTB, MAINF(best, $1, $2))dnl
define(BEST, BESTB(<, $1))dnl
define(BESTR, BESTB(>, $1))dnl
define(BESTF, BEST([fps>=FREQ()]))dnl
# ??
define(BESTRF, BEST([fps>=FREQ()]))dnl

# Simple shortcuts and arbitrary definitions
define(SORT, profile=ytdl-ssort)dnl
define(BIG, profile=big)dnl
define(FREQ, 50)dnl
define(SHOW, HEIGHT()p)dnl

# And finally
include(format_template.m4)dnl
