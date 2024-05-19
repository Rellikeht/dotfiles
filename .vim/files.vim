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

function DiffGet(pane)
    execute 'diffget' a:pane
    diffupdate
endfunction

function DiffPut(pane)
    execute 'diffget' a:pane
    diffupdate
endfunction

nnoremap <silent> <leader>gdp :diffput<CR>
nnoremap <silent> <leader>gdg :diffget<CR>
nnoremap <silent> <leader>gdu :diffupdate<CR>

nnoremap <silent> <leader>gg0 :call DiffGet('//0')<CR>
nnoremap <silent> <leader>gg1 :call DiffGet('//1')<CR>
nnoremap <silent> <leader>gg2 :call DiffGet('//2')<CR>
nnoremap <silent> <leader>gg3 :call DiffGet('//3')<CR>

nnoremap <silent> <leader>gp0 :call DiffPut('//0')<CR>
nnoremap <silent> <leader>gp1 :call DiffPut('//1')<CR>
nnoremap <silent> <leader>gp2 :call DiffPut('//2')<CR>
nnoremap <silent> <leader>gp3 :call DiffPut('//3')<CR>

nnoremap <silent> <leader>gpf :call DiffPut(expand('%:p'))<CR>
nnoremap <silent> <leader>gpF :call DiffPut(expand('%:t'))<CR>
nnoremap <silent> <leader>ggf :call DiffGet(expand('%:p'))<CR>
nnoremap <silent> <leader>ggF :call DiffGet(expand('%:t'))<CR>

