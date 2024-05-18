" Editor Config

packadd editorconfig
let g:EditorConfig_disable = 0
let b:EditorConfig_disable = g:EditorConfig_disable
autocmd BufNewFile,BufRead * let b:EditorConfig_disable = g:EditorConfig_disable
noremap <Leader>qeb :let b:EditorConfig_disable=!b:EditorConfig_disable<CR>
noremap <Leader>qeg :let g:EditorConfig_disable=!g:EditorConfig_disable<CR>
noremap <silent> <Leader>qer :EditorConfigReload<CR>

" Colorizer

let g:colorizer_maxlines = 500
noremap <silent> gC :ColorToggle<CR>

" Inline edit

noremap <silent> glf :InlineEdit<CR>

" nim

function! JumpToDef()
    if exists("*GotoDefinition_" . &filetype)
        call GotoDefinition_{&filetype}()
    else
        exe "norm! \<C-]>"
    endif
endfunction

map <silent> <Leader>dd :call JumpToDef()<CR>
