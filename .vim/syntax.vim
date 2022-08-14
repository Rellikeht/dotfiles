" Syntax for undetected files
autocmd BufNewFile,BufRead .xmodmap/* set syntax=xmodmap
autocmd BufNewFile,BufRead .xbindkeys* set syntax=scheme
autocmd FileType json syntax match Comment +\/\/.\+$+

autocmd syntax * syntax match Operator /[.]/
