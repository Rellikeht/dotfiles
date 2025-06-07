function s:SetupEchoFile()
  autocmd VimResume *
        \ checktime
        \ | echo expand('%:p')

  autocmd BufEnter *
        \ if !get(g:, 'no_file_msg', 1)
        \ | if len(get(g:, 'prev_dir', '')) == 0
        \ | let g:prev_dir = expand('%:p:h')
        \ | else
        \ | call EchoRelCurFile()
        \ | endif
        \ | endif
        \ | if g:autochdir && (&buftype == '') && (!has_key(g:ftype_hooks, &filetype))
        \ | if isdirectory(expand('%:p:h'))
        \ | exe 'lcd %:p:h'
        \ | endif
        \ | endif

  autocmd BufLeave *
        \ if (&buftype == '') && (!has_key(g:ftype_hooks, &filetype))
        \ | if isdirectory(expand('%:p'))
        \ | let g:prev_dir = expand('%:p:h:h')
        \ | elseif isdirectory(expand('%:p:h'))
        \ | let g:prev_dir = expand('%:p:h')
        \ | else
        \ | let g:prev_dir = ''
        \ | endif
        \ | endif
endfunction
call lazy_utils#LoadOnStartup(expand("<SID>").."SetupEchoFile")

function s:InsertFixKeys()
  silent! sunmap ii
  silent! sunmap iI
  silent! sunmap f
  silent! sunmap s
  silent! sunmap t
  silent! sunmap F
  silent! sunmap S
  silent! sunmap T
endfunction
call lazy_utils#LoadOnInsert(expand("<SID>").."InsertFixKeys")
