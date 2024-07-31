if exists("b:did_ftplugin")
  finish
endif

let b:compilers += ['clang']

compiler gcc
