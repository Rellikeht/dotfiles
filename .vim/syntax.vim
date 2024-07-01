set breakindentopt=shift:2,min:40,sbr

" Syntax for undetected files
autocmd BufNewFile,BufRead .xmodmap/* set syntax=xmodmap
autocmd BufNewFile,BufRead .xbindkeys* set syntax=scheme

autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd syntax * syntax match Operator /[.]/

"autocmd BufNewFile,BufRead *.ml setlocal shiftwidth=4 softtabstop=4

autocmd FileType haskell,lua,r,markdown,nim
            \ setlocal shiftwidth=2 softtabstop=2 tabstop=2
