"{{{ Editor Config

packadd editorconfig
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

"{{{ Colorizer

let g:colorizer_maxlines = 500
nnoremap <silent> gC :ColorToggle<CR>
vnoremap <silent> gC :ColorToggle\|norm gv<CR>

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
