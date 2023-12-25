" vim-sneak

let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
map - <Plug>Sneak_,
map + <Plug>Sneak_;

" others

map <Leader>BN :NixEdit<CR>

" for quick scope to activate with delay
let g:qs_delay = 50
