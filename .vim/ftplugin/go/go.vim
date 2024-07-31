if exists("b:did_ftplugin")
  finish
endif

let if get(b:, 'compilers', 0) == 0
  let b:compilers = []
endif
b:compilers += ['go']

compiler go
