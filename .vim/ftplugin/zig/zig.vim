if exists("b:did_ftplugin")
  finish
endif

compiler zig_build_exe

" :(
autocmd FileType zig setlocal complete-=i,d
