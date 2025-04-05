" helpers {{{ 

" copy simple mappings from normal to visual
" 0yyprv$F<i\|norm gv

function s:Tabargc(cmd, count, args)
  if a:count < 0
    tabnew
  else
    -tabnew
  endif
  arglocal!
  if len(a:args) > 0
    exe a:cmd.' '.call('Exfiles', a:args)
  else
    for _ in range(argc())
      argdelete
    endfor
  endif
endfunction

" TODO D bang ?
command! -nargs=* -range -complete=file -bar Tabe
      \ call <SID>Tabargc('args!', <count>, [<f-args>])

command! -nargs=* -range -complete=arglist -bar TabA
      \ call <SID>Tabargc('args!', <count>, [<f-args>])

command! -nargs=* -range -complete=buffer -bar TabB
      \ call <SID>Tabargc('args!', <count>, [<f-args>])

command -nargs=* -bang -complete=buffer -bar ArgeditB
      \ argedit<bang> <args>

command -nargs=* -complete=buffer -bar ArgaddB
      \ argadd <args>


function s:MultifHelperf(args)
  for e in a:args[1:]
    exe a:args[0].' '.e
  endfor
endfunction

command -nargs=* MultifHelperc
      \ call <SID>MultifHelperf([<f-args>])

function Multif(cmd, args)
  for e in a:args
    exe 'MultifHelperc '.a:cmd.' '.Exfiles(e)
  endfor
endfunction

command -nargs=* -complete=file -bar -bang Edit
      \ call Multif('edit'.<q-bang>, [<f-args>])

command -nargs=* -complete=file -bar Badd
      \ call Multif('badd', [<f-args>])

" Breaks readonly at one file
command! -nargs=* -complete=file -bar -bang ArgView
      \ call Multif('argedit\ +silent!\\\ view'.<q-bang>, [<f-args>])

" This is (most probably useless) shit 
command! -nargs=* -complete=file -bar -bang ArgsView
      \ silent! call Multif('view'.<q-bang>, [<f-args>])
      " \| argedit +silent!\ view <args>

" Breaks readonly at one file
command! -nargs=* -range -complete=file -bar Tabv
      \ Tabe <args>
      \|silent! argdo set readonly
      " ^^ Breaks colors

      " Doesn't work on some paths
      " \| call <SID>Tabargc('ArgsView', <count>, [<f-args>])

      " Breaks readonly at some paths
      " \ let g:temp_pwd = expand('%:p:h')
      " \| call <SID>Tabargc('ArgsView', <count>, [<f-args>])
      " \| exe 'lcd '.g:temp_pwd
      " \| args! <args>
      " \| unlet g:temp_pwd

      " Breaks readonly at some paths
      " \ Tabe
      " \| let t:temp_pwd = expand('%:p:h')
      " \| args! <args>
      " \| exe 'lcd '.t:temp_pwd
      " \| silent! call Multif('view'.<q-bang>, [<f-args>])
      " \| unlet t:temp_pwd

command! -nargs=* -range -complete=arglist -bar TabvA
      \ TabA <args>
      \| silent! argdo set readonly

command! -nargs=* -range -complete=buffer -bar TabvB
      \ TabB <args>
      \| silent! argdo set readonly

function ArgD()
  if argc() == 1
    q
  elseif argc() == 2
    argdelete
    first
  else
    argdelete
    if argidx() == argc() - 1
      argument 1
    else
      next
    endif
  endif
endfunction

function BDArgD()
  silent! Bdel %
  call ArgD()
endfunction

" }}} 

" nops {{{ 

" }}} 

" remaps {{{ 

map <C-h> <C-]>
nnoremap <C-w><C-h> :<C-u>exe 'tab tag '.Expand('<cword>')<CR>

nmap <C-w>gf :<C-u>Tabe <cfile><CR>

" Nice thing for snippets
snoremap <BS> <BS>i

" }}} 

" taglist {{{ 

nnoremap <Space>tl :<C-u>tags<CR>
nnoremap <Space>t<Space>l :<C-u>filter  tags<C-Left><Left>

" because ctrl-t exists only this is defined
nnoremap <silent> <C-@> :<C-u>exe v:count1.'tag'<CR>

nnoremap <silent> <Space>tn :<C-u>exe v:count1.'tag'<CR>
nnoremap <silent> <Space>tp :<C-u>exe v:count1.'pop'<CR>
nnoremap <silent> <Space>tN :<C-u>exe v:count1.'tag!'<CR>
nnoremap <silent> <Space>tP :<C-u>exe v:count1.'pop!'<CR>
nnoremap <silent> <Space>tg :<C-u>exe v:count1.'tselect'<CR>
nnoremap <silent> <Space>tG :<C-u>exe v:count1.'tselect!'<CR>

nnoremap <silent> <Space>tj :<C-u>exe v:count1.'tnext'<CR>
nnoremap <silent> <Space>tJ :<C-u>exe v:count1.'tnext!'<CR>
nnoremap <silent> <Space>tk :<C-u>exe v:count1.'tprevious'<CR>
nnoremap <silent> <Space>tK :<C-u>exe v:count1.'tprevious!'<CR>

nnoremap <silent> <Space>t0 :<C-u>tfirst<CR>
nnoremap <silent> <Space>t;0 :<C-u>tfirst!<CR>
nnoremap <silent> <Space>t$ :<C-u>tlast<CR>
nnoremap <silent> <Space>t;$ :<C-u>tlast!<CR>

nnoremap <Space>tr :<C-u>!ctags -R<CR>
nnoremap <Space>t<Space>r :<C-u>!ctags -R<Space>

nnoremap <silent> <Space>tb :<C-u>!ctags -R &<CR>
nnoremap <Space>t<Space>b :<C-u>!ctags -R  &<Left><Left>

" TODO C ???
nnoremap <silent> <Space>ta :<C-u>ltag<CR>
nnoremap <Space>t<Space>a :<C-u>ltag<Space>
nnoremap <silent> <Space>tA :<C-u>ltag!<Space>
nnoremap <Space>t<Space>A :<C-u>ltag!<Space>

" }}} 

" TODO C tag matchlist {{{ 

" noremap <silent> <Space>tj :<C-u>tjump<CR>
" noremap <silent> <Space>ts :<C-u>stjump<CR>
" noremap <silent> <Space>tv :<C-u>vert stjump<CR>

" noremap <Space><Space>tj :<C-u>tjump<Space>
" noremap <Space><Space>ts :<C-u>stjump<Space>
" noremap <Space><Space>tv :<C-u>vert stjump<Space>

" noremap <Space>t<Space>t :<C-u>tag<Space>
" noremap <Space>t<Space>T :<C-u>tag!<Space>
" noremap <Space>t<Space>g :<C-u>tselect<Space>
" noremap <Space>t<Space>G :<C-u>tselect!<Space>

" }}} 

" TODO B preview window {{{ 

" }}} 

" better tab {{{ 

nnoremap <Tab>o :<C-u>Tabe<Space>
nnoremap <Tab>O :<C-u>-Tabe<Space>
nnoremap <Tab><Space>o :<C-u>TabA<Space>
nnoremap <Tab><Space>O :<C-u>-TabA<Space>
nnoremap <Tab>;o :<C-u>TabB<Space>
nnoremap <Tab>;O :<C-u>-TabB<Space>
nnoremap <silent> <Tab>k K<C-w>T

nnoremap <Tab>r :<C-u>Tabv<Space>
nnoremap <Tab>R :<C-u>-Tabv<Space>
nnoremap <Tab><Space>r :<C-u>TabvA<Space>
nnoremap <Tab><Space>R :<C-u>-TabvA<Space>
nnoremap <Tab>;r :<C-u>TabvB<Space>
nnoremap <Tab>;R :<C-u>-TabvB<Space>

nnoremap <Tab>gf :<C-u>Tabe <cfile><CR>

nnoremap <silent> <Tab>n :<C-u>call SwitchTab(v:count1)<CR>
nnoremap <silent> <Tab>N :<C-u>execute 'tabmove +'.v:count1<CR>
nnoremap <silent> <Tab>P :<C-u>execute 'tabmove -'.v:count1<CR>

nnoremap <expr> <Tab>f ':<C-u>'.v:count1.'tabfind '
nnoremap <expr> <Tab>F ':<C-u>-'.v:count1.'tabfind '

nnoremap <silent> <Tab>w :<C-u>We<CR>

" }}} 

" TODO D resizing with <Tab> {{{ 

" }}} 

" buffers with <Space><Space> {{{ 

nnoremap <silent> <Space><Space>d <Plug>Kwbd
nnoremap <Space><Space>gf :<C-u>edit <cfile><CR>

nnoremap <Space><Space>o :<C-u>Edit<Space>
nnoremap <Space><Space>O :<C-u>Edit!<Space>
nnoremap <Space><Space>a :<C-u>Badd<Space>

xnoremap <Space><Space>;l 
      \ :<C-u>exe 'filter '.
      \ GetVisualSelection().' buffers'<CR>
xnoremap <Space><Space>;L 
      \ :<C-u>exe 'filter '.
      \ GetVisualSelection().' buffers!'<CR>

nnoremap <silent> <Space><Space>n 
      \ :<C-u>exe v:count1.'bnext'<CR>
nnoremap <silent> <Space><Space>p 
      \ :<C-u>exe v:count1.'bprevious'<CR>
nnoremap <silent> <Space><Space>N 
      \ :<C-u>exe v:count1.'bnext!'<CR>
nnoremap <silent> <Space><Space>P 
      \ :<C-u>exe v:count1.'bprevious!'<CR>
nnoremap <silent> <Space><Space>m 
      \ :<C-u>exe v:count1.'bmodified'<CR>
nnoremap <silent> <Space><Space>M 
      \ :<C-u>exe v:count1.'bmodified!'<CR>

" }}} 

" args with <Space> {{{ 

nnoremap <Space>;o :<C-u>ArgeditB<Space>
nnoremap <Space>;O :<C-u>ArgeditB!<Space>
xnoremap <Space>;l 
      \ :<C-u>exe 'filter '.
      \ GetVisualSelection().' args'<CR>
nnoremap <Space>;a :<C-u>ArgaddB<Space>

nnoremap <silent> <Space>n :<C-u>call NextArg(1, 'argument')<CR>
nnoremap <silent> <Space>N :<C-u>call NextArg(1, 'argument!')<CR>
nnoremap <silent> <Space>p :<C-u>call NextArg(0, 'argument')<CR>
nnoremap <silent> <Space>P :<C-u>call NextArg(0, 'argument!')<CR>

nnoremap <silent> <Space>A :<C-u>argadd\|call NextArg(1, 'argument')<CR>

nnoremap <silent> <Space>. :<C-u>call NextArg(1, 'argument', 'w')<CR>
nnoremap <silent> <Space>> :<C-u>call NextArg(1, 'argument!', 'w')<CR>
nnoremap <silent> <Space>, :<C-u>call NextArg(0, 'argument', 'w')<CR>
nnoremap <silent> <Space>< :<C-u>call NextArg(0, 'argument!', 'w')<CR>

nnoremap <Space>gf :<C-u>argedit <cfile><CR>
nnoremap <Space>gF :<C-u>argedit! <cfile><CR>
nnoremap <Space>ga :<C-u>argadd <cfile><CR>

nnoremap <silent> <Space>D :<C-u>call ArgD()<CR>
nnoremap <silent> <Space>;D :<C-u>call BDArgD()<CR>

" }}} 

" <Space> list and help {{{ 

nnoremap <Space>il :ilist //<Left>
nnoremap <Space>i/ :isearch //<Left>

xnoremap <Space>i<Space>r 
      \ :<C-u>exe 'filter '.
      \ GetVisualSelection().' registers'<C-Left><C-b>
xnoremap <Space>i<Space>p 
      \ :<C-u>exe 'filter '.
      \ GetVisualSelection().' history'<C-Left><C-b>
xnoremap <Space>i<Space>c 
      \ :<C-u>exe 'filter '.
      \ GetVisualSelection().' changes'<C-Left><C-b>
xnoremap <Space>i<Space>j 
      \ :<C-u>exe 'filter '.
      \ GetVisualSelection().' jumps'<C-Left><C-b>
xnoremap <Space>i<Space>o 
      \ :<C-u>exe 'filter '.
      \ GetVisualSelection().' files'<C-Left><C-b>
xnoremap <Space>i<Space>m 
      \ :<C-u>exe 'filter '.
      \ GetVisualSelection().' marks'<C-Left><C-b>

nnoremap <expr> <Space>is g:qfloc ?
      \':<C-u>lhelpgrep<Space>'
      \ : ':<C-u>helpgrep<Space>'

nnoremap <space>inu :<C-u>exe 'g/'.expand('<cword>').'/#'<CR>
nnoremap <space>inw :<C-u>exe 'g/'.expand('<cWORD>').'/#'<CR>
nnoremap <space>inf :<C-u>exe 'g/'.expand('<cfile>').'/#'<CR>
nnoremap <space>ine :<C-u>exe 'g/'.expand('<cexpr>').'/#'<CR>
nnoremap <space>iny :<C-u>exe 'g/'.getreg('"').'/#'<CR>
nnoremap <space>ing :<C-u>exe 'g/'.getreg('*').'/#'<CR>
nnoremap <space>inp :<C-u>exe 'g/'.getreg('+').'/#'<CR>
nnoremap <space>ins :<C-u>exe 'g/'.GetVisualSelection().'/#'<CR>
xnoremap <space>in :<C-u>exe 'g/'.GetVisualSelection().'/#'<CR>

" }}} 

" leader stuff {{{ 

" TODO C add more commands

" General purpose leader mappings
noremap <Leader>;l :<C-u>!ls<CR>

" pwd
nnoremap <Leader>;cl :<C-u>silent! lcd %:p:h<CR>
nnoremap <Leader>;cc :<C-u>silent! cd %:p:h<CR>
nnoremap <Leader>;c<Space>l :<C-u>lcd<Space>
nnoremap <Leader>;c<Space>c :<C-u>lcd<Space>

" Not the best, but should work
nnoremap <silent> <Leader>;wc gg0vG$:<C-u>w !wc<CR>

nnoremap <Leader>;cp :<C-u>pwd<CR>

nnoremap <Leader>;m :<C-u>messages<CR>
nnoremap <Leader>;cx :<C-u>mkexrc<CR>
nnoremap <Leader>;c<Space>x :<C-u>mkexrc<Space>
nnoremap <Leader>;cv :<C-u>mkvimrc<CR>
nnoremap <Leader>;c<Space>v :<C-u>mkvimrc<Space>

" ???
" map <Leader>;r :!%<CR>

" }}} 

" quickfix and loclist {{{ 

" helpers {{{ 

function QuickFixToggle()
  let g:qfloc = !g:qfloc
  echo 'Quickfix is now ' . (g:qfloc ? 'local' : 'global')
endfunction

command -nargs=0 QfToLoc
      \ lexpr []
      \ | call setloclist(0, getqflist())
command -nargs=0 LocToQf
      \ cexpr []
      \ | call setqflist(getloclist(0))

" }}} 

" settings {{{ 

let g:qfheight = 15
let g:qfloc = 1

nnoremap ;t :<C-u>let g:qfloc = !g:qfloc
      \ \| echo 'Quickfix is now ' . 
      \ (g:qfloc ? 'local' : 'global')<CR>
nnoremap ;q :<C-u> echo 'Quickfix is now ' . 
      \ (g:qfloc ? 'local' : 'global')<CR>

xnoremap ;t :<C-u>let g:qfloc = !g:qfloc
      \ \| echo 'Quickfix is now ' . 
      \ (g:qfloc ? 'local' : 'global')
      \ \| normal gv<CR>
xnoremap ;q :<C-u> echo 'Quickfix is now ' . 
      \ (g:qfloc ? 'local' : 'global')
      \ \| normal gv<CR>

" }}} 

" getting {{{ 

nnoremap <silent> ;b :<C-u>call QFcmd('getbuffer')<CR>
nnoremap <silent> ;B :<C-u>call QFcmd("getbuffer '.v:count1", "exe '")<CR>
nnoremap <expr> ;<Space>b g:qfloc ? 
      \ ':<C-u>lgetbuffer <Space>'
      \ : ':<C-u>cgetbuffer <Space>'

nnoremap <silent> ;<Tab> :<C-u>call QFcmd('getfile')<CR>
nnoremap <expr> ;<Space><Tab> g:qfloc ? 
      \ ':<C-u>lgetfile <Space>'
      \ : ':<C-u>cgetfile <Space>'

" }}} 

" *do {{{ 

nnoremap <expr> ;:
      \ g:qfloc ? ':<C-u>ldo<Space>'
      \ : ':<C-u>cdo<Space>'

nnoremap <expr> ;;:
      \ g:qfloc ? ':<C-u>ldo!<Space>'
      \ : ':<C-u>cdo!<Space>'

nnoremap <expr> ;m
      \ g:qfloc ? ':<C-u>lfdo<Space>'
      \ : ':<C-u>cfdo<Space>'

nnoremap <expr> ;;m
      \ g:qfloc ? ':<C-u>lfdo!<Space>'
      \ : ':<C-u>cfdo!<Space>'

" }}} 

" movement {{{ 

nnoremap <silent> ;j
      \ :<C-u>call QFcmd('n', v:count1)<CR>
nnoremap <silent> ;k
      \ :<C-u>call QFcmd('p', v:count1)<CR>
nnoremap <silent> ;n
      \ :<C-u>call QFcmd('nf', v:count1)<CR>
nnoremap <silent> ;p
      \ :<C-u>call QFcmd('pf', v:count1)<CR>
nnoremap <silent> ;g
      \ :<C-u>call QFsel('cc ', 'll ', '', v:count1)<CR>

nnoremap <silent> ;0 :<C-u>call QFcmd('first')<CR>
nnoremap <silent> ;$ :<C-u>call QFcmd('last')<CR>
nnoremap <silent> ;G :<C-u>call QFcmd('bottom')<CR>

nnoremap <silent> ;<
      \ :<C-u>call QFcmd('older '.v:count1)<CR>
nnoremap <silent> ;>
      \ :<C-u>call QFcmd('newer '.v:count1)<CR>

" }}} 

"  actions {{{ 

nnoremap <silent> ;w 
      \ :<C-u>call QFcmd("open '.g:qfheight", "exe '")<CR>
nnoremap <silent> ;W
      \ :<C-u>call QFcmd("window '.g:qfheight", "exe '")<CR>
nnoremap <silent> <C-w>;w
      \ :<C-u>call QFcmd("open '.g:qfheight", "exe '")<CR><C-w>T
nnoremap <silent> <C-w>;W
      \ :<C-u>call QFcmd("window '.g:qfheight", "exe '")<CR><C-w>T

nnoremap ;l :<C-u>call QFcmd('list')<CR>
nnoremap ;L :<C-u>call QFcmd('history')<CR>

nnoremap <silent> ;h :<C-u>call NToggleQuickFix()<CR>
" TODO B
xnoremap <silent> ;h :<C-u>call VToggleQuickFix()<CR>

" clearing
nnoremap <silent> ;c :<C-u>call QFcmd('expr []')<CR>

" copying
nnoremap <silent> ;C g:qfloc ?
      \ ':<C-u>QfToLoc<CR>'
      \ : ':<C-u>LocToQf<CR>'

" putting
nnoremap <silent> ;= g:qfloc ?
      \ ':<C-u>LocToQf<CR>'
      \ : ':<C-u>QfToLoc<CR>'

nnoremap <expr> ;e g:qfloc ?
      \ ':<C-u>lexpr<Space>'
      \ : ':<C-u>cexpr<Space>'

" }}} 

" search {{{ 

" search into quickfix list
nnoremap <expr> ;/ g:qfloc ? 
      \ ':<C-u>g//lexpr Expand("%").":".line(".").":".getline(".")
      \ <Home><Right><Right>'
      \ : ':<C-u>g//cexpr Expand("%").":".line(".").":".getline(".")
      \ <Home><Right><Right>'

" search into quickfix list
nnoremap <expr> ;? g:qfloc ? 
      \ ':<C-u>g//laddexpr Expand("%").":".line(".").":".getline(".")
      \ <Home><Right><Right>'
      \ : ':<C-u>g//caddexpr Expand("%").":".line(".").":".getline(".")
      \ <Home><Right><Right>'

nnoremap <expr> ;f g:qfloc ?
      \ ':<C-u>Lfilter //<Left>'
      \ : ':<C-u>Cfilter //<Left>'
nnoremap <expr> ;F g:qfloc ?
      \ ':<C-u>Lfilter! //<Left>'
      \ : ':<C-u>Cfilter! //<Left>'

nnoremap <expr> ;;f g:qfloc ?
      \ ':<C-u>Lfilter ##<Left>'
      \ : ':<C-u>Cfilter ##<Left>'
nnoremap <expr> ;;F g:qfloc ?
      \ ':<C-u>Lfilter! ##<Left>'
      \ : ':<C-u>Cfilter! ##<Left>'


" }}} 

augroup Quickfix " {{{ 
  autocmd FileType qf 
        \noremap <buffer> <silent> q :q<CR>
        \| noremap <buffer> < :<C-u>call WQFcmd('older')<CR>
        \| nnoremap <buffer> > :<C-u>call WQFcmd('newer')<CR>
        \| nnoremap <buffer> <silent> <BS> <CR>
        \| nmap <buffer> <CR>
        \ :<C-u>let qpos = getpos('.')<CR>
        \<BS>:<C-u>call QFcmd("open '.g:qfheight", "exe '")<CR>
        \:call setpos('.', qpos)<CR>
        \<C-l><Right><Left>
        \| nmap <buffer> <silent> <C-h>
        \ <CR>:call WQFcmd('close')<CR>
        \| nmap <buffer> <silent> J j<CR>
        \| nmap <buffer> <silent> K k<CR>
        \| noremap <buffer> <expr> a g:qfloc ?
        \ ':<C-u>laddexpr<Space>'
        \ : ':<C-u>caddexpr<Space>'
        \| noremap <buffer> <expr> i g:qfloc ?
        \ ':<C-u>laddfile<Space>'
        \ : ':<C-u>caddfile<Space>'
        \| noremap <buffer> <expr> I g:qfloc ?
        \ ':<C-u>laddbuffer<Space>'
        \ : ':<C-u>caddbuffer<Space>'
        \| nnoremap <buffer> <expr> <silent> dd g:qfloc ?
        \ "m`:<C-u>call setloclist(0, filter(getloclist(0),
        \ {idx -> idx < line('.') - 1 \|\|
        \ idx > line('.') + v:count - 1}), 'r')<CR>'`"
        \ : "m`:<C-u>call setqflist(filter(getqflist(),
        \ {idx -> idx < line('.') - 1 \|\|
        \ idx > line('.') + v:count - 1}), 'r')<CR>'`"
  "TODO C undo (will be tough)
augroup END " }}} 

" commands {{{ 

let s:ls = 'ls --color=never -1 -A'
let s:ls_rec = '-R'
let s:sed_cmd = 'sed -E'
let s:sed_exp = '\"s/$/:1:0\"/'
let s:find_flags = '-mindepth 1'
let s:find_cmd = 'find -H'
let s:find_nore = '-maxdepth 1'
let s:find_files = '-xtype f'
let s:find_dirs = '-xtype d'

exe "nnoremap <expr> ;;l g:qfloc ?"
            \ ." ':<C-u>lexpr system(\"".s:ls." \\| "
            \ .s:sed_cmd.' '.s:sed_exp."\")<CR>'"
            \ ." : ':<C-u>cexpr system(\"".s:ls." \\| "
            \ .s:sed_cmd.' '.s:sed_exp."\")<CR>'"

exe "nnoremap <expr> ;;L g:qfloc ?"
            \ ." ':<C-u>lexpr system(\"".s:ls." ".s:ls_rec" \\| "
            \ .s:sed_cmd.' '.s:sed_exp."\")<CR>'"
            \ ." : ':<C-u>cexpr system(\"".s:ls." ".s:ls_rec." \\| "
            \ .s:sed_cmd.' '.s:sed_exp."\")<CR>'"

" }}} 

" }}} 

" matchit {{{ 

map <Space>{ [%
map <Space>} ]%

" }}} 

" completion {{{ 

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <Esc> pumvisible() ? "<C-e>" : "<Esc>"
inoremap <expr> <Tab> pumvisible() ? "<C-y>" : "<Tab>"
" ??
inoremap <expr> <S-Tab> pumvisible() ? "<C-p><C-y>" : "<S-Tab>"

" <C-Space> in terminal
inoremap <C-Space> <C-@>
inoremap <expr> <C-@> pumvisible() ?
      \'<C-n>' : (&omnifunc == '') ? '<C-n>' : '<C-x><C-o>'

" ?
" CTRL-X CTRL-E scroll up
" CTRL-X CTRL-Y scroll down

" CTRL-X CTRL-N next completion
" CTRL-X CTRL-P previous completion

" default PageUp and PageDown don't work
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
inoremap <C-x>j <C-x><C-]>

" }}} 

" other insert {{{

inoremap <C-x>c <C-k>
inoremap <C-k> <Nop>

" }}}

" magic and other space {{{ 

nnoremap <Space>g/ /\v
nnoremap <Space>g? /\V
nnoremap <Space>g% /\%V

" Shit, but probably must be like that
cnoremap <C-o>/ \v
cnoremap <C-o>? \V
cnoremap <C-o>; \%V

nnoremap <Space>x :perldo
nnoremap <Space>X :perl

" }}} 

" commands {{{ 

cnoremap <expr> <C-o>c "<C-r>="
cnoremap <expr> <C-o>u "<C-r>=expand('<cword>')<CR>"
cnoremap <expr> <C-o>w "<C-r>=expand('<cWORD>')<CR>"
cnoremap <expr> <C-o>e "<C-r>=expand('<cexpr>')<CR>"
cnoremap <expr> <C-o>f "<C-r>=expand('<cfile>')<CR>"
cnoremap <expr> <C-o>y "<C-r>=getreg('\"')<CR>"
cnoremap <expr> <C-o>g "<C-r>=getreg('*')<CR>"
cnoremap <expr> <C-o>p "<C-r>=getreg('+')<CR>"

cnoremap <expr> <C-o><Space>w "<cword>"
cnoremap <expr> <C-o><Space>c "<cWORD>"
cnoremap <expr> <C-o><Space>e "<cexpr>"
cnoremap <expr> <C-o><Space>f "<cfile>"
cnoremap <expr> <C-o><Space>y "@\"<CR>"
cnoremap <expr> <C-o><Space>g "@*<CR>"
cnoremap <expr> <C-o><Space>p "@+<CR>"

" }}} 

" TODO {{{ 

" TODO B running command under cursor
" TODO C running command in given register (???)
" TODO C https://youtu.be/w7i4amO_zaE?t=1464

" Run command in register c
" map <silent> <Leader>;E 'cyy:execute '!' . getreg('c')<CR>
" map <silent> <Leader>;D 'cyydd:execute '!' . getreg('c')<CR>
"nmap <silent> <Leader>W bvw"cy:execute "!" . getreg('c')<CR>

" }}} 
