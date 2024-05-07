
let g:pdf_viewers = ['zathura', 'mupdf']
let g:cur_pdf_viewer = 0

function NextPdfViewer()
    let g:cur_pdf_viewer = (g:cur_pdf_viewer+1)%len(g:pdf_viewers)
    return g:pdf_viewers[g:cur_pdf_viewer]
endfunction

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

" This on 0 is impossible to toggle
let g:typst_conceal=1

function TypstConcealToggle()
    let g:typst_conceal=!g:typst_conceal
    let g:typst_conceal_emoji=!g:typst_conceal_emoji
    let g:typst_conceal_math=!g:typst_conceal_math
    edit
endfunction

autocmd FileType typst map <buffer> <Leader>ncw :TypstWatch<CR>

" Common

function PdfViewerToggle()
    let viewer = NextPdfViewer()
    let g:typst_pdf_viewer = viewer
    let g:vimtex_view_method = viewer
endfunction

map <Leader>nct :call TypstConcealToggle()<CR>
map <Leader>ncn :call PdfViewerToggle()<CR>
