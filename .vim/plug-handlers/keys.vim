" vim-sneak

let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
map - <Plug>Sneak_,
map + <Plug>Sneak_;

" fzf
map <leader>sf :FZF<CR>
map <leader>sH :FZF ~<CR>
map <leader>sT :FZF ~/Templates<CR>
map <leader>sp2 :FZF ../..<CR>
map <leader>sp3 :FZF ../../..<CR>
map <leader>sp4 :FZF ../../../..<CR>
map <leader>sp5 :FZF ../../../../..<CR>

" others

map <Leader>BN :NixEdit<CR>

" for quick scope to activate with delay
let g:qs_delay = 50
