"{{{ helpers

" copy simple mappings from normal to visual
" 0yyprv$F<i\|norm gv

"}}}

"{{{ repams

noremap .. .
noremap <C-h> <C-]>
noremap <C-w><C-h> 
      \ :<C-u>exe 'tab tag '.expand('<cword>')<CR>

" Command line window
autocmd FileType vim
      \ if &buftype == "nofile" && bufname() == ""
      \ | noremap <buffer> <C-m> <CR>
      \ | endif

"}}}

"{{{ tags
" TODO C polish that

nnoremap <Space>tl :<C-u>tags<CR>
vnoremap <Space>tl :<C-u>tags\|norm gv<CR>

noremap <silent> <Space>tj :<C-u>tjump<CR>
noremap <silent> <Space>ts :<C-u>stjump<CR>
noremap <silent> <Space>tv :<C-u>vert stjump<CR>

noremap <Space><Space>tj :<C-u>tjump<Space>
noremap <Space><Space>ts :<C-u>stjump<Space>
noremap <Space><Space>tv :<C-u>vert stjump<Space>

noremap <Space>t<Space>t :<C-u>tag<Space>
noremap <Space>t<Space>T :<C-u>tag!<Space>
noremap <Space>t<Space>g :<C-u>tselect<Space>
noremap <Space>t<Space>G :<C-u>tselect!<Space>

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
noremap <Space>t<Space>a :<C-u>ltag<Space>
noremap <silent> <Space>tA :<C-u>ltag!<Space>
noremap <Space>t<Space>A :<C-u>ltag!<Space>

" }}}

"{{{ TODO C preview window

"}}}

"{{{ better tab

noremap <silent> <Tab>k K<C-w>T

noremap <silent> <Tab>n 
      \ :<C-u>call SwitchTab(v:count1)<CR>
nnoremap <silent> <Tab>N 
      \ :<C-u>execute 'tabmove +'.v:count1<CR>
vnoremap <silent> <Tab>N 
      \ :<C-u>execute 'tabmove +'.v:count1\|norm gv<CR>
nnoremap <silent> <Tab>P 
      \ :<C-u>execute 'tabmove -'.v:count1<CR>
vnoremap <silent> <Tab>P 
      \ :<C-u>execute 'tabmove -'.v:count1\|norm gv<CR>

nnoremap <expr> <Tab>f ':<C-u>'.v:count1.'tabfind '
nnoremap <expr> <Tab>F ':<C-u>-'.v:count1.'tabfind '

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

noremap <Leader>;m :<C-u>messages<CR>

" ???
" map <Leader>;r :!%<CR>

"}}}

"{{{ quickfix and loclist

"{{{ helpers

function QuickFixToggle()
  let g:qfloc = !g:qfloc
  echo 'Quickfix is now ' . (g:qfloc ? 'local' : 'global')
endfunction

"}}}

"{{{ settings

let g:qfheight = 15
let g:qfloc = 1

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

"{{{ basic

nnoremap <expr> .d
      \ g:qfloc ? ':<C-u>ldo<Space>'
      \ : ':<C-u>cdo<Space>'
vnoremap <expr> .d
      \ g:qfloc ? 
      \ ':<C-u>ldo  \|norm gv<C-Left><C-Left><Left>'
      \ : ':<C-u>cdo  \|norm gv<C-Left><C-Left><Left>'
nnoremap <expr> .a
      \ g:qfloc ? ':<C-u>lfdo<Space>'
      \ : ':<C-u>cfdo<Space>'
vnoremap <expr> .a
      \ g:qfloc ? 
      \ ':<C-u>lfdo  \|norm gv<C-Left><C-Left><Left>'
      \ : ':<C-u>cfdo  \|norm gv<C-Left><C-Left><Left>'
nnoremap <expr> .D
      \ g:qfloc ? ':<C-u>ldo!<Space>'
      \ : ':<C-u>cdo!<Space>'
vnoremap <expr> .D
      \ g:qfloc ? 
      \ ':<C-u>ldo!  \|norm gv<C-Left><C-Left><Left>'
      \ : ':<C-u>cdo!  \|norm gv<C-Left><C-Left><Left>'
nnoremap <expr> .A
      \ g:qfloc ? ':<C-u>lfdo!<Space>'
      \ : ':<C-u>cfdo!<Space>'
vnoremap <expr> .A
      \ g:qfloc ? 
      \ ':<C-u>lfdo!  \|norm gv<C-Left><C-Left><Left>'
      \ : ':<C-u>cfdo!  \|norm gv<C-Left><C-Left><Left>'

noremap <expr> .f g:qfloc ? :<C-u>Lfilter //<Left>
noremap <expr> .F g:qfloc ? :<C-u>Lfilter! //<Left>

nnoremap <silent> .b :<C-u>call QFcmd('getbuffer')<CR>
vnoremap <silent> .b :<C-u>call QFcmd('getbuffer')\|norm gv<CR>
nnoremap <silent> .B 
      \ :<C-u>call QFcmd("getbuffer '.v:count1", "exe '")<CR>
vnoremap <silent> .B 
      \ :<C-u>call QFcmd("getbuffer '.v:count1", "exe '")\|norm gv<CR>
nnoremap <expr> .<Space>b g:qfloc ? 
      \ ':<C-u>lgetbuffer <Space>'
      \ : ':<C-u>cgetbuffer <Space>'
vnoremap <expr> .<Space>b g:qfloc ? 
      \ ':<C-u>lgetbuffer  \|norm gv<C-Left><C-Left><Left>'
      \ : ':<C-u>cgetbuffer  \|norm gv<C-Left><C-Left><Left>'

nnoremap <silent> .<Tab> :<C-u>call QFcmd('getfile')<CR>
vnoremap <silent> .<Tab> :<C-u>call QFcmd('getfile')\|norm gv<CR>
nnoremap <expr> .<Space><Tab> g:qfloc ? 
      \ ':<C-u>lgetfile <Space>'
      \ : ':<C-u>cgetfile <Space>'
vnoremap <expr> .<Space><Tab> g:qfloc ? 
      \ ':<C-u>lgetfile  \|norm gv<C-Left><C-Left><Left>'
      \ : ':<C-u>cgetfile  \|norm gv<C-Left><C-Left><Left>'

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

noremap <silent> .w 
      \ :<C-u>call QFcmd("open '.g:qfheight", "exe '")<CR>
noremap <silent> .W
      \ :<C-u>call QFcmd("window '.g:qfheight", "exe '")<CR>
noremap <silent> <C-w>.w
      \ :<C-u>call QFcmd("open '.g:qfheight", "exe '")<CR><C-w>T
noremap <silent> <C-w>.W
      \ :<C-u>call QFcmd("window '.g:qfheight", "exe '")<CR><C-w>T

noremap .l :<C-u>call QFcmd('list')<CR>
noremap .L :<C-u>call QFcmd('history')<CR>

nnoremap <silent> .; :<C-u>call NToggleQuickFix()<CR>
vnoremap <silent> .; :<C-u>call VToggleQuickFix()<CR>

" clearing
nnoremap <silent> .c :<C-u>call QFcmd('expr []')<CR>
vnoremap <silent> .c :<C-u>call QFcmd('expr []')\|norm gv<CR>

nnoremap <expr> .e g:qfloc ?
      \ ':<C-u>lexpr<Space>'
      \ : ':<C-u>cexpr<Space>'
vnoremap <expr> .e g:qfloc ?
      \ ':<C-u>lexpr  \|norm gv<C-Left><C-Left><Left>'
      \ : ':<C-u>cexpr  \|norm gv<C-Left><C-Left><Left>'

" search into quickfix list
nnoremap <expr> ./ g:qfloc ? 
      \ ':<C-u>g//lexpr expand("%").":".line(".").":".getline(".")
      \ <Home><Right><Right>'
      \ : ':<C-u>g//cexpr expand("%").":".line(".").":".getline(".")
      \ <Home><Right><Right>'

" search into quickfix list
nnoremap <expr> .? g:qfloc ? 
      \ ':<C-u>g//laddexpr expand("%").":".line(".").":".getline(".")
      \ <Home><Right><Right>'
      \ : ':<C-u>g//caddexpr expand("%").":".line(".").":".getline(".")
      \ <Home><Right><Right>'

"}}}

augroup Quickfix "{{{

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
        \ | noremap <buffer> <expr> a g:qfloc ?
        \ ':<C-u>laddexpr<Space>'
        \ : ':<C-u>caddexpr<Space>'
        \ | noremap <buffer> <expr> i g:qfloc ?
        \ ':<C-u>laddfile<Space>'
        \ : ':<C-u>caddfile<Space>'
        \ | noremap <buffer> <expr> I g:qfloc ?
        \ ':<C-u>laddbuffer<Space>'
        \ : ':<C-u>caddbuffer<Space>'

  "TODO C modifications
  " some dd and undo

augroup END "}}}

"}}}

"{{{ matchit

noremap <Space>{ [%
noremap <Space>} ]%

"}}}

"{{{ completion

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <Esc> pumvisible() ? "<C-e>" : "<Esc>"
inoremap <expr> <Tab> pumvisible() ? "<C-y>" : "<Tab>"
" ??
inoremap <expr> <S-Tab> pumvisible() ? "<C-p><C-y>" : "<S-Tab>"

" <C-Space> in terminal
inoremap <C-Space> <C-@>
inoremap <expr> <C-@> pumvisible() ?
      \ '<C-n>' : (&omnifunc == '') ? '<C-n>' : '<C-x><C-o>'

" ?
" CTRL-X CTRL-E scroll up
" CTRL-X CTRL-Y scroll down

" CTRL-X CTRL-N next completion
" CTRL-X CTRL-P previous completion

" From viki, good stuff
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" inoremap <expr> <C-p> pumvisible() ? '<C-p>' :
"   \ '<C-p><C-r>=pumvisible() ? "\<lt>Up>" : ""<CR>'

" PageUp and PageDown don't work
" inoremap <expr> <C-d> pumvisible() ? '<PageDown><C-p><C-n>' : '<C-d>'
" inoremap <expr> <C-u> pumvisible() ? '<PageUp><C-p><C-n>' : '<C-u>'
inoremap <expr> <C-d> pumvisible() ? '<C-n><C-n><C-n><C-n><C-n>' : '<C-d>'
inoremap <expr> <C-u> pumvisible() ? '<C-p><C-p><C-p><C-p><C-p>' : '<C-u>'

" CTRL-X CTRL-Z stop completion, keeping the text as-is
inoremap <C-z> <C-x><C-z>

" CTRL-X CTRL-D complete defined identifiers
" CTRL-X CTRL-F complete file names
" CTRL-X CTRL-I complete identifiers
" CTRL-X CTRL-K complete identifiers from dictionary
" CTRL-X CTRL-L complete whole lines
" CTRL-X CTRL-O omni completion
" CTRL-X CTRL-T complete identifiers from thesaurus
" CTRL-X CTRL-U complete with 'completefunc'
" CTRL-X CTRL-V complete like in : command line
" CTRL-X CTRL-] complete tags
inoremap <C-x>d <C-x><C-d>
inoremap <C-x>f <C-x><C-f>
inoremap <C-x>i <C-x><C-i>
inoremap <C-x>k <C-x><C-k>
inoremap <C-x>l <C-x><C-l>
inoremap <C-x>o <C-x><C-o>
inoremap <C-x>t <C-x><C-t>
inoremap <C-x>u <C-x><C-u>
inoremap <C-x>v <C-x><C-v>
inoremap <C-x>c <C-x><C-]>

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
