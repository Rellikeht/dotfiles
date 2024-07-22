"{{{ pdf viewers

let g:pdf_viewers = ['zathura', 'mupdf', '']
let g:cur_pdf_viewer = 0

function NextPdfViewer()
    let vlen = len(g:pdf_viewers)
    let g:cur_pdf_viewer = (g:cur_pdf_viewer+1)%vlen
    return g:pdf_viewers[g:cur_pdf_viewer]
endfunction

function PrevPdfViewer()
    let vlen = len(g:pdf_viewers)
    let g:cur_pdf_viewer = (g:cur_pdf_viewer+vlen-1)%vlen
    return g:pdf_viewers[g:cur_pdf_viewer]
endfunction

function PdfViewerToggle(fn)
    let viewer = call(function(a:fn), [])
    let g:typst_pdf_viewer = viewer
    let g:vimtex_view_method = viewer
    echo viewer
endfunction

function DocView(ext)
    " This doesn't trigger "Press ENTER or type command ..." message
    execute 'silent !'.g:pdf_viewers[g:cur_pdf_viewer].' '.expand('%:p:r').'.'.a:ext.' &'
    redraw!
endfunction

nnoremap <silent> <Leader>nvn
            \ :call PdfViewerToggle('NextPdfViewer')<CR>
nnoremap <silent> <Leader>nvp
            \ :call PdfViewerToggle('PrevPdfViewer')<CR>
nnoremap <silent> <Leader>nvs
            \ :call DocView('pdf')<CR>

"}}}

"{{{ vimtex
" TODO C make this complete

" Viewer options: One may configure the viewer either by specifying a built-in
let g:vimtex_view_method = g:pdf_viewers[0]
" Works
let g:vimtex_compiler_method = 'latexmk'

" Also workWorkss
"let g:vimtex_compiler_method = 'tectonic'

"}}}

"{{{ troff

autocmd FileType groff,troff,nroff 
            \ setlocal shiftwidth=2 softtabstop=2 tabstop=2

"}}}

"{{{ TODO B pandoc

" doesn't cooperate with neovim ?
let g:pandoc#modules#disabled = [
            \ 'bibliographies'
            \ ]

"}}}

"{{{ typst

let g:typst_pdf_viewer = g:pdf_viewers[0]

" This on 0 is impossible to toggle
let g:typst_conceal=1

function TypstConcealToggle()
    let g:typst_conceal=!g:typst_conceal
    let g:typst_conceal_emoji=!g:typst_conceal_emoji
    let g:typst_conceal_math=!g:typst_conceal_math
    edit
endfunction

autocmd FileType typst 
            \ nnoremap <buffer> <Leader>ntw :TypstWatch<CR>
            \ | nnoremap <silent> <buffer> <Leader>ntt
            \ :call TypstConcealToggle()<CR>

"}}}
