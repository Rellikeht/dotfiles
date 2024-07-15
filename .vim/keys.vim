"{{{ help

" copy simple mappings from normal to visual
" 0yyprv$F<i\|norm gv

"}}}

"{{{ remaps

noremap .. .
noremap <C-h> <C-]>

"}}}

"{{{ TODO Tags
" TODO What the fuck is happening here

noremap <silent> <Space>jj :<C-u>tjump<CR>
noremap <silent> <Space>js :<C-u>stjump<CR>
noremap <silent> <Space>jv :<C-u>vert stjump<CR>

noremap <silent> <Space><Space>jj :<C-u>tjump<Space>
noremap <silent> <Space><Space>js :<C-u>stjump<Space>
noremap <silent> <Space><Space>jv :<C-u>vert stjump<Space>

" }}}

"{{{ Better tab

noremap <silent> <Tab>k K<C-w>T

noremap <silent> <Tab>n 
            \ :<C-u>call SwitchTab(v:count1)<CR>
nnoremap <silent> <Tab>N 
            \ :<C-u>execute 'tabm +'.v:count1<CR>
vnoremap <silent> <Tab>N 
            \ :<C-u>execute 'tabm +'.v:count1\|norm gv<CR>
nnoremap <silent> <Tab>P 
            \ :<C-u>execute 'tabm -'.v:count1<CR>
vnoremap <silent> <Tab>P 
            \ :<C-u>execute 'tabm -'.v:count1\|norm gv<CR>

nnoremap <silent> <Tab>w :<C-u>We<CR>
vnoremap <silent> <Tab>w :<C-u>We\|norm gv<CR>

"}}}

" {{{ TODO resizing with <Tab>

" }}}

" {{{ buffers with <Space><Space>

noremap <silent> <Space><Space>d <Plug>Kwbd

vnoremap <Space><Space>;l 
            \ :<C-u>exe 'filter '.
            \ GetVisualSelection().' buffers'<CR>
vnoremap <Space><Space>;L 
            \ :<C-u>exe 'filter '.
            \ GetVisualSelection().' buffers!'<CR>

noremap <silent> <Space><Space>n 
            \ :<C-u>exe v:count1.'bnext'<CR>
noremap <silent> <Space><Space>p 
            \ :<C-u>exe v:count1.'bprevious'<CR>
noremap <silent> <Space><Space>N 
            \ :<C-u>exe v:count1.'bnext!'<CR>
noremap <silent> <Space><Space>P 
            \ :<C-u>exe v:count1.'bprevious!'<CR>
noremap <silent> <Space><Space>m 
            \ :<C-u>exe v:count1.'bmodified'<CR>
noremap <silent> <Space><Space>M 
            \ :<C-u>exe v:count1.'bmodified!'<CR>

" }}}

"{{{ args with <Space>

vnoremap <Space>;l 
            \ :<C-u>exe 'filter '.
            \ GetVisualSelection().' args'<CR>

noremap <silent> <Space>n :<C-u>call NextArg(1, 'argument')<CR>
noremap <silent> <Space>N :<C-u>call NextArg(1, 'argument!')<CR>
noremap <silent> <Space>p :<C-u>call NextArg(0, 'argument')<CR>
noremap <silent> <Space>P :<C-u>call NextArg(0, 'argument!')<CR>

noremap <silent> <Space>. 
            \ :<C-u>call NextArg(1, 'argument', 'w')<CR>
noremap <silent> <Space>> 
            \ :<C-u>call NextArg(1, 'argument!', 'w')<CR>
noremap <silent> <Space>, 
            \ :<C-u>call NextArg(0, 'argument', 'w')<CR>
noremap <silent> <Space>< 
            \ :<C-u>call NextArg(0, 'argument!', 'w')<CR>

"}}}

" {{{ <Space> list and help

vnoremap <Space>i<Space>r 
            \ :<C-u>exe 'filter '.
            \ GetVisualSelection().' registers'<C-Left><C-b>
vnoremap <Space>i<Space>p 
            \ :<C-u>exe 'filter '.
            \ GetVisualSelection().' history'<C-Left><C-b>
vnoremap <Space>i<Space>c 
            \ :<C-u>exe 'filter '.
            \ GetVisualSelection().' changes'<C-Left><C-b>
vnoremap <Space>i<Space>j 
            \ :<C-u>exe 'filter '.
            \ GetVisualSelection().' jumps'<C-Left><C-b>
vnoremap <Space>i<Space>o 
            \ :<C-u>exe 'filter '.
            \ GetVisualSelection().' files'<C-Left><C-b>
vnoremap <Space>i<Space>m 
            \ :<C-u>exe 'filter '.
            \ GetVisualSelection().' marks'<C-Left><C-b>

"}}}

"{{{ leader stuff

" TODO add more commands

" General purpose leader mappings
noremap <Leader>;l :<C-u>!ls<CR>

" pwd
nnoremap <Leader>;c :<C-u>silent! lcd %:p:h<CR>
vnoremap <Leader>;c :<C-u>silent! lcd %:p:h\|norm gv<CR>
nnoremap <Leader>;p :<C-u>silent! cd %:p:h<CR>
vnoremap <Leader>;p :<C-u>silent! cd %:p:h\|norm gv<CR>
nnoremap <Leader>;C :<C-u>lcd<Space>
vnoremap <Leader>;C :<C-u>lcd \|norm gv
            \ <C-Left><C-Left><Left>
nnoremap <Leader>;P :<C-u>cd<Space>
vnoremap <Leader>;P :<C-u>cd \|norm gv
            \ <C-Left><C-Left><Left>

" Not the best, but should work
noremap <silent> <Leader>;wc gg0vG$:<C-u>w !wc<CR>

nnoremap <Leader>;d :<C-u>pwd<CR>
vnoremap <Leader>;d :<C-u>pwd\|norm gv<CR>

" ???
" map <Leader>;r :!%<CR>

"}}}

"{{{ quickfix and loclist

"{{{ settings

let g:qfloc = 0

" TODO better messages
nnoremap .t :<C-u>let g:qfloc = !g:qfloc
            \ \| echo 'Quickfix is now ' . 
            \ (g:qfloc ? 'local' : 'global')<CR>
nnoremap .q :<C-u> echo 'Quickfix is now ' . 
            \ (g:qfloc ? 'local' : 'global')<CR>

vnoremap .t :<C-u>let g:qfloc = !g:qfloc
            \ \| echo 'Quickfix is now ' . 
            \ (g:qfloc ? 'local' : 'global')
            \ \| normal gv<CR>
vnoremap .q :<C-u> echo 'Quickfix is now ' . 
            \ (g:qfloc ? 'local' : 'global')
            \ \| normal gv<CR>

"}}}

"{{{ movement

noremap <silent> .j
            \ :<C-u>call QFcmd('n', v:count1)<CR>
noremap <silent> .k
            \ :<C-u>call QFcmd('p', v:count1)<CR>
nnoremap <silent> .n
            \ :<C-u>call QFcmd('nf', v:count1)<CR>
nnoremap <silent> .p
            \ :<C-u>call QFcmd('pf', v:count1)<CR>
nnoremap <silent> .c
            \ :<C-u>call QFsel('cc', 'll', v:count1)<CR>

nnoremap <silent> .0 :<C-u>call QFcmd('first')<CR>
nnoremap <silent> .$ :<C-u>call QFcmd('last')<CR>

nnoremap <silent> .<
            \ :<C-u>call QFcmd('older '.v:count1)<CR>
nnoremap <silent> .>
            \ :<C-u>call QFcmd('newer '.v:count1)<CR>
nnoremap <silent> .b :<C-u>call QFcmd('bottom')<CR>
nnoremap <silent> .r :<C-u>call QFcmd('rewind '.v:count1)<CR>

vnoremap <silent> .<
            \ :<C-u>call QFcmd('older '.v:count1)
            \ \| normal gv<CR>
vnoremap <silent> .>
            \ :<C-u>call QFcmd('newer '.v:count1)
            \ \| normal gv<CR>
vnoremap <silent> .b :<C-u>call QFcmd('bottom')
            \ \| normal gv<CR>
vnoremap <silent> .r :<C-u>call QFcmd('rewind '.v:count1)
            \ \| normal gv<CR>

"}}}

"{{{  actions

nnoremap <silent> .<Space> :<C-u>call NToggleQuickFix()<CR>
vnoremap <silent> .<Space> :<C-u>call VToggleQuickFix()<CR>
noremap <silent> .w :<C-u>call QFcmd('window')<CR>
noremap <silent> .o :<C-u>call QFcmd('do')<CR>
noremap <silent> .f :<C-u>call QFcmd('do')<CR>

"}}}

augroup Quickfix "{{{

    " TODO C use something more friendly than <cr> and <c-h>
    " this is hard, it probably needs unmapping bunch of things
    autocmd FileType qf 
                \ noremap <buffer> <silent> q :q<CR>
                \ | noremap <buffer> < :<C-u>call QFcmd('older')<CR>
                \ | nnoremap <buffer> > :<C-u>call QFcmd('newer')<CR>
                \ | nnoremap <buffer> J :<C-u>call 
                \ QFcmd('n', '+'.v:count1.' \| '.v:count1)
                \ \| wincmd p<CR>
                \ | noremap <buffer> K :<C-u>call
                \ QFcmd('p', '-'.v:count1.' \| '.v:count1)
                \ \| wincmd p<CR>
                \ | nnoremap <buffer> <silent> <CR> <CR>:wincmd p<CR>
                \ | nnoremap <buffer> <silent> <C-h> <CR>:call QFcmd('close')<CR>

augroup END "}}}

"}}}

"{{{ Matchit

noremap <Leader>{ [%
noremap <Leader>} ]%

"}}}

"{{{ completion

" Yeah, copying from wiki works
inoremap <expr> <Cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <Tab> pumvisible() ? "<C-y>" : "<TAB>"

"}}}

"{{{ TODO

" TODO B running command under cursor
" TODO C running command in given register (???)
" TODO C https://youtu.be/w7i4amO_zaE?t=1464

" Run command in register c
" map <silent> <Leader>;E 'cyy:execute '!' . getreg('c')<CR>
" map <silent> <Leader>;D 'cyydd:execute '!' . getreg('c')<CR>
"nmap <silent> <Leader>W bvw"cy:execute "!" . getreg('c')<CR>

"}}}
