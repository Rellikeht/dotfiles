set rtp^="~/.opam/default/share/ocp-indent/vim"

" Syntax for undetected files
autocmd BufNewFile,BufRead .xmodmap/* set syntax=xmodmap
autocmd BufNewFile,BufRead .xbindkeys* set syntax=scheme

autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd syntax * syntax match Operator /[.]/

"autocmd BufNewFile,BufRead *.ml setlocal shiftwidth=4 softtabstop=4

" zig
autocmd FileType nroff,nix,haskell setlocal shiftwidth=2 softtabstop=2 tabstop=2

"" For nim language server to work, dirty and not fully working
"" workaround, but good enough
"autocmd BufNewFile,BufRead *.nim silent! ! touch <afile>
"autocmd BufNewFile,BufRead *.nim silent! e <afile>

let g:buffmt = 1

autocmd BufNewFile,BufRead * let b:buffmt = g:buffmt
map <Leader>qf :let b:buffmt=!b:buffmt<CR>
map <Leader>qF :let g:buffmt=!g:buffmt<CR>

map <Leader>q1 :echo b:buffmt<CR>

function NixFmt()
    " Everything hardcoded, because vim goes crazy when using
    " variables and can't be or is very hard to get synchronous
    if executable('alejandra') && b:buffmt
        0,$!alejandra -q
    endif
endfunction

" Very temporary but should work well enough
autocmd BufWritePre *.nix call NixFmt()

autocmd FileType nix setlocal commentstring=#\ %s
