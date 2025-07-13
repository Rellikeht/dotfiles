if exists("b:did_ftplugin")
  finish
endif

setlocal formatoptions-=t formatoptions+=croql

compiler nim

let g:syntastic_nim_checkers = ["nim"]
