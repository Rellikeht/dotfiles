if exists("b:did_ftplugin")
  finish
endif

let b:compilers += ['gcc']

compiler gcc
