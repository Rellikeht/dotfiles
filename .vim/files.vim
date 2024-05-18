" Netrw
" TODO C
let g:netrw_liststyle = 3
" Some day
" let g:netrw_banner = 0

" TODO D linestyle toggle
" map <Leader>xT :let g:netrw_liststyle=g:net

" TODO B file openinng

noremap <silent> <Leader>xx :Explore<CR>
noremap <Leader>xX :Explore<Space>
noremap <silent> <Leader>xt :Texplore<CR>
noremap <silent> <Leader>xh :Sexplore<CR>
noremap <silent> <Leader>xv :Vexplore<CR>
noremap <silent> <Leader>xn :Nexplore<CR>
noremap <silent> <Leader>xp :Pexplore<CR>
noremap <silent> <Leader>xr :Rexplore<CR>

" diff
" TODO A

nnoremap <silent> <leader>gdp :diffput<CR>
nnoremap <silent> <leader>gdg :diffget<CR>
nnoremap <silent> <leader>gdu :diffupdate<CR>
