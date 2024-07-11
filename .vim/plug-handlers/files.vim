"{{{ eunch
" TODO

noremap <silent> <Leader>;ws :<C-u>SudoWrite<CR>

"}}}

"{{{ vifm

noremap <Leader>xf :<C-u>EditVifm<CR>
noremap <Leader>xs :<C-u>VsplitVifm<CR>
noremap <Leader>xh :<C-u>SplitVifm<CR>
noremap <Leader>xt :<C-u>TabVifm<CR>
noremap <Leader>xd :<C-u>DiffVifm<CR>
noremap <Leader>xp :<C-u>PeditVifm<CR>

noremap <Leader>xF :<C-u>EditVifm<Space>
noremap <Leader>xS :<C-u>VsplitVifm<Space>
noremap <Leader>xH :<C-u>SplitVifm<Space>
noremap <Leader>xT :<C-u>TabVifm<Space>
noremap <Leader>xD :<C-u>DiffVifm<Space>
noremap <Leader>xP :<C-u>PeditVifm<Space>

noremap <C-w><Leader>xf :<C-u>tabnew<CR>:EditVifm<CR>
noremap <C-w><Leader>xd :<C-u>tabnew<CR>:DiffVifm<CR>
noremap <C-w><Leader>xp :<C-u>tabnew<CR>:PeditVifm<CR>

noremap <C-w><Leader>xF :<C-u>tabnew<CR>:EditVifm<Space>
noremap <C-w><Leader>xD :<C-u>tabnew<CR>:DiffVifm<Space>
noremap <C-w><Leader>xP :<C-u>tabnew<CR>:PeditVifm<Space>

"}}}

"{{{ others

" if nerdtree happens it will land here
" or nnn

"}}}
