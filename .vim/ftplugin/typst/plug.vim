if exists("b:did_ftplugin")
  finish
endif

autocmd FileType typst 
      \ nnoremap <buffer> <Leader>ntw :TypstWatch<CR>
      \ | nnoremap <silent> <buffer> <Leader>ntt
      \ :call TypstConcealToggle()<CR>
