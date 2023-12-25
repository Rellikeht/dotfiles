" cosco

"nmap <silent> ; <Plug>(cosco-commaOrSemiColon)
imap <silent> <C-;> <C-o><Plug>(cosco-commaOrSemiColon)

" vimtex

" Viewer options: One may configure the viewer either by specifying a built-in
let g:vimtex_view_method = 'zathura'
" Works
let g:vimtex_compiler_method = 'latexmk'

" Also workWorkss
"let g:vimtex_compiler_method = 'tectonic'

" others

autocmd FileType zinc setlocal commentstring=%\ %s
autocmd FileType zinc setlocal shiftwidth=2 softtabstop=2 tabstop=2

let g:zig_fmt_autosave = 1
