set rtp^="~/.opam/default/share/ocp-indent/vim"

" Syntax for undetected files
autocmd BufNewFile,BufRead .xmodmap/* set syntax=xmodmap
autocmd BufNewFile,BufRead .xbindkeys* set syntax=scheme

autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd syntax * syntax match Operator /[.]/

"autocmd BufNewFile,BufRead *.ml setlocal shiftwidth=4 softtabstop=4

autocmd FileType haskell,lua setlocal shiftwidth=2 softtabstop=2 tabstop=2

"" For nim language server to work, dirty and not fully working
"" workaround, but good enough
"autocmd BufNewFile,BufRead *.nim silent! ! touch <afile>
"autocmd BufNewFile,BufRead *.nim silent! e <afile>

let g:buffmt = 1
let g:bufcomp = 1
autocmd BufNewFile,BufRead * let b:buffmt = g:buffmt
autocmd BufNewFile,BufRead * let b:bufcomp = g:bufcomp

" Very temporary but should work well enough
autocmd BufWritePre *.nix call NixFmt()

" This should go to programming section
autocmd BufWritePost *.ms call CompileGroffMs()
