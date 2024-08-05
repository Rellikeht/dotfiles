if exists("b:did_ftplugin")
  finish
endif

let b:compilers = get(b:, 'compilers', [])
let b:compilers += ['rustc', 'cargo']

compiler cargo
