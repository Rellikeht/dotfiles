if exists("b:did_ftplugin")
  finish
endif

let b:compilers += ['python']

compiler python
