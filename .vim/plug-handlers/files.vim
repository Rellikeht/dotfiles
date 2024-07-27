"{{{ eunuch

"{{{ helpers

function! EQFcmd(cmd, before = '')
  call QFsel('C', 'L', a:before, a:cmd)
endfunction

"}}}

"{{{ sudo, wall

nnoremap <silent> <Leader>;sw :<C-u>SudoWrite<CR>
vnoremap <silent> <Leader>;sw :<C-u>SudoWrite\|norm gv<CR>
nnoremap <silent> <Leader>;s<Space>w
      \ :<C-u>SudoWrite<Space>
vnoremap <silent> <Leader>;s<Space>w
      \ :<C-u>SudoWrite  \|norm gv
      \ <C-Left><C-Left><Left>

nnoremap <silent> <Leader>;se :<C-u>SudoEdit<CR>
vnoremap <silent> <Leader>;se :<C-u>SudoEdit\|norm gv<CR>
nnoremap <silent> <Leader>;s<Space>e
      \ :<C-u>SudoEdit<Space>
vnoremap <silent> <Leader>;s<Space>e
      \ :<C-u>SudoEdit  \|norm gv
      \ <C-Left><C-Left><Left>

nnoremap <silent> <Leader>;sa :<C-u>Wall<CR>
vnoremap <silent> <Leader>;sa :<C-u>Wall\|norm gv<CR>

"}}}

"{{{ find

noremap <silent> <Leader>;fc
      \ :<C-u>Cfind . -type f -name ''<Left>
noremap <silent> <Leader>;fC
      \ :<C-u>Cfind! . -type f -name ''<Left>
noremap <silent> <Leader>;fl
      \ :<C-u>Lfind . -type f -name ''<Left>
noremap <silent> <Leader>;fL
      \ :<C-u>Lfind! . -type f -name ''<Left>

noremap <silent> <Leader>;f<Space>c
      \ :<C-u>Cfind . -type f -name<Space>
noremap <silent> <Leader>;f<Space>C
      \ :<C-u>Cfind! . -type f -name<Space>
noremap <silent> <Leader>;f<Space>l
      \ :<C-u>Lfind . -type f -name<Space>
noremap <silent> <Leader>;f<Space>L
      \ :<C-u>Lfind! . -type f -name<Space>

noremap <silent> <Leader>;ff
      \ :<C-u>call EQFcmd('find . -type f -name ""')
      \ <Left><Left><Left>
noremap <silent> <Leader>;fF
      \ :<C-u>call EQFcmd('find! . -type f -name ""')
      \ <Left><Left><Left>

noremap <silent> <Leader>;f;c :<C-u>Cfind<Space>
noremap <silent> <Leader>;f;C :<C-u>Cfind!<Space>
noremap <silent> <Leader>;f;l :<C-u>Lfind<Space>
noremap <silent> <Leader>;f;L :<C-u>Lfind!<Space>

"}}}

"{{{ locate

noremap <silent> <Leader>;pc
      \ :<C-u>Clocate . -type f -name ''<Left>
noremap <silent> <Leader>;pC
      \ :<C-u>Clocate! . -type f -name ''<Left>
noremap <silent> <Leader>;pl
      \ :<C-u>Llocate . -type f -name ''<Left>
noremap <silent> <Leader>;pL
      \ :<C-u>Llocate! . -type f -name ''<Left>

noremap <silent> <Leader>;p<Space>c
      \ :<C-u>Clocate . -type f -name<Space>
noremap <silent> <Leader>;p<Space>C
      \ :<C-u>Clocate! . -type f -name<Space>
noremap <silent> <Leader>;p<Space>l
      \ :<C-u>Llocate . -type f -name<Space>
noremap <silent> <Leader>;p<Space>L
      \ :<C-u>Llocate! . -type f -name<Space>

noremap <silent> <Leader>;pf
      \ :<C-u>call EQFcmd('locate . -type f -name ""')
      \ <Left><Left><Left>
noremap <silent> <Leader>;pF
      \ :<C-u>call EQFcmd('locate! . -type f -name ""')
      \ <Left><Left><Left>

noremap <silent> <Leader>;p;c :<C-u>Clocate<Space>
noremap <silent> <Leader>;p;C :<C-u>Clocate!<Space>
noremap <silent> <Leader>;p;l :<C-u>Llocate<Space>
noremap <silent> <Leader>;p;L :<C-u>Llocate!<Space>

"}}}

" noremap <silent> <Leader>;ff :<C-u>EQFcmd('find')<CR>

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
