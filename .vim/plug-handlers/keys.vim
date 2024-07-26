"{{{ Repeat

" silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
" Because that does't work with cgn and
" probably some other mappings
nmap ., <Plug>(RepeatDot)

"}}}

"{{{ vim-sneak
" TODO colors

let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#prompt = '  < sneak > '

let g:sneak#s_next = 0

noremap f <Plug>Sneak_f
noremap F <Plug>Sneak_F
noremap t <Plug>Sneak_t
noremap T <Plug>Sneak_T
noremap s <Plug>Sneak_s
noremap S <Plug>Sneak_S
noremap <C-p> <Plug>Sneak_,
noremap <C-n> <Plug>Sneak_;

"}}}

"{{{ TODO A abolish

"}}}

"{{{ vis

noremap <Leader>is :S
noremap <Leader>ib :B

"}}}

"{{{ others

nnoremap <silent> <Leader>qu :silent! call GeneralUpgrade()<CR>
nnoremap <silent> <Leader>qP :silent! PlugClean!<CR>

"}}}
