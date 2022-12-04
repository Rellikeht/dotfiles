" Syntax for undetected files
autocmd BufNewFile,BufRead .xmodmap/* set syntax=xmodmap
autocmd BufNewFile,BufRead .xbindkeys* set syntax=scheme
autocmd FileType json syntax match Comment +\/\/.\+$+

autocmd syntax * syntax match Operator /[.]/
"autocmd FileType zig setlocal shiftwidth=4 softtabstop=4

autocmd BufNewFile,BufRead *.zig setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd BufNewFile,BufRead *.ml setlocal shiftwidth=4 softtabstop=4 expandtab
