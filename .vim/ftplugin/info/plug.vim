if &buftype == 'nofile' && &filetype == 'info'
  nmap <buffer> u <Plug>(InfoUp)
  nmap <buffer> + <Plug>(InfoNext)
  nmap <buffer> - <Plug>(InfoPrev)
  nmap <buffer> = <Plug>(InfoMenu)
  nmap <buffer> J <Plug>(InfoFollow)
  nmap <buffer> o :<C-u>GotoNode<Space>
  nmap <buffer> O :<C-u>GotoNode<CR>
endif
