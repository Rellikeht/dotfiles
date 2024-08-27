"{{{ session

nnoremap ,usm :<C-u>mksession<CR>
vnoremap ,usm :<C-u>mksession\|norm gv<CR>
nnoremap ,usM :<C-u>mksession<Space>
vnoremap ,usM :<C-u>mksession  \|norm gv<C-Left><C-Left><Left>

"}}}

"{{{ TODO B is that enough - diff

"{{{ helpers

function DiffGet(pane)
  execute 'diffget' a:pane
  diffupdate
endfunction

function DiffPut(pane)
  execute 'diffget' a:pane
  diffupdate
endfunction

"}}}

"{{{ settings

if has('patch-8.1.0360')
  set diffopt=internal,filler,closeoff,algorithm:patience,context:8
endif

" TODO C algorithm?

function s:ToggleFiller()
  let l:opt = &diffopt
  set diffopt-=filler
  if &diffopt == l:opt
    set diffopt+=filler
  endif
endfunction

nnoremap <silent> <Space>hqf
      \ :<C-u>call <SID>ToggleFiller()<CR>
vnoremap <silent> <Space>hqf
      \ :<C-u>call <SID>ToggleFiller()\|norm gv<CR>

"}}}

"{{{ maps

noremap <silent> <Space>hdp :<C-u>diffput<CR>
noremap <silent> <Space>hdg :<C-u>diffget<CR>
noremap <silent> <Space>hd<Space>p :<C-u>diffput<Space>
noremap <silent> <Space>hd<Space>g :<C-u>diffget<Space>
nnoremap <silent> <Space>hdu :<C-u>diffupdate<CR>
vnoremap <silent> <Space>hdu :<C-u>diffupdate\|norm gv<CR>

noremap <silent> <Space>hg0 :<C-u>call DiffGet('//0')<CR>
noremap <silent> <Space>hg1 :<C-u>call DiffGet('//1')<CR>
noremap <silent> <Space>hg2 :<C-u>call DiffGet('//2')<CR>
noremap <silent> <Space>hg3 :<C-u>call DiffGet('//3')<CR>

noremap <silent> <Space>hp0 :<C-u>call DiffPut('//0')<CR>
noremap <silent> <Space>hp1 :<C-u>call DiffPut('//1')<CR>
noremap <silent> <Space>hp2 :<C-u>call DiffPut('//2')<CR>
noremap <silent> <Space>hp3 :<C-u>call DiffPut('//3')<CR>

noremap <silent> <Space>hpf :<C-u>call DiffPut(Expand('%:p'))<CR>
noremap <silent> <Space>hp;f :<C-u>call DiffPut(Expand('%:t'))<CR>
noremap <silent> <Space>hgf :<C-u>call DiffGet(Expand('%:p'))<CR>
noremap <silent> <Space>hg;f :<C-u>call DiffGet(Expand('%:t'))<CR>

nnoremap <silent> <Space>hoo :<C-u>diffoff<CR>
vnoremap <silent> <Space>hoo :<C-u>diffoff\|norm gv<CR>
nnoremap <silent> <Space>hot :<C-u>diffthis<CR>
vnoremap <silent> <Space>hot :<C-u>diffthis\|norm gv<CR>
noremap <silent> <Space>ho<Space>t :<C-u>diffthis<Space>

"}}}

"}}}

"{{{ nops

noremap <Space>f <Nop>
noremap <Space><Space>f <Nop>
noremap <Space>b <Nop>
noremap <Space>/ <Nop>
noremap <Space>? <Nop>

"}}}

"{{{ TODO B history
" :later and :earlier

"}}}

"{{{ drag and drop

" TODO C more ?

" Pushing to dragon
nnoremap <silent> <Leader>xy
      \ :<C-u>exe '!dragon --on-top --and-exit '.
      \ Expand("%").' 2>/dev/null &'<CR>
      \ :redraw!<CR>
vnoremap <silent> <Leader>xy
      \ :<C-u>exe '!dragon --on-top --and-exit '.
      \ Expand("%").' 2>/dev/null &'<CR>
      \ :redraw!<CR>
      \ :norm gv<CR>

nnoremap <silent> <Leader>xY
      \ :<C-u>exe '!dragon --on-top --and-exit '.
      \ Expand("<cfile>").' 2>/dev/null &'<CR>
      \ :redraw!<CR>
vnoremap <silent> <Leader>xY
      \ :<C-u>exe '!dragon --on-top --and-exit '.
      \ Expand("<cfile>").' 2>/dev/null &'<CR>
      \ :redraw!<CR>
      \ :norm gv<CR>

" Editing from dragon
noremap <Leader>x<space>o
      \ :<C-u>exe 'argedit '.
      \ system('dragon --on-top --target --and-exit '.
      \ '2>/dev/null')<CR>
      \ :redraw<CR>
noremap <C-w><Leader>xo
      \ :<C-u>exe 'tabedit '.
      \ system('dragon --on-top --target --and-exit '.
      \ '2>/dev/null')<CR>
      \ :redraw<CR>
noremap <Leader>xo
      \ :<C-u>exe 'edit '.
      \ system('dragon --on-top --target --and-exit '.
      \ '2>/dev/null')<CR>
      \ :redraw<CR>

"}}}

"{{{ find

" nnoremap <Space><Space>fu :<C-u>find <cfile><CR>
" nnoremap <Space><Space>fw :<C-u>find <cword><CR>
" nnoremap <Space><Space>fm :<C-u>find <cWORD><CR>
" nnoremap <Space><Space>fe :<C-u>find <cexpr><CR>

" " nnoremap <Space><Space>f<Space> :<C-u>find<Space>
" nnoremap <Space><Space>fs :<C-u>exe 'find '.
"       \ GetVisualEsc()<CR>
" nnoremap <Space><Space>f;s :<C-u>exe 'find '.
"       \ GetVisualEsc()

" vnoremap <Space><Space><Space>f :<C-u>find<Space>
" vnoremap <Space><Space>f :<C-u>exe 'find '.
"       \ GetVisualEsc()<CR>
" vnoremap <Space><Space>;f :<C-u>exe 'find '.
"       \ GetVisualEsc()

"}}}

"{{{ TODO C (more ?) - vimgrep

"{{{ helpers

function s:VimMap(keys, pattern, end, bang=0, qpat=1, qend=1, vesc=1)
  let l:pattern = a:qpat ? "'".a:pattern."'" : a:pattern
  let l:bang = a:bang ? '!' : ''
  let l:end = a:qend ? "'".a:end."'" : a:end
  let l:esc = a:vesc ? "'<Esc>'." : ''
  return 'noremap <expr> <Space>'.a:keys.' g:qfloc ? '.
        \ l:esc."':<C-u>'.Vgcount().'lvimgrep".l:bang.
        \ " '.".l:pattern.'.'.l:end.
        \ ': '.l:esc."':<C-u>'.Vgcount().'vimgrep".l:bang.
        \ " '.".l:pattern.'.'.l:end
endfunction

function Fupper(str)
  return (toupper(a:str[0]).a:str[1:])
endfunction

function Lupper(str)
  return (a:str[:len(a:str)-2].toupper(a:str[len(a:str)-1]))
endfunction

function s:VMCombo(keys, pattern, end, mode='', vesc=0, qpat=1, qend=1)
  let l:keys = 'v'.a:keys
  exe a:mode.s:VimMap(l:keys, a:pattern, a:end, 0, a:qpat, a:qend, a:vesc)
  exe a:mode.s:VimMap(Lupper(l:keys), a:pattern, a:end, 1, a:qpat, a:qend, a:vesc)
  exe a:mode.s:VimMap(Fupper(l:keys), a:pattern.'f', a:end, 0, a:qpat, a:qend, a:vesc)
  exe a:mode.s:VimMap(Lupper(Fupper(l:keys)), a:pattern.'f', a:end, 1, a:qpat, a:qend, a:vesc)
endfunction

"}}}

"{{{ mappings generation

" TODO B filter .sw[po]

let s:vgmaps = [
      \ ['vc', '', '', 0, 0],
      \ ['vC', '', '', 1, 0],
      \ ]

" TODO A <cfile>
let s:vgcmaps = [
      \ ['<Space>u', '//gj', " '.Expand('<cfile>').' <Home><C-Right><Right>"],
      \ ] + [
      \ ['<Space>c', '//gj', '<C-Left><Right>'],
      \ ['<Space>f', "//gj", ' %<C-Left><C-Left><Right>'],
      \ ['<Space>a', "//gj", ' ## <C-Left><C-Left><Right>'],
      \ ['<Space>l', "//gj", ' * <C-Left><C-Left><Right>'],
      \ ['<Space>h', "//gj", ' .* * <C-Left><C-Left><C-Left><Right>'],
      \ ['<Space>r', "//gj", ' ** <C-Left><C-Left><Right>'],
      \ ['<Space>R', "//gj", ' .*/** ** <C-Left><C-Left><C-Left><Right>'],
      \ ] + [
      \ ['uc', "/'.Expand('<cword>').'/gj", ' ', 'n'],
      \ ['uf', "/'.Expand('<cword>').'/gj", ' % <CR>', 'n'],
      \ ['ua', "/'.Expand('<cword>').'/gj", ' ## <CR>', 'n'],
      \ ['ul', "/'.Expand('<cword>').'/gj", ' * <CR>', 'n'],
      \ ['uh', "/'.Expand('<cword>').'/gj", ' .* * <CR>', 'n'],
      \ ['ur', "/'.Expand('<cword>').'/gj", ' ** <CR>', 'n'],
      \ ['uR', "/'.Expand('<cword>').'/gj", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['wc', "/'.Expand('<cWORD>').'/gj", ' ', 'n'],
      \ ['wf', "/'.Expand('<cWORD>').'/gj", ' % <CR>', 'n'],
      \ ['wa', "/'.Expand('<cWORD>').'/gj", ' ## <CR>', 'n'],
      \ ['wl', "/'.Expand('<cWORD>').'/gj", ' * <CR>', 'n'],
      \ ['wh', "/'.Expand('<cWORD>').'/gj", ' .* * <CR>', 'n'],
      \ ['wr', "/'.Expand('<cWORD>').'/gj", ' ** <CR>', 'n'],
      \ ['wR', "/'.Expand('<cWORD>').'/gj", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['ec', "/'.Expand('<cexpr>').'/gj", ' ', 'n'],
      \ ['ef', "/'.Expand('<cexpr>').'/gj", ' % <CR>', 'n'],
      \ ['ea', "/'.Expand('<cexpr>').'/gj", ' ## <CR>', 'n'],
      \ ['el', "/'.Expand('<cexpr>').'/gj", ' * <CR>', 'n'],
      \ ['eh', "/'.Expand('<cexpr>').'/gj", ' .* * <CR>', 'n'],
      \ ['er', "/'.Expand('<cexpr>').'/gj", ' ** <CR>', 'n'],
      \ ['eR', "/'.Expand('<cexpr>').'/gj", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['pc', "/'.Vescape(@\").'/gj", ' ', 'n'],
      \ ['pf', "/'.Vescape(@\").'/gj", ' % <CR>', 'n'],
      \ ['pa', "/'.Vescape(@\").'/gj", ' ## <CR>', 'n'],
      \ ['pl', "/'.Vescape(@\").'/gj", ' * <CR>', 'n'],
      \ ['ph', "/'.Vescape(@\").'/gj", ' .* * <CR>', 'n'],
      \ ['pr', "/'.Vescape(@\").'/gj", ' ** <CR>', 'n'],
      \ ['pR', "/'.Vescape(@\").'/gj", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['sc', "/'.Vescape(GetVisualSelection()).'/gj", ' '],
      \ ['sf', "/'.Vescape(GetVisualSelection()).'/gj", ' %<CR>'],
      \ ['sa', "/'.Vescape(GetVisualSelection().'/gj", ' ## <CR>'],
      \ ['sl', "/'.Vescape(GetVisualSelection().'/gj", ' * <CR>'],
      \ ['sh', "/'.Vescape(GetVisualSelection().'/gj", ' .* * <CR>'],
      \ ['sr', "/'.Vescape(GetVisualSelection().'/gj", ' ** <CR>'],
      \ ['sR', "/'.Vescape(GetVisualSelection().'/gj", ' .*/** ** <CR>'],
      \ ]

for m in s:vgmaps
  exe call('s:VimMap', m)
endfor

for m in s:vgcmaps
  call call('s:VMCombo', m)
endfor

"}}}

" TODO C vimgrepadd

"}}}

"{{{ TODO C (more ?) - grep

" - separate shortcut for grep and ag/rg
" - grep with variable controlling case
" - ag/rg with the same variable, --hidden/unrestricted
"   as variable or generate separate shortcuts
" - ag/rg switch as separate variable
" - recursive ???

"{{{ grep helpers

" TODO B async
" TODO C count
" silent grep
function Grep(...)
  let l:grep = substitute(&grepprg, '\ ', ' ', 'g')
  let cmd = join([l:grep] + [expandcmd(join(a:000, ' '))], ' ')
  echo cmd
  return system(cmd)
endfunction

" commands for it
command -nargs=+ -complete=file Grep cgetexpr Grep(<f-args>)
command -nargs=+ -complete=file Lgrep lgetexpr Grep(<f-args>)
command -nargs=+ -complete=file Sgrep
      \ let grepres = Grep(<f-args>)
      \ | if g:qfloc
      \ | exe 'lgetexpr grepres'
      \ | else
      \ | exe 'cgetexpr grepres'
      \ | endif

command -nargs=+ -complete=file Wgrep
      \ Sgrep <args>
      \ | if g:qfloc
      \ | lopen
      \ | else
      \ | copen
      \ | endif

" and abbrev
cnoreabbrev <expr> grep
      \ (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ?
      \ 'Grep' : 'grep'
cnoreabbrev <expr> lgrep
      \ (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ?
      \ 'Lgrep' : 'lgrep'

let s:grep_prefix = '<Space>g'

function s:GrepMap(keys, pattern, end, bang=0, qpat=1, qend=1, vesc=1)
  let l:pattern = a:qpat ? "'".a:pattern."'" : a:pattern
  let l:bang = a:bang ? '!' : ''
  let l:end = a:qend ? "'".a:end."'" : a:end
  let l:esc = a:vesc ? "'<Esc>'." : ''
  return 'noremap <expr> '.s:grep_prefix.a:keys.' g:qfloc ? '.
        \ l:esc."':<C-u>Lgrep".l:bang.
        \ " '.".l:pattern.'.'.l:end.
        \ ': '.l:esc."':<C-u>Grep".l:bang.
        \ " '.".l:pattern.'.'.l:end
endfunction

function s:GMCombo(keys, pattern, end, mode='', vesc=0, qpat=1, qend=1)
  exe a:mode.s:GrepMap(a:keys, a:pattern, a:end, 0, a:qpat, a:qend, a:vesc)
  exe a:mode.s:GrepMap(Lupper(a:keys), a:pattern, a:end, 1, a:qpat, a:qend, a:vesc)
endfunction

"}}}

"{{{ additional helpers

" silent grep
function Egrep(...)
  let l:grep = substitute(&grepprg, '\ ', ' ', 'g')
  let cmd = join([g:egrep_prog] + [expandcmd(join(a:000, ' '))], ' ')
  echo cmd
  return system(cmd)
endfunction

" commands for it
command -nargs=+ -complete=file Egrep cgetexpr Egrep(<f-args>)
command -nargs=+ -complete=file Legrep lgetexpr Egrep(<f-args>)
command -nargs=+ -complete=file Segrep
      \ let grepres = Egrep(<f-args>)
      \ | if g:qfloc
      \ | exe 'lgetexpr grepres'
      \ | else
      \ | exe 'cgetexpr grepres'
      \ | endif

command -nargs=+ -complete=file Wegrep
      \ Segrep <args>
      \ | if g:qfloc
      \ | lopen
      \ | else
      \ | copen
      \ | endif

" and abbrev
cnoreabbrev <expr> egrep
      \ (getcmdtype() ==# ':' && getcmdline() ==# 'egrep') ?
      \ 'Egrep' : 'egrep'
cnoreabbrev <expr> legrep
      \ (getcmdtype() ==# ':' && getcmdline() ==# 'legrep') ?
      \ 'Legrep' : 'legrep'

let s:egrep_prefix = '<Space>s'

function s:EgrepMap(keys, pattern, end, bang=0, qpat=1, qend=1, vesc=1)
  let l:pattern = a:qpat ? "'".a:pattern."'" : a:pattern
  let l:bang = a:bang ? '!' : ''
  let l:end = a:qend ? "'".a:end."'" : a:end
  let l:esc = a:vesc ? "'<Esc>'." : ''
  return 'noremap <expr> '.s:egrep_prefix.a:keys.' g:qfloc ? '.
        \ l:esc."':<C-u>Legrep".l:bang.
        \ " '.".l:pattern.'.'.l:end.
        \ ': '.l:esc."':<C-u>Egrep".l:bang.
        \ " '.".l:pattern.'.'.l:end
endfunction

function s:EGMCombo(keys, pattern, end, mode='', vesc=0, qpat=1, qend=1)
  exe a:mode.s:EgrepMap(a:keys, a:pattern, a:end, 0, a:qpat, a:qend, a:vesc)
  exe a:mode.s:EgrepMap(Lupper(a:keys), a:pattern, a:end, 1, a:qpat, a:qend, a:vesc)
endfunction

"}}}

"{{{ grep settings

exe 'set grepprg='.escape(copy(g:grep), ' ')
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
let g:greprec = 0
let g:grepcase = 0

call MapToggle(s:grep_prefix, 'r', 'g:greprec', 0, 
      \ '\|exe (g:greprec ? "set grepprg+=\\ -r" : "set grepprg-=\\ -r")')
call VarPrint(s:grep_prefix, 'r',  'Recursive grep', 'g:greprec')
call MapToggle(s:grep_prefix, 'i', 'g:grepcase', 0,
      \ '\|exe (g:grepcase ? "set grepprg+=\\ -i" : "set grepprg-=\\ -i")')
call VarPrint(s:grep_prefix, 'i',  'grep ignore case', 'g:grepcase')
call VarPrint(s:grep_prefix, 'c', 'grepprg', &grepprg, 0)

"}}}

"{{{ additional settings

let s:egrep_format = '%f:%l:%c:%m'
let s:egrep_flags = '--vimgrep --smart-case --no-heading --hidden'
let s:egrep_progs = [
     \ 'ag --nobreak --nocolor '.s:egrep_flags,
     \ 'rg --color=never '.s:egrep_flags,
     \ ]

let g:egrep_rec = 0
let g:egrep_urest = 0
let g:egrep_ind = 0

function EgrepPrg()
  let l:prg = s:egrep_progs[g:egrep_ind]
  let l:rec = (g:egrep_rec ? '' : 
        \ (l:prg[0:1] == 'ag' ? '-n ' : '--max-depth=0 '))
  let l:urest = (g:egrep_urest ? '--unrestricted ' : '')
  return l:prg.' '.l:rec.l:urest
endfunction

let g:egrep_prog = EgrepPrg()

call MapToggle(s:egrep_prefix, 'u', 'g:egrep_urest')
call VarPrint(s:egrep_prefix, 'u',  'Unrestricted egrep', 'g:egrep_urest')
call MapToggle(s:egrep_prefix, 'r', 'g:egrep_rec')
call VarPrint(s:egrep_prefix, 'r',  'Recursive egrep', 'g:egrep_rec')
call MapToggle(s:egrep_prefix, 'c', 'g:egrep_ind', 1,
      \ '\|let g:egrep_prog = EgrepPrg()\|echo "egrep program: ".g:egrep_prog')
call VarPrint(s:egrep_prefix, 'c', 'egrep program', 'g:egrep_prog', 0)

"}}}

"{{{ maps

let s:gmaps = [
      \ ['c', '', '', 0, 0],
      \ ['C', '', '', 1, 0],
      \ ]

let s:egmaps = copy(s:gmaps)

let s:gcmaps = [
      \ ['<Space>u', '', " '.Expand('<cfile>').' <Home><C-Right><Right>"],
      \ ] + [
      \ ['<Space>f', '', " '.shellescape(expand('%')).'<Home><C-Right><Right>"],
      \ ['<Space>a', '', ' ## <Home><C-Right><Right>'],
      \ ['<Space>l', '', ' * <Home><C-Right><Right>'],
      \ ['<Space>h', '', ' .* * <Home><C-Right><Right>'],
      \ ['<Space>r', '', ' ** <Home><C-Right><Right>'],
      \ ['<Space>R', '', ' .*/** ** <Home><C-Right><Right>'],
      \ ] + [
      \ ['uc', "'.Expand('<cword>').'", ' ', 'n'],
      \ ['uf', "'.Expand('<cword>').'", " '.shellescape(expand('%')).' <CR>", 'n'],
      \ ['ua', "'.Expand('<cword>').'", ' ## <CR>', 'n'],
      \ ['ul', "'.Expand('<cword>').'", ' * <CR>', 'n'],
      \ ['uh', "'.Expand('<cword>').'", ' .* * <CR>', 'n'],
      \ ['ur', "'.Expand('<cword>').'", ' ** <CR>', 'n'],
      \ ['uR', "'.Expand('<cword>').'", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['wc', "'.Expand('<cWORD>').'", ' ', 'n'],
      \ ['wf', "'.Expand('<cWORD>').'", " '.shellescape(expand('%')).' <CR>", 'n'],
      \ ['wa', "'.Expand('<cWORD>').'", ' ## <CR>', 'n'],
      \ ['wl', "'.Expand('<cWORD>').'", ' * <CR>', 'n'],
      \ ['wh', "'.Expand('<cWORD>').'", ' .* * <CR>', 'n'],
      \ ['wr', "'.Expand('<cWORD>').'", ' ** <CR>', 'n'],
      \ ['wR', "'.Expand('<cWORD>').'", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['ec', "'.Expand('<cexpr>').'", ' ', 'n'],
      \ ['ef', "'.Expand('<cexpr>').'", " '.shellescape(expand('%')).' <CR>", 'n'],
      \ ['ea', "'.Expand('<cexpr>').'", ' ## <CR>', 'n'],
      \ ['el', "'.Expand('<cexpr>').'", ' * <CR>', 'n'],
      \ ['eh', "'.Expand('<cexpr>').'", ' .* * <CR>', 'n'],
      \ ['er', "'.Expand('<cexpr>').'", ' ** <CR>', 'n'],
      \ ['eR', "'.Expand('<cexpr>').'", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['pc', "'.Vescape(@\").'", ' ', 'n'],
      \ ['pf', "'.Vescape(@\").'", " '.shellescape(expand('%')).' <CR>", 'n'],
      \ ['pa', "'.Vescape(@\").'", ' ## <CR>', 'n'],
      \ ['pl', "'.Vescape(@\").'", ' * <CR>', 'n'],
      \ ['ph', "'.Vescape(@\").'", ' .* * <CR>', 'n'],
      \ ['pr', "'.Vescape(@\").'", ' ** <CR>', 'n'],
      \ ['pR', "'.Vescape(@\").'", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['sc', "'.Vescape(GetVisualSelection()).'", ' '],
      \ ['sf', "'.Vescape(GetVisualSelection()).'", " '.shellescape(expand('%')).'<CR>"],
      \ ['sa', "'.Vescape(GetVisualSelection().'", ' ## <CR>'],
      \ ['sl', "'.Vescape(GetVisualSelection().'", ' * <CR>'],
      \ ['sh', "'.Vescape(GetVisualSelection().'", ' .* * <CR>'],
      \ ['sr', "'.Vescape(GetVisualSelection().'", ' ** <CR>'],
      \ ['sR', "'.Vescape(GetVisualSelection().'", ' .*/** ** <CR>'],
      \ ]

for m in s:gmaps
  exe call('s:GrepMap', m)
endfor

for m in s:gcmaps
  call call('s:GMCombo', m)
endfor

for m in s:egmaps
  exe call('s:EgrepMap', m)
endfor

for m in s:gcmaps
  call call('s:EGMCombo', m)
endfor

exe "noremap <expr> ".s:grep_prefix."- g:qfloc ?".
      \ "':<C-u>Lfilter /^grep: /<CR>'".
      \ ": ':<C-u>Cfilter /^grep: /<CR>'"
exe "noremap ".s:grep_prefix."j :<C-u>Sgrep<Space>"
exe "noremap ".s:grep_prefix."J :<C-u>Sgrep!<Space>"

" TODO C filtering errors
" noremap <expr> <Space>s- g:qfloc ?
"       \ ':<C-u>Lfilter /^grep: /<CR>'
"       \ : ':<C-u>Cfilter /^grep: /<CR>'
" exe "noremap <expr> ".s:grep_prefix."- g:qfloc ?".
"       \ "':<C-u>Lfilter /^grep: /<CR>'".
"       \ ": ':<C-u>Cfilter /^grep: /<CR>'"

exe "noremap ".s:egrep_prefix."j :<C-u>Segrep<Space>"
exe "noremap ".s:egrep_prefix."J :<C-u>Segrep!<Space>"

"}}}

" TODO C grepadd

"}}}

"{{{ netrw settings
" TODO D

let g:netrw_banner = 0
let g:netrw_menu = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_hide = 0
let g:netrw_keepdir = 1

" ???
let g:netrw_silent = 0
let g:netrw_fastbrowse = 0

" TODO D steering
let g:netrw_winsize = 30
" let g:netrw_winsize = "40%"

let g:netrw_ignorenetrc = 0 " (default for linux, cygwin)
" =1 If you have a <.netrc> file but it doesn't work and
"    you want it ignored, then set this variable as
"    shown. (default for Windows + cmd.exe)

" if this variable exists, then the "gx"
" map will not be available (see |netrw-gx|)
" let g:netrw_nogx = 1

" }}}

"{{{ netrw keymaps

" TODO B file openinng

noremap <silent> <Leader>x;x :Explore<CR>
noremap <Leader>x;X :Explore<Space>
noremap <silent> <Leader>x;t :Texplore<CR>
noremap <Leader>x;T :Texplore<Space>
noremap <silent> <Leader>x;h :Sexplore<CR>
noremap <Leader>x;H :Sexplore<Space>
noremap <silent> <Leader>x;v :Vexplore<CR>
noremap <Leader>x;V :Vexplore<Space>
noremap <silent> <Leader>x;n :Nexplore<CR>
noremap <Leader>x;N :Nexplore<Space>
noremap <silent> <Leader>x;p :Pexplore<CR>
noremap <Leader>x;P :Pexplore<Space>
noremap <silent> <Leader>x;r :Rexplore<CR>
noremap <Leader>x;R :Rexplore<Space>
noremap <silent> <Leader>x;l :Lexplore<CR>
noremap <Leader>x;L :Lexplore<Space>
noremap <silent> <Leader>x;h :Hexplore<CR>
noremap <Leader>x;H :Hexplore<Space>

"}}}
