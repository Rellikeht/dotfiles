if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <Leader>ntw :TypstWatch<CR>
nnoremap <silent> <buffer> <Leader>ntt
      \ :call TypstConcealToggle()<CR>

let if get(b:, 'compilers', 0) == 0
  let b:compilers = []
endif
b:compilers += ['typst']

" Plugin does this and here it breaks
" compiler typst
