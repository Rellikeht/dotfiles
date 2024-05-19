" Netrw
" TODO C
let g:netrw_liststyle = 3
" Some day
" let g:netrw_banner = 0

" TODO D linestyle toggle
" map geqT :let g:netrw_liststyle=g:net

" TODO B file openinng

noremap <silent> gxex :Explore<CR>
noremap gxeX :Explore<Space>
noremap <silent> gxet :Texplore<CR>
noremap <silent> gxeh :Sexplore<CR>
noremap <silent> gxev :Vexplore<CR>
noremap <silent> gxen :Nexplore<CR>
noremap <silent> gxep :Pexplore<CR>
noremap <silent> gxer :Rexplore<CR>

" diff

function DiffGet(pane)
    execute 'diffget' a:pane
    diffupdate
endfunction

function DiffPut(pane)
    execute 'diffget' a:pane
    diffupdate
endfunction

nnoremap <silent> <leader>fdp :diffput<CR>
nnoremap <silent> <leader>fdg :diffget<CR>
nnoremap <silent> <leader>fdu :diffupdate<CR>

" TODO more
nnoremap <silent> <leader>fg0 :call DiffGet('//0')<CR>
nnoremap <silent> <leader>fg1 :call DiffGet('//1')<CR>
nnoremap <silent> <leader>fg2 :call DiffGet('//2')<CR>
nnoremap <silent> <leader>fg3 :call DiffGet('//3')<CR>

nnoremap <silent> <leader>fp0 :call DiffPut('//0')<CR>
nnoremap <silent> <leader>fp1 :call DiffPut('//1')<CR>
nnoremap <silent> <leader>fp2 :call DiffPut('//2')<CR>
nnoremap <silent> <leader>fp3 :call DiffPut('//3')<CR>

nnoremap <silent> <leader>fpf :call DiffPut(expand('%:p'))<CR>
nnoremap <silent> <leader>fpF :call DiffPut(expand('%:t'))<CR>
nnoremap <silent> <leader>fgf :call DiffGet(expand('%:p'))<CR>
nnoremap <silent> <leader>fgF :call DiffGet(expand('%:t'))<CR>

