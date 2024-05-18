
" Repeat
" silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" vim-sneak

let g:sneak#label = 1
noremap f <Plug>Sneak_f
noremap F <Plug>Sneak_F
noremap t <Plug>Sneak_t
noremap T <Plug>Sneak_T
noremap - <Plug>Sneak_,
noremap + <Plug>Sneak_;

" tinyMRU
nnoremap <silent> <Leader>E :ME<Space>
nnoremap <silent> <Leader>S :MS<Space>
nnoremap <silent> <Leader>V :MV<Space>
nnoremap <silent> <Leader>T :MT<Space>

" others

nnoremap <silent> <Leader>qu :call GeneralUpgrade()<CR>
nnoremap <silent> <Leader>qP :PlugClean!<CR>
