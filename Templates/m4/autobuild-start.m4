#!/usr/bin/env sh
changequote([,])changequote(`,`)dnl
define(`def_build_dir`,`build`)dnl
define(`loop_condition`,`! [ -e "$BUILD_FILE" ]`)dnl
define(`loop_pre`,``)dnl
define(`loop_post`,``)dnl
