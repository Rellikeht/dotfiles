set rtp^="~/.opam/default/share/ocp-indent/vim"

" Syntax for undetected files
autocmd BufNewFile,BufRead .xmodmap/* set syntax=xmodmap
autocmd BufNewFile,BufRead .xbindkeys* set syntax=scheme

autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd syntax * syntax match Operator /[.]/

"autocmd BufNewFile,BufRead *.ml setlocal shiftwidth=4 softtabstop=4

autocmd FileType zig,nroff,nix setlocal shiftwidth=2 softtabstop=2 tabstop=2

"" For nim language server to work, dirty and not fully working
"" workaround, but good enough
"autocmd BufNewFile,BufRead *.nim silent! ! touch <afile>
"autocmd BufNewFile,BufRead *.nim silent! e <afile>
