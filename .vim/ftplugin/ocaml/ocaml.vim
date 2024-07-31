if exists("b:did_ftplugin")
  finish
endif

" setlocal shiftwidth=2 softtabstop=2 tabstop=2
setlocal shiftwidth=4 softtabstop=4 tabstop=4

let b:compilers += ['ocaml']

compiler ocaml
