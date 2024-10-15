if exists("b:did_ftplugin")
  finish
endif

setlocal shiftwidth=2 softtabstop=2 tabstop=2

let b:compilers = get(b:, 'compilers', [])
let b:compilers += ['zig_build_exe', 'zig_build', 'zig', 'zig_test']

compiler zig_build_exe

" :(
setlocal complete-=i,d
