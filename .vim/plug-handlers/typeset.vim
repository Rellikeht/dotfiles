
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

" vimtex

" Viewer options: One may configure the viewer either by specifying a built-in
let g:vimtex_view_method = g:pdf_viewers[0]
" Works
let g:vimtex_compiler_method = 'latexmk'

" Also workWorkss
"let g:vimtex_compiler_method = 'tectonic'

" troff

autocmd FileType groff,troff,nroff setlocal shiftwidth=2 softtabstop=2 tabstop=2

" vim-markdown
" https://codeinthehole.com/tips/writing-markdown-in-vim/

let g:vim_markdown_borderless_table = 1
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_folding_level = 0
let g:vim_markdown_no_default_key_mappings = 0

" Fold heading in with the contents.
let g:vim_markdown_folding_style_pythonic = 1

" Autoshrink TOCs.
let g:vim_markdown_toc_autofit = 1

" Indentation for new lists. We don't insert bullets as it doesn't play
" nicely with `gq` formatting. It relies on a hack of treating bullets
" as comment characters.
" See https://github.com/plasticboy/vim-markdown/issues/232
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0

" Filetype names and aliases for fenced code blocks.
" let g:vim_markdown_fenced_languages = ['php', 'py=python', 'js=javascript', 'bash=sh', 'viml=vim']

" Format strike-through text (wrapped in `~~`).
let g:vim_markdown_strikethrough = 1

" typst
let g:typst_pdf_viewer = g:pdf_viewers[0]

" This on 0 is impossible to toggle
let g:typst_conceal=1

function TypstConcealToggle()
    let g:typst_conceal=!g:typst_conceal
    let g:typst_conceal_emoji=!g:typst_conceal_emoji
    let g:typst_conceal_math=!g:typst_conceal_math
    edit
endfunction

autocmd FileType typst nnoremap <buffer> <Leader>ntw :TypstWatch<CR>
autocmd FileType typst nnoremap <silent> <buffer> <Leader>ntt :call TypstConcealToggle()<CR>

" Common

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

nnoremap <silent> <Leader>ntn :call PdfViewerToggle('NextPdfViewer')<CR>
nnoremap <silent> <Leader>ntp :call PdfViewerToggle('PrevPdfViewer')<CR>
nnoremap <silent> <Leader>nts :call DocView('pdf')<CR>
