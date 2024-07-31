if exists("b:did_ftplugin")
  finish
endif

setlocal shiftwidth=2 softtabstop=2 tabstop=2

" Command line window
if &buftype == "nofile" && bufname() == ""
  noremap <buffer> <C-m> <CR>
endif
