"{{{ helpers

" copy simple mappings from normal to visual
" 0yyprv$F<i\|norm gv

"}}}

"{{{ remaps

noremap .. .
noremap <C-h> <C-]>

"}}}

"{{{ tags
" TODO C polish that

nnoremap <Space>tl :<C-u>tags<CR>
vnoremap <Space>tl :<C-u>tags\|norm gv<CR>

noremap <silent> <Space>tj :<C-u>tjump<CR>
noremap <silent> <Space>ts :<C-u>stjump<CR>
noremap <silent> <Space>tv :<C-u>vert stjump<CR>

noremap <silent> <Space><Space>tj :<C-u>tjump<Space>
noremap <silent> <Space><Space>ts :<C-u>stjump<Space>
noremap <silent> <Space><Space>tv :<C-u>vert stjump<Space>

noremap <silent> <Space>t<Space>t :<C-u>tag<Space>
noremap <silent> <Space>t<Space>T :<C-u>tag!<Space>
noremap <silent> <Space>t<Space>g :<C-u>tselect<Space>
noremap <silent> <Space>t<Space>G :<C-u>tselect!<Space>

noremap <silent> <Space>tt :<C-u>exe v:count1.'tag'<CR>
noremap <silent> <Space>tT :<C-u>exe v:count1.'tag!'<CR>
noremap <silent> <Space>tp :<C-u>exe v:count1.'pop'<CR>
noremap <silent> <Space>t;p :<C-u>exe v:count1.'pop!'<CR>
noremap <silent> <Space>tg :<C-u>exe v:count1.'tselect'<CR>
noremap <silent> <Space>tG :<C-u>exe v:count1.'tselect!'<CR>

noremap <silent> <Space>tn :<C-u>exe v:count1.'tnext'<CR>
noremap <silent> <Space>t;n :<C-u>exe v:count1.'tnext!'<CR>
noremap <silent> <Space>tp :<C-u>exe v:count1.'tprevious'<CR>
noremap <silent> <Space>t;p :<C-u>exe v:count1.'tprevious!'<CR>

noremap <silent> <Space>t0 :<C-u>tfirst<CR>
noremap <silent> <Space>t;0 :<C-u>tfirst!<CR>
noremap <silent> <Space>t$ :<C-u>tlast<CR>
noremap <silent> <Space>t;$ :<C-u>tlast!<CR>

noremap <silent> <Space>ta :<C-u>ltag<CR>
noremap <silent> <Space>t<Space>a :<C-u>ltag<Space>
noremap <silent> <Space>tA :<C-u>ltag!<Space>
noremap <silent> <Space>t<Space>A :<C-u>ltag!<Space>

" }}}

"{{{ TODO C preview window

"}}}

"{{{ better tab

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
nnoremap <Leader>;cl :<C-u>silent! lcd %:p:h<CR>
vnoremap <Leader>;cl :<C-u>silent! lcd %:p:h\|norm gv<CR>
nnoremap <Leader>;cc :<C-u>silent! cd %:p:h<CR>
vnoremap <Leader>;cc :<C-u>silent! cd %:p:h\|norm gv<CR>
nnoremap <Leader>;c<Space>l :<C-u>lcd<Space>
vnoremap <Leader>;c<Space>l :<C-u>lcd \|norm gv
            \ <C-Left><C-Left><Left>
nnoremap <Leader>;c<Space>c :<C-u>lcd<Space>
vnoremap <Leader>;c<Space>c :<C-u>lcd \|norm gv
            \ <C-Left><C-Left><Left>

" Not the best, but should work
noremap <silent> <Leader>;wc gg0vG$:<C-u>w !wc<CR>

nnoremap <Leader>;cp :<C-u>pwd<CR>
vnoremap <Leader>;cp :<C-u>pwd\|norm gv<CR>

" ???
" map <Leader>;r :!%<CR>

"}}}

"{{{ quickfix and loclist

"{{{ settings

let g:qfloc = 0

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

"{{{ helpers

function QuickFixToggle()
    let g:qfloc = !g:qfloc
    echo 'Quickfix is now ' . (g:qfloc ? 'local' : 'global')
    if q:qfloc
        nnoremap <silent> .d :<C-u>ldo<Space>
        vnoremap <silent> .d :<C-u>ldo  \|norm gv
                    \ <C-Left><C-Left><Left>
        nnoremap <silent> .a :<C-u>lfdo<Space>
        vnoremap <silent> .a :<C-u>lfdo  \|norm gv
                    \ <C-Left><C-Left><Left>
        nnoremap <silent> .D :<C-u>ldo!<Space>
        vnoremap <silent> .D :<C-u>ldo!  \|norm gv
                    \ <C-Left><C-Left><Left>
        nnoremap <silent> .A :<C-u>lfdo!<Space>
        vnoremap <silent> .A :<C-u>lfdo!  \|norm gv
                    \ <C-Left><C-Left><Left>

        noremap .f :<C-u>Lfilter //<Left>
        noremap .F :<C-u>Lfilter! //<Left>
    else

        nnoremap <silent> .d :<C-u>cdo<Space>
        vnoremap <silent> .d :<C-u>cdo  \|norm gv
                    \ <C-Left><C-Left><Left>
        nnoremap <silent> .a :<C-u>cfdo<Space>
        vnoremap <silent> .a :<C-u>cfdo  \|norm gv
                    \ <C-Left><C-Left><Left>
        nnoremap <silent> .D :<C-u>cdo!<Space>
        vnoremap <silent> .D :<C-u>cdo!  \|norm gv
                    \ <C-Left><C-Left><Left>
        nnoremap <silent> .A :<C-u>cfdo!<Space>
        vnoremap <silent> .A :<C-u>cfdo!  \|norm gv
                    \ <C-Left><C-Left><Left>

        noremap .f :<C-u>Cfilter //<Left>
        noremap .F :<C-u>Cfilter! //<Left>
    endif
endfunction

"}}}

"{{{ movement

noremap <silent> .j
            \ :<C-u>call QFcmd('n', v:count1)<CR>
noremap <silent> .k
            \ :<C-u>call QFcmd('p', v:count1)<CR>
noremap <silent> .n
            \ :<C-u>call QFcmd('nf', v:count1)<CR>
noremap <silent> .p
            \ :<C-u>call QFcmd('pf', v:count1)<CR>
noremap <silent> .g
            \ :<C-u>call QFsel('cc', 'll', v:count1)<CR>

noremap <silent> .0 :<C-u>call QFcmd('first')<CR>
noremap <silent> .$ :<C-u>call QFcmd('last')<CR>
noremap <silent> .G :<C-u>call QFcmd('bottom')<CR>

nnoremap <silent> .<
            \ :<C-u>call QFcmd('older '.v:count1)<CR>
nnoremap <silent> .>
            \ :<C-u>call QFcmd('newer '.v:count1)<CR>
vnoremap <silent> .<
            \ :<C-u>call QFcmd('older '.v:count1)
            \ \| normal gv<CR>
vnoremap <silent> .>
            \ :<C-u>call QFcmd('newer '.v:count1)
            \ \| normal gv<CR>

"}}}

"{{{  actions

" noremap <silent> .w :<C-u>call QFcmd('window')<CR>
noremap <silent> .e :<C-u>call QFcmd('window')<CR>
noremap <silent> <C-w>.<Space>
            \ :<C-u>call QFcmd('open')<CR><C-w>T

noremap .l :<C-u>call QFcmd('history')<CR>

nnoremap <silent> .<Space> :<C-u>call NToggleQuickFix()<CR>
vnoremap <silent> .<Space> :<C-u>call VToggleQuickFix()<CR>

"}}}

augroup Quickfix "{{{

    " TODO C use something more friendly than <cr> and <c-h>
    " this is hard, it probably needs unmapping bunch of things
    autocmd FileType qf 
                \ noremap <buffer> <silent> q :q<CR>
                \ | noremap <buffer> < :<C-u>call WQFcmd('older')<CR>
                \ | nnoremap <buffer> > :<C-u>call WQFcmd('newer')<CR>
                \ | nnoremap <buffer> J :<C-u>call 
                \ WQFcmd('n', '+'.v:count1.' \| '.v:count1)
                \ \| wincmd p<CR>
                \ | noremap <buffer> K :<C-u>call
                \ WQFcmd('p', '-'.v:count1.' \| '.v:count1)
                \ \| wincmd p<CR>
                \ | nnoremap <buffer> <silent> <CR> <CR>:wincmd p<CR>
                \ | nnoremap <buffer> <silent> <BS> <CR>
                \ | nnoremap <buffer> <silent> <C-h> 
                \ <CR>:call WQFcmd('close')<CR>

augroup END "}}}

"}}}

"{{{ other <Space>

nnoremap <Space><Space>f<Space> :find<Space>
nnoremap <Space><Space>fa :find *
nnoremap <Space><Space>fr :find **
nnoremap <Space><Space>f;a :find *<Tab>
nnoremap <Space><Space>f;r :find **<Tab>

nnoremap <Space><Space>f;<Space> :find!<Space>
nnoremap <Space><Space>fA :find! *
nnoremap <Space><Space>fR :find! **
nnoremap <Space><Space>f;A :find! *<Tab>
nnoremap <Space><Space>f;R :find! **<Tab>

nnoremap <C-w><Space><Space>f<Space> :tabfind<Space>
nnoremap <C-w><Space><Space>fa :tabfind *
nnoremap <C-w><Space><Space>fr :tabfind **
nnoremap <C-w><Space><Space>f;a :tabfind *<Tab>
nnoremap <C-w><Space><Space>f;r :tabfind **<Tab>

nnoremap <C-w><Space><Space>f;<Space> :tabfind!<Space>
nnoremap <C-w><Space><Space>fA :tabfind! *
nnoremap <C-w><Space><Space>fR :tabfind! **
nnoremap <C-w><Space><Space>f;A :tabfind! *<Tab>
nnoremap <C-w><Space><Space>f;R :tabfind! **<Tab>

"}}}

"{{{ matchit

noremap <Space>{ [%
noremap <Space>} ]%

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

