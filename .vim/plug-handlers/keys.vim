
" Repeat
" silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" vim-sneak

let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
map - <Plug>Sneak_,
map + <Plug>Sneak_;

" tinyMRU
map <Leader>E :ME<Space>
map <Leader>S :MS<Space>
map <Leader>V :MV<Space>
map <Leader>T :MT<Space>

" others

map <Leader>qu :call GeneralUpgrade()<CR>
map <Leader>qP :PlugClean!<CR>
