if exists("b:did_ftplugin")
  finish
endif

setlocal shiftwidth=2 softtabstop=2 tabstop=2
setlocal comments=sr:(*\ ,mb:\ ,ex:*)
setlocal comments^=sr:(**,mb:\ \ ,ex:*)
setlocal commentstring=(*%s*)

" vim:sw=2 fdm=indent
