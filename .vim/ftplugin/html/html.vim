if exists("b:did_ftplugin")
  finish
endif

setlocal shiftwidth=2 softtabstop=2 tabstop=2

let b:compilers = get(b:, 'compilers', [])
