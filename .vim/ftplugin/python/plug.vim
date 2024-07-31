if exists("b:did_ftplugin")
  finish
endif

let b:compilers = if get(b:, 'compilers', [])
let b:compilers += ['python']

compiler python
