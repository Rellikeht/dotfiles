if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <Leader>ntw :TypstWatch<CR>
nnoremap <silent> <buffer> <Leader>ntt
      \ :call TypstConcealToggle()<CR>

let b:compilers = get(b:, 'compilers', [])
let b:compilers += ['typst']

" Plugin does this and here it breaks
" compiler typst
