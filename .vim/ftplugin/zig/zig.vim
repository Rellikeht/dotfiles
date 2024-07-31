if exists("b:did_ftplugin")
  finish
endif

if get(b:, 'compilers', 0) == 0
  let b:compilers = []
endif
let b:compilers += ['zig_build_exe', 'zig_build', 'zig', 'zig_test']

compiler zig_build_exe

" :(
setlocal complete-=i,d
