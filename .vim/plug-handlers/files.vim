" {{{ eunuch

" {{{ helpers

function! EQFcmd(cmd, before = '')
  call QFsel('C', 'L', a:before, a:cmd)
endfunction

" }}}

" {{{ sudo, wall

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

" }}}

" {{{ find

noremap <Space>/c g:qfloc ?
      \ ':<C-u>Lfind<Space>'
      \ : ':<C-u>Cfind<Space>'
noremap <Space>/C g:qfloc ?
      \ ':<C-u>Lfind!<Space>'
      \ : ':<C-u>Cfind!<Space>'

noremap <expr> <Space>/f g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "**"<Left><Left>'
      \ : ':<C-u>Cfind . -type f -name "**"<Left><Left>'
noremap <expr> <Space>/F g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "**"<Left><Left>'
      \ : ':<C-u>Cfind! . -type f -name "**"<Left><Left>'

noremap <expr> <Space>/d g:qfloc ?
      \ ':<C-u>Lfind . -type d -name "**"<Left><Left>'
      \ : ':<C-u>Cfind . -type d -name "**"<Left><Left>'
noremap <expr> <Space>/D g:qfloc ?
      \ ':<C-u>Lfind! . -type d -name "**"<Left><Left>'
      \ : ':<C-u>Cfind! . -type d -name "**"<Left><Left>'

noremap <expr> <Space>/l g:qfloc ?
      \ ':<C-u>Lfind . -xtype f -name "**"<Left><Left>'
      \ : ':<C-u>Cfind . -xtype f -name "**"<Left><Left>'
noremap <expr> <Space>/L g:qfloc ?
      \ ':<C-u>Lfind! . -xtype f -name "**"<Left><Left>'
      \ : ':<C-u>Cfind! . -xtype f -name "**"<Left><Left>'

noremap <expr> <Space>/a g:qfloc ?
      \ ':<C-u>Lfind . -xtype d -name "**"<Left><Left>'
      \ : ':<C-u>Cfind . -xtype d -name "**"<Left><Left>'
noremap <expr> <Space>/A g:qfloc ?
      \ ':<C-u>Lfind! . -xtype d -name "**"<Left><Left>'
      \ : ':<C-u>Cfind! . -xtype d -name "**"<Left><Left>'

noremap <expr> <Space>?f g:qfloc ?
      \ ':<C-u>Lfind . -type f -name ""<Left>'
      \ : ':<C-u>Cfind . -type f -name ""<Left>'
noremap <expr> <Space>?F g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name ""<Left>'
      \ : ':<C-u>Cfind! . -type f -name ""<Left>'

noremap <expr> <Space>?d g:qfloc ?
      \ ':<C-u>Lfind . -type d -name ""<Left>'
      \ : ':<C-u>Cfind . -type d -name ""<Left>'
noremap <expr> <Space>?D g:qfloc ?
      \ ':<C-u>Lfind! . -type d -name ""<Left>'
      \ : ':<C-u>Cfind! . -type d -name ""<Left>'

noremap <expr> <Space>?l g:qfloc ?
      \ ':<C-u>Lfind . -xtype f -name ""<Left>'
      \ : ':<C-u>Cfind . -xtype f -name ""<Left>'
noremap <expr> <Space>?L g:qfloc ?
      \ ':<C-u>Lfind! . -xtype f -name ""<Left>'
      \ : ':<C-u>Cfind! . -xtype f -name ""<Left>'

noremap <expr> <Space>?a g:qfloc ?
      \ ':<C-u>Lfind . -xtype d -name ""<Left>'
      \ : ':<C-u>Cfind . -xtype d -name ""<Left>'
noremap <expr> <Space>?A g:qfloc ?
      \ ':<C-u>Lfind! . -xtype d -name ""<Left>'
      \ : ':<C-u>Cfind! . -xtype d -name ""<Left>'

" }}}

" {{{ find with cursor

noremap <expr> <Space>/s g:qfloc ?
      \ ":<C-u>exe 'Lfind . -type f -name ".'"*'.
      \ "'.GetVisualEsc().'".'*"<CR>'
      \ : ":<C-u>exe 'Cfind . -type f -name ".'"*'.
      \ "'.GetVisualEsc().'".'*"<CR>'
noremap <expr> <Space>/S g:qfloc ?
      \ ":<C-u>exe 'Lfind! . -type f -name ".'"*'.
      \ "'.GetVisualEsc().'".'*"<CR>'
      \ : ":<C-u>exe 'Cfind! . -type f -name ".'"*'.
      \ "'.GetVisualEsc().'".'*"<CR>'

noremap <expr> <Space>/u g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "*<cfile>*"<CR>'
      \ : ':<C-u>Cfind . -type f -name "*<cfile>*"<CR>'
noremap <expr> <Space>/U g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "*<cfile>*"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "*<cfile>*"<CR>'

noremap <expr> <Space>/w g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "*<cword>*"<CR>'
      \ : ':<C-u>Cfind . -type f -name "*<cword>*"<CR>'
noremap <expr> <Space>/W g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "*<cword>*"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "*<cword>*"<CR>'

noremap <expr> <Space>/m g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "*<cWORD>*"<CR>'
      \ : ':<C-u>Cfind . -type f -name "*<cWORD>*"<CR>'
noremap <expr> <Space>/M g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "*<cWORD>*"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "*<cWORD>*"<CR>'

noremap <expr> <Space>/e g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "*<cexpr>*"<CR>'
      \ : ':<C-u>Cfind . -type f -name "*<cexpr>*"<CR>'
noremap <expr> <Space>/E g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "*<cexpr>*"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "*<cexpr>*"<CR>'

noremap <expr> <Space>/y g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "*'.getreg('"').'*"<CR>'
      \ : ':<C-u>Cfind . -type f -name "*'.getreg('"').'*"<CR>'
noremap <expr> <Space>/Y g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "*'.getreg('"').'*"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "*'.getreg('"').'*"<CR>'

noremap <expr> <Space>/g g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "*'.getreg('*').'*"<CR>'
      \ : ':<C-u>Cfind . -type f -name "*'.getreg('*').'*"<CR>'
noremap <expr> <Space>/G g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "*'.getreg('*').'*"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "*'.getreg('*').'*"<CR>'

noremap <expr> <Space>/p g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "*'.getreg('+').'*"<CR>'
      \ : ':<C-u>Cfind . -type f -name "*'.getreg('+').'*"<CR>'
noremap <expr> <Space>/P g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "*'.getreg('+').'*"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "*'.getreg('+').'*"<CR>'

" }}}

" {{{ find with cursor (no stars)

noremap <expr> <Space>?s g:qfloc ?
      \ ":<C-u>exe 'Lfind . -type f -name ".
      \ "\"'.GetVisualEsc().'\"'<CR>"
      \ : ":<C-u>exe 'Cfind . -type f -name ".
      \ "\"'.GetVisualEsc().'\"'<CR>"
noremap <expr> <Space>?S g:qfloc ?
      \ ":<C-u>exe 'Lfind! . -type f -name ".
      \ "\"'.GetVisualEsc().'\"'<CR>"
      \ : ":<C-u>exe 'Cfind! . -type f -name ".
      \ "\"'.GetVisualEsc().'\"'<CR>"

noremap <expr> <Space>?u g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "<cfile>"<CR>'
      \ : ':<C-u>Cfind . -type f -name "<cfile>"<CR>'
noremap <expr> <Space>?U g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "<cfile>"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "<cfile>"<CR>'

noremap <expr> <Space>?w g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "<cword>"<CR>'
      \ : ':<C-u>Cfind . -type f -name "<cword>"<CR>'
noremap <expr> <Space>?W g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "<cword>"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "<cword>"<CR>'

noremap <expr> <Space>?m g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "<cWORD>"<CR>'
      \ : ':<C-u>Cfind . -type f -name "<cWORD>"<CR>'
noremap <expr> <Space>?M g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "<cWORD>"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "<cWORD>"<CR>'

noremap <expr> <Space>?e g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "<cexpr>"<CR>'
      \ : ':<C-u>Cfind . -type f -name "<cexpr>"<CR>'
noremap <expr> <Space>?E g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "<cexpr>"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "<cexpr>"<CR>'

noremap <expr> <Space>?y g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "'.getreg('"').'"<CR>'
      \ : ':<C-u>Cfind . -type f -name "'.getreg('"').'"<CR>'
noremap <expr> <Space>?Y g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "'.getreg('"').'"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "'.getreg('"').'"<CR>'

noremap <expr> <Space>?g g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "'.getreg('*').'"<CR>'
      \ : ':<C-u>Cfind . -type f -name "'.getreg('*').'"<CR>'
noremap <expr> <Space>?G g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "'.getreg('*').'"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "'.getreg('*').'"<CR>'

noremap <expr> <Space>?p g:qfloc ?
      \ ':<C-u>Lfind . -type f -name "'.getreg('+').'"<CR>'
      \ : ':<C-u>Cfind . -type f -name "'.getreg('+').'"<CR>'
noremap <expr> <Space>?P g:qfloc ?
      \ ':<C-u>Lfind! . -type f -name "'.getreg('+').'"<CR>'
      \ : ':<C-u>Cfind! . -type f -name "'.getreg('+').'"<CR>'

" }}}

" {{{ locate

noremap <Space>bc g:qfloc ?
      \ ':<C-u>Llocate<Space>'
      \ : ':<C-u>Clocate<Space>'
noremap <Space>bC g:qfloc ?
      \ ':<C-u>Llocate!<Space>'
      \ : ':<C-u>Clocate!<Space>'

" }}}

" {{{ locate with cursor

noremap <expr> <Space>bs g:qfloc ?
      \ ":<C-u>exe 'Llocate \"'.GetVisualEsc().'\"'<CR>"
      \ : ":<C-u>exe 'Clocate \"'.GetVisualEsc().'\"'<CR>"
noremap <expr> <Space>bS g:qfloc ?
      \ ":<C-u>exe 'Llocate! \"'.GetVisualEsc().'\"'<CR>"
      \ : ":<C-u>exe 'Clocate! \"'.GetVisualEsc().'\"'<CR>"

noremap <expr> <Space>bu g:qfloc ?
      \ ':<C-u>Llocate <cfile><CR>'
      \ : ':<C-u>Cllocate <cfile><CR>'
noremap <expr> <Space>bU g:qfloc ?
      \ ':<C-u>Llocate! <cfile><CR>'
      \ : ':<C-u>Cllocate! <cfile><CR>'

noremap <expr> <Space>bw g:qfloc ?
      \ ':<C-u>Llocate <cword><CR>'
      \ : ':<C-u>Cllocate <cword><CR>'
noremap <expr> <Space>bW g:qfloc ?
      \ ':<C-u>Llocate! <cword><CR>'
      \ : ':<C-u>Cllocate! <cword><CR>'

noremap <expr> <Space>bm g:qfloc ?
      \ ':<C-u>Llocate <cWORD><CR>'
      \ : ':<C-u>Cllocate <cWORD><CR>'
noremap <expr> <Space>bM g:qfloc ?
      \ ':<C-u>Llocate! <cWORD><CR>'
      \ : ':<C-u>Cllocate! <cWORD><CR>'

noremap <expr> <Space>be g:qfloc ?
      \ ':<C-u>Llocate <cexpr><CR>'
      \ : ':<C-u>Cllocate <cexpr><CR>'
noremap <expr> <Space>bE g:qfloc ?
      \ ':<C-u>Llocate! <cexpr><CR>'
      \ : ':<C-u>Cllocate! <cexpr><CR>'

noremap <expr> <Space>by g:qfloc ?
      \ ':<C-u>Llocate '.getreg('"').'<CR>'
      \ : ':<C-u>Cllocate '.getreg('"').'<CR>'
noremap <expr> <Space>bY g:qfloc ?
      \ ':<C-u>Llocate! '.getreg('"').'<CR>'
      \ : ':<C-u>Cllocate! '.getreg('"').'<CR>'

noremap <expr> <Space>bg g:qfloc ?
      \ ':<C-u>Llocate '.getreg('*').'<CR>'
      \ : ':<C-u>Cllocate '.getreg('*').'<CR>'
noremap <expr> <Space>bG g:qfloc ?
      \ ':<C-u>Llocate! '.getreg('*').'<CR>'
      \ : ':<C-u>Cllocate! '.getreg('*').'<CR>'

noremap <expr> <Space>bp g:qfloc ?
      \ ':<C-u>Llocate '.getreg('+').'<CR>'
      \ : ':<C-u>Cllocate '.getreg('+').'<CR>'
noremap <expr> <Space>bP g:qfloc ?
      \ ':<C-u>Llocate! '.getreg('+').'<CR>'
      \ : ':<C-u>Cllocate! '.getreg('+').'<CR>'

" }}}

" }}}

" {{{ vifm

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

" }}}

" {{{ others

" if nerdtree happens it will land here
" or nnn

" }}}
