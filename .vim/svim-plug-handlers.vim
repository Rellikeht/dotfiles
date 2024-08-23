"{{{ Editor Config

packadd! editorconfig
let g:EditorConfig_disable = 0
let b:EditorConfig_disable = g:EditorConfig_disable
autocmd BufNewFile,BufRead * let b:EditorConfig_disable = g:EditorConfig_disable

nnoremap <Leader>qeb 
      \ :<C-u>let b:EditorConfig_disable=!b:EditorConfig_disable
      \ \|echo b:EditorConfig_disable<CR>
vnoremap <Leader>qeb 
      \ :<C-u>let b:EditorConfig_disable=!b:EditorConfig_disable
      \ \|echo b:EditorConfig_disable<CR>
      \ \|norm gv<CR>
nnoremap <Leader>qeg 
      \ :<C-u>let g:EditorConfig_disable=!g:EditorConfig_disable
      \ \|echo g:EditorConfig_disable<CR>
vnoremap <Leader>qeg 
      \ :<C-u>let g:EditorConfig_disable=!g:EditorConfig_disable
      \ \|echo g:EditorConfig_disable<CR>
      \ \|norm gv<CR>
nnoremap <silent> <Leader>qer 
      \ :<C-u>EditorConfigReload<CR>
vnoremap <silent> <Leader>qer 
      \ :<C-u>EditorConfigReload\|norm gv<CR>

"}}}

"{{{ CSS color

nnoremap <silent> gC :<C-u>call css_color#toggle()<CR>
vnoremap <silent> gC :<C-u>call css_color#toggle()\|norm gv<CR>

"}}}

"{{{ Inline edit

nnoremap <silent> glf :InlineEdit<CR>
vnoremap <silent> glf :InlineEdit\|norm gv<CR>

"}}}

"{{{ nim

function! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endfunction

noremap <silent> <Leader>dd :call JumpToDef()<CR>

"}}}

"{{{ TODO B vim-qf-diagnostics

"}}}

"{{{ other

" Enable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 1

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 0

"}}}
