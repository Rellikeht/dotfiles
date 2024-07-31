set breakindentopt=shift:2,min:40,sbr

" Syntax for undetected files
autocmd BufNewFile,BufRead */.xmodmap/* set syntax=xmodmap
autocmd BufNewFile,BufRead .xbindkeys* set syntax=scheme

autocmd syntax * syntax match Operator /[.]/
