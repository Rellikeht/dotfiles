if exists("b:did_ftplugin")
  finish
endif

" setlocal shiftwidth=2 softtabstop=2 tabstop=2
setlocal shiftwidth=4 softtabstop=4 tabstop=4

let if get(b:, 'compilers', 0) == 0
  let b:compilers = []
endif
b:compilers += ['ocaml']

compiler ocaml
