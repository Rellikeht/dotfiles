if exists("b:did_ftplugin")
  finish
endif

" For nim language server to work :(
" silent! exe '!touch ' . expand('%f') | edit <afile>

nnoremap <buffer> <silent> <Leader>nle
      \ :NixEdit<CR>
nnoremap <buffer> <Leader>nl<Space>
      \ :NixEdit<Space>

if get(b:, 'compilers', 0) == 0
  let b:compilers = []
endif
let b:compilers += ['nim']

compiler nim
