if exists("b:did_ftplugin")
  finish
endif

setlocal shiftwidth=2 softtabstop=2 tabstop=2

let b:compilers = if get(b:, 'compilers', [])
let b:compilers += ['troff']

compiler troff
