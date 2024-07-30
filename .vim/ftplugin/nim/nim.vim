if exists("b:did_ftplugin")
  finish
endif

" For nim language server to work :(
autocmd BufNewFile *.nim 
      \ silent! exe '!touch ' . expand('%f')
      \ | argedit! <afile>
