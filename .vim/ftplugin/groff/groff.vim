if exists("b:did_ftplugin")
  finish
endif

setlocal shiftwidth=2 softtabstop=2 tabstop=2

let b:compilers = get(b:, 'compilers', [])
let b:compilers += ['troff']

let g:troff_flavor = "groff"

compiler troff
