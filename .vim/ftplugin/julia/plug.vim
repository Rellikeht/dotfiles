if exists("b:did_ftplugin")
  finish
endif

autocmd FileType julia 
      \ nnoremap <buffer> <Leader>nld :JuliaDoc
      \ | vnoremap <silent> <buffer> <Leader>nld
      \ :<C-u>execute 'JuliaDoc '.GetVisualSelection()<CR>
