if !has("nvim")
  au BufNewFile,BufReadPre,BufEnter *.mll
        \ set filetype=ocamllex
endif
" au BufNewFile,BufReadPre,BufEnter *.mll
"       \ set filetype=ocamllex
"       \ | set syntax=ocaml
au BufNewFile,BufReadPre,BufEnter *.mll
      \ set syntax=ocaml
