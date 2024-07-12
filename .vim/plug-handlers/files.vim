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

noremap <Leader>xfF :<C-u>EditVifm<Space>
noremap <Leader>xfS :<C-u>VsplitVifm<Space>
noremap <Leader>xfH :<C-u>SplitVifm<Space>
noremap <Leader>xfT :<C-u>TabVifm<Space>
noremap <Leader>xfD :<C-u>DiffVifm<Space>
noremap <Leader>xfP :<C-u>PeditVifm<Space>

noremap <C-w><Leader>xff :<C-u>tabnew<CR>:EditVifm<CR>
noremap <C-w><Leader>xfd :<C-u>tabnew<CR>:DiffVifm<CR>
noremap <C-w><Leader>xfp :<C-u>tabnew<CR>:PeditVifm<CR>

noremap <C-w><Leader>xfF :<C-u>tabnew<CR>:EditVifm<Space>
noremap <C-w><Leader>xfD :<C-u>tabnew<CR>:DiffVifm<Space>
noremap <C-w><Leader>xfP :<C-u>tabnew<CR>:PeditVifm<Space>

"}}}

"{{{ others

" if nerdtree happens it will land here
" or nnn

"}}}
