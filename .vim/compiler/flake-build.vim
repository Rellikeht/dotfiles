if exists('current_compiler')
    finish
endif
let current_compiler = 'flake-build'

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat=error:\ %m\ at\ %f:%l:%c,builder\ for\ \'%m\'\ failed\ with\ exit\ code\ %n,fixed-output\ derivation\ produced\ path\ \'%s\'\ with\ %m
CompilerSet makeprg=nix\ build
