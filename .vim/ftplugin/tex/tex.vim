if exists("b:did_ftplugin")
  finish
endif

setlocal shiftwidth=2 softtabstop=2 tabstop=2

let if get(b:, 'compilers', 0) == 0
  let b:compilers = []
endif
b:compilers += ['tex']

if &makeprg == 'make'
  compiler tex
endif
