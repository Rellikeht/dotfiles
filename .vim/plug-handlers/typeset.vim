
" TODO toggling this in plugins
let g:pdf_viewers = ['zathura', 'mupdf']

" vimtex

" Viewer options: One may configure the viewer either by specifying a built-in
let g:vimtex_view_method = 'zathura'
" Works
let g:vimtex_compiler_method = 'latexmk'

" Also workWorkss
"let g:vimtex_compiler_method = 'tectonic'

" troff

autocmd FileType groff,troff,nroff setlocal shiftwidth=2 softtabstop=2 tabstop=2

" vim-markdown
" https://codeinthehole.com/tips/writing-markdown-in-vim/

let g:vim_markdown_borderless_table = 1

" typst
let g:typst_pdf_viewer='zathura'

function TypstConcealToggle()
    let g:typst_conceal=!g:typst_conceal
    let g:typst_conceal_emoji=!g:typst_conceal_emoji
    let g:typst_conceal_math=!g:typst_conceal_math
    edit
endfunction

map ,ncT :call TypstConcealToggle()<CR>
