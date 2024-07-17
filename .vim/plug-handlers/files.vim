"{{{ eunch
" TODO

noremap <silent> <Leader>;ws :<C-u>SudoWrite<CR>

"}}}

"{{{ vifm

noremap <Leader>xff :<C-u>EditVifm<CR>
noremap <Leader>xfs :<C-u>VsplitVifm<CR>
noremap <Leader>xfh :<C-u>SplitVifm<CR>
noremap <Leader>xft :<C-u>TabVifm<CR>
noremap <Leader>xfd :<C-u>DiffVifm<CR>
noremap <Leader>xfp :<C-u>PeditVifm<CR>

noremap <Leader>xf<Space>f :<C-u>EditVifm<Space>
noremap <Leader>xf<Space>s :<C-u>VsplitVifm<Space>
noremap <Leader>xf<Space>h :<C-u>SplitVifm<Space>
noremap <Leader>xf<Space>t :<C-u>TabVifm<Space>
noremap <Leader>xf<Space>d :<C-u>DiffVifm<Space>
noremap <Leader>xf<Space>p :<C-u>PeditVifm<Space>

noremap <C-w><Leader>xff :<C-u>tabnew<CR>:EditVifm<CR>
noremap <C-w><Leader>xfd :<C-u>tabnew<CR>:DiffVifm<CR>
noremap <C-w><Leader>xfp :<C-u>tabnew<CR>:PeditVifm<CR>

noremap <C-w><Leader>xf<Space>f :<C-u>tabnew<CR>:EditVifm<Space>
noremap <C-w><Leader>xf<Space>d :<C-u>tabnew<CR>:DiffVifm<Space>
noremap <C-w><Leader>xf<Space>p :<C-u>tabnew<CR>:PeditVifm<Space>

"}}}

"{{{ others

" if nerdtree happens it will land here
" or nnn

"}}}
