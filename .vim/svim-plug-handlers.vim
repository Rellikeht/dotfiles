" Editor Config {{{ 

packadd! editorconfig
let g:EditorConfig_disable = 0
let b:EditorConfig_disable = g:EditorConfig_disable
autocmd BufNewFile,BufRead * let b:EditorConfig_disable = g:EditorConfig_disable

nnoremap <Leader>qeb 
      \ :<C-u>let b:EditorConfig_disable=!b:EditorConfig_disable
      \ \|echo b:EditorConfig_disable<CR>
nnoremap <Leader>qeg 
      \ :<C-u>let g:EditorConfig_disable=!g:EditorConfig_disable
      \ \|echo g:EditorConfig_disable<CR>
nnoremap <silent> <Leader>qer 
      \ :<C-u>EditorConfigReload<CR>

" }}} 

" CSS color {{{ 

nnoremap <silent> gC :<C-u>call css_color#toggle()<CR>

" }}} 

" Inline edit {{{ 

nnoremap <silent> <Leader>mi :InlineEdit<CR>

" }}} 

" nim {{{ 

function! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endfunction

noremap <silent> <Leader>dd :call JumpToDef()<CR>

" }}} 

" TODO B vim-qf-diagnostics {{{ 

" }}} 

" vim-simple-complete {{{ 

let g:vsc_type_complete = 1
let g:vsc_tab_complete = 0
let g:vsc_completion_command = "\<C-N>"
let g:vsc_reverse_completion_command = "\<C-P>"
let g:vsc_type_complete_length = 3
let g:vsc_pattern = '\k'

" }}} 

" other {{{ 

" Enable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 1

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 0

" }}} 
