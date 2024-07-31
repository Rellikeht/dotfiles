if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <Leader>nld :JuliaDoc
vnoremap <silent> <buffer> <Leader>nld
      \ :<C-u>execute 'JuliaDoc '.GetVisualSelection()<CR>
