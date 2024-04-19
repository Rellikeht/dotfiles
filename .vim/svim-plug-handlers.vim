packadd editorconfig
let g:EditorConfig_disable = 0
let b:EditorConfig_disable = g:EditorConfig_disable
autocmd BufNewFile,BufRead * let b:EditorConfig_disable = g:EditorConfig_disable
map <Leader>qeb :let b:EditorConfig_disable=!b:EditorConfig_disable<CR>
map <Leader>qeg :let g:EditorConfig_disable=!g:EditorConfig_disable<CR>
map <Leader>qer :EditorConfigReload<CR>

let g:colorizer_maxlines = 500
map gC :ColorToggle<CR>

map glf :InlineEdit<CR>
