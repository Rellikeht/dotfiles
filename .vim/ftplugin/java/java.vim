if exists("b:did_ftplugin")
  finish
endif

if get(b:, 'compilers', 0) == 0
  let b:compilers = []
endif
let b:compilers += ['javac']

compiler javac
