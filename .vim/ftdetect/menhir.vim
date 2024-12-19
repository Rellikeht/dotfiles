if !has("nvim")
  au BufNewFile,BufReadPre,BufEnter *.mly
        \ set filetype=menhir
endif
au BufNewFile,BufReadPre,BufEnter *.mly
      \ set syntax=yacc
