"{{{ eunch
" TODO

nnoremap <silent> <Leader>;ws :SudoWrite<CR>

"}}}

"{{{ vifm

noremap <Leader>xf :EditVifm<CR>
noremap <Leader>xs :VsplitVifm<CR>
noremap <Leader>xh :SplitVifm<CR>
noremap <Leader>xt :TabVifm<CR>
noremap <Leader>xd :DiffVifm<CR>
noremap <Leader>xp :PeditVifm<CR>

noremap <Leader>xF :EditVifm<Space>
noremap <Leader>xS :VsplitVifm<Space>
noremap <Leader>xH :SplitVifm<Space>
noremap <Leader>xT :TabVifm<Space>
noremap <Leader>xD :DiffVifm<Space>
noremap <Leader>xP :PeditVifm<Space>

noremap <C-w><Leader>xf :tabnew<CR>:EditVifm<CR>
noremap <C-w><Leader>xd :tabnew<CR>:DiffVifm<CR>
noremap <C-w><Leader>xp :tabnew<CR>:PeditVifm<CR>

noremap <C-w><Leader>xF :tabnew<CR>:EditVifm<Space>
noremap <C-w><Leader>xD :tabnew<CR>:DiffVifm<Space>
noremap <C-w><Leader>xP :tabnew<CR>:PeditVifm<Space>

"}}}

" if nerdtree happens it will land here

"{{{ others

" if nerdtree happens it will land here
" or nnn

"}}}
