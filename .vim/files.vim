"{{{ TODO B is that enough - diff

function DiffGet(pane)
  execute 'diffget' a:pane
  diffupdate
endfunction

function DiffPut(pane)
  execute 'diffget' a:pane
  diffupdate
endfunction

noremap <silent> <Space>hdp :<C-u>diffput<CR>
noremap <silent> <Space>hdg :<C-u>diffget<CR>
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

"}}}

"{{{ nops

noremap <Space>f <Nop>
noremap <Space><Space>f <Nop>
noremap <Space>b <Nop>
noremap <Space>/ <Nop>
noremap <Space>? <Nop>

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

"{{{ grep

"{{{ helpers

function Vgcount()
  if v:count == 0
    return ''
  endif
  return v:count
endfunction

function Gescape(s)
  return escape(a:s, "\"")
endfunction

function Vescape(s)
  return escape(a:s, "/")
endfunction

" TODO B async
" TODO C count
" silent grep
function! Grep(...)
  let cmd = join([g:grepprg] + [expandcmd(join(a:000, ' '))], ' ')
  echo cmd
  return system(cmd)
endfunction

" commands for it
command! -nargs=+ -complete=file Grep cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file Lgrep lgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file Sgrep
      \ let grepres = Grep(<f-args>)
      \ | if g:qfloc
      \ | exe 'lgetexpr grepres'
      \ | else
      \ | exe 'cgetexpr grepres'
      \ | endif

command! -nargs=+ -complete=file Wgrep
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

"}}}

"{{{ external providers
" There are recursive and nonrecursive greps
" ripgrep nonrecursive is `--max-depth=0`
" vimgrep is nonrecursive but `*` and similar
" are expanded without directories
" for recursivity it needs `**`
" paths need some **/* and other stuff
" and recursive greps rather
" also hidden directories may be hard
" and wildcards are fucked when used shell is simple
" (/usr/bin/env sh)

" TODO B more
let s:arf = '%f:%l:%c:%m'
let s:grf = '%f:%l:%m,%f:%l%m,%f\ \ %l%m'
let g:grepprgs = 
      \ [
      \ [ 'grep\ -EIn', s:grf ],
      \ [ 'grep\ -EIin', s:grf ],
      \ [ 'rg\ --vimgrep\ -S\ --hidden', s:arf ],
      \ [ 'rg\ --vimgrep\ -S\ --unrestricted', s:arf ],
      \ [ 'rg\ --vimgrep\ -S', s:arf ],
      \ [ 'ag\ --vimgrep\ -S\ --unrestricted', s:arf ],
      \ [ 'ag\ --vimgrep\ -S\ --hidden', s:arf ],
      \ [ 'ag\ --vimgrep\ -S', s:arf ],
      \ ]

" https://vi.stackexchange.com/questions/35139/custom-arguments-to-user-command
function s:Grepprgs(current_arg, command_line, cursor_position)
  let l = len(a:current_arg) - 1
  let prgs = deepcopy(g:grepprgs)
  call map(prgs, {_, v -> v[0]})
  if l >= 0
    call filter(
          \ prgs,
          \ {_, v -> v[0][:l] ==# a:current_arg})
    echom prgs
  endif
  return prgs
endfunction

function SetGrepprg(idx)
  if a:idx < 0
    throw "Index too low"
    return 1
  elseif a:idx >= len(g:grepprgs)
    throw "Index too high"
    return 1
  endif
  let p = g:grepprgs[a:idx]
  exe 'let g:grepprg = "'.p[0].'"'
  exe 'set grepprg='.p[0].'\ $*'
  if len(p) == 2
    exe 'set grepformat='.p[1]
  endif
  return 0
endfunction

function s:SetGrepprg(name)
  let i = 0
  for e in g:grepprgs
    if e[0] == a:name
      call SetGrepprg(i)
      break
    endif
    let i = i+1
  endfor
  return 0
endfunction

call SetGrepprg(0)

command! -nargs=1 -complete=customlist,s:Grepprgs ExtGrep 
      \ call s:SetGrepprg(<f-args>)

nnoremap <Space>s/ :<C-u>ExtGrep<Space>
vnoremap <Space>s/ :<C-u>ExtGrep  \|norm gv
      \ <C-Left><C-Left><Left>

"}}}

"{{{ TODO B refactor - vimgrep

"{{{ helpers

" function s:Gmap

"}}}

"{{{ simple commands

" TODO C filter .sw[po]

" noremap <expr> <Space>vc g:qfloc ?
"       \ ':<C-u>lvimgrep<Space>'
"       \ : ':<C-u>vimgrep<Space>'
" noremap <expr> <Space>vC g:qfloc ?
"       \ ':<C-u>lvimgrep!<Space>'
"       \ : ':<C-u>vimgrep!<Space>'

" nnoremap <expr> <Space>vo g:qfloc ?
"       \ ':<C-u>lvimgrep //jg<C-left><Right>'
"       \ : ':<C-u>vimgrep //jg<C-left><Right>'
" nnoremap <expr> <Space>vO g:qfloc ?
"       \ ':<C-u>lvimgrep //fgj<C-left><Right>'
"       \ : ':<C-u>vimgrep //fgj<C-left><Right>'

noremap <expr> <Space>vc g:qfloc ?
      \ ':<C-u>'.Vgcount().'lvimgrep<Space>'
      \ : ':<C-u>'.Vgcount().'vimgrep<Space>'
noremap <expr> <Space>vC g:qfloc ?
      \ ':<C-u>'.Vgcount().'lvimgrep!<Space>'
      \ : ':<C-u>'.Vgcount().'vimgrep!<Space>'

nnoremap <expr> <Space>vf g:qfloc ?
      \ ':<C-u>'.Vgcount().'lvimgrep //jg<C-left><Right>'
      \ : ':<C-u>'.Vgcount().'vimgrep //jg<C-left><Right>'
nnoremap <expr> <Space>vF g:qfloc ?
      \ ':<C-u>'.Vgcount().'lvimgrep //fgj<C-left><Right>'
      \ : ':<C-u>'.Vgcount().'vimgrep //fgj<C-left><Right>'

"}}}

"{{{ cur file and arglist

nnoremap <expr> <Space>vf g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Expand('<cword>').'/gj %<CR>'
      \ : ':<C-u>vimgrep /'.Expand('<cword>').'/gj %<CR>'
vnoremap <expr> <Space>vf g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj %<CR>'
      \ : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj %<CR>'
nnoremap <expr> <Space>vf g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Expand('<cword>').'/fgj % <CR>'
      \ : ':<C-u>vimgrep /'.Expand('<cword>').'/fgj % <CR>'
vnoremap <expr> <Space>vF g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/fgj %<CR>'
      \ : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/fgj %<CR>'
noremap <expr> <Space>v<Space>f g:qfloc ?
      \ ':<C-u>lvimgrep //gj %<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //gj %<C-Left><C-Left><Right>'
noremap <expr> <Space>v<Space>F g:qfloc ?
      \ ':<C-u>lvimgrep //fgj %<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //fgj %<C-Left><C-Left><Right>'

nnoremap <expr> <Space>vl g:qfloc ? 
      \ ':<C-u>lvimgrep /'.expand('<cword>').'/gj ## <CR>'
      \ : ':<C-u>vimgrep /'.expand('<cword>').'/gj ## <CR>'
vnoremap <expr> <Space>vl g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj ##<CR>'
      \ : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj ##<CR>'
nnoremap <expr> <Space>vL g:qfloc ? 
      \ ':<C-u>lvimgrep /'.expand('<cword>').'/fgj ## <CR>'
      \ : ':<C-u>vimgrep /'.expand('<cword>').'/fgj ## <CR>'
vnoremap <expr> <Space>vL g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/fgj ##<CR>'
      \ : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/fgj ##<CR>'
noremap <expr> <Space>v<Space>l g:qfloc ? 
      \ ':<C-u>lvimgrep //gj ##<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //gj ##<C-Left><C-Left><Right>'
noremap <expr> <Space>v<Space>L g:qfloc ? 
      \ ':<C-u>lvimgrep //fgj ##<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //fgj ##<C-Left><C-Left><Right>'

"}}}

"{{{ files in curdir

nnoremap <expr> <Space>va g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Expand('<cword>').'/gj * .*<CR>'
      \ : ':<C-u>vimgrep /'.Expand('<cword>').'/gj * .*<CR>'
vnoremap <expr> <Space>va g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj * .*<CR>'
      \ : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj * .*<CR>'
nnoremap <expr> <Space>vA g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Expand('<cword>').'/fgj * .* <CR>'
      \ : ':<C-u>vimgrep /'.Expand('<cword>').'/fgj * .* <CR>'
vnoremap <expr> <Space>vA g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/fgj * .*<CR>'
      \ : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/fgj * .*<CR>'

nnoremap <expr> <Space>v<Space>a g:qfloc ? 
      \ ':<C-u>lvimgrep //gj * .*'.
      \ '<C-Left><C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //gj * .*'.
      \ '<C-Left><C-Left><C-Left><Right>'
nnoremap <expr> <Space>v<Space>A g:qfloc ? 
      \ ':<C-u>lvimgrep //fgj * .*'.
      \ '<C-Left><C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //fgj * .*'.
      \ '<C-Left><C-Left><C-Left><Right>'

nnoremap <expr> <Space>vh g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Expand('<cword>').'/gj * <CR>'
      \ : ':<C-u>vimgrep /'.Expand('<cword>').'/gj * <CR>'
vnoremap <expr> <Space>vh g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj *<CR>'
      \ : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj *<CR>'
nnoremap <expr> <Space>vH g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Expand('<cword>').'/fgj * <CR>'
      \ : ':<C-u>vimgrep /'.Expand('<cword>').'/fgj * <CR>'
vnoremap <expr> <Space>vH g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/fgj *<CR>'
      \ : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/fgj *<CR>'

nnoremap <expr> <Space>v<Space>h g:qfloc ? 
      \ ':<C-u>lvimgrep //gj *'.
      \ '<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //gj *'.
      \ '<C-Left><C-Left><Right>'
nnoremap <expr> <Space>v<Space>H g:qfloc ? 
      \ ':<C-u>lvimgrep //fgj *'.
      \ '<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //fgj *'.
      \ '<C-Left><C-Left><Right>'

"}}}

"{{{ recursive

nnoremap <expr> <Space>v<Space>2 g:qfloc ? 
      \ ':<C-u>lvimgrep //gj * .* {*,.*}/{*,.*}<C-Left><C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //gj * .* {*,.*}/{*,.*}<C-Left><C-Left><C-Left><Right>'
nnoremap <expr> <Space>v;2 g:qfloc ? 
      \ ':<C-u>lvimgrep //fgj * .* {*,.*}/{*,.*}<C-Left><C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //fgj * .* {*,.*}/{*,.*}<C-Left><C-Left><C-Left><Right>'

nnoremap <expr> <Space>v<Space>3 g:qfloc ? 
      \ ':<C-u>lvimgrep //gj * .* {*,.*}/{*,.*} {*,.*}/{*,.*}/{*,.*}'.
      \ '<C-Left><C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //gj * .* {*,.*}/{*,.*} {*,.*}/{*,.*}/{*,.*}'.
      \ '<C-Left><C-Left><C-Left><Right>'
nnoremap <expr> <Space>v;3 g:qfloc ? 
      \ ':<C-u>lvimgrep //fgj * .* {*,.*}/{*,.*} {*,.*}/{*,.*}/{*,.*}'.
      \ '<C-Left><C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //fgj * .* {*,.*}/{*,.*} {*,.*}/{*,.*}/{*,.*}'.
      \ '<C-Left><C-Left><C-Left><Right>'

"}}}

"}}}

" TODO A grep recursive (<Space>r ?)

"{{{ grep

"{{{ simple

noremap <expr> <Space>s- g:qfloc ?
      \ ':<C-u>Lfilter /^[^\|][^\|] /<CR>'
      \ : ':<C-u>Cfilter /^[^\|][^\|] /<CR>'

noremap <Space>sj :<C-u>Sgrep<Space>
noremap <Space>sJ :<C-u>Sgrep!<Space>

"}}}

"{{{ current file and args

noremap <expr> <Space>s<Space>f
      \ ':<C-u>Sgrep  '.Expand('%').
      \ '<Home><C-Right><Right>'
nnoremap <expr> <Space>sf
      \ ':<C-u>Sgrep '.expand('<cword>').' '.Expand('%').'<CR>'
vnoremap <expr> <Space>sf
      \ ":<C-u>exe 'Sgrep " . '"' . "'.GetVisualSelection().'".
      \ '" '.Expand('%')."'<CR>"

noremap <expr> <Space>s<Space>l
      \ ':<C-u>Sgrep  '.Exfiles(argv()).
      \ '<Home><C-Right><Right>'
nnoremap <expr> <Space>sl
      \ ':<C-u>Sgrep '.expand('<cword>').' '.Exfiles(argv()).'<CR>'
vnoremap <expr> <Space>sl
      \ ":<C-u>exe 'Sgrep " . '"' . "'.GetVisualSelection().'".
      \ '" '.Exfiles(argv())."'<CR>"

"}}}

"{{{ files in curdir

noremap <expr> <Space>s<Space>a ':<C-u>Sgrep  * .*'.
      \ '<C-Left><C-Left><Left>'
nnoremap <expr> <Space>sa ':<C-u>Sgrep '.expand('<cword>').' * .*<CR>'
vnoremap <expr> <Space>sa
      \ ":<C-u>exe 'Sgrep " . '"' . "'.GetVisualSelection().'".
      \ '" * .*'."'<CR>"

noremap <expr> <Space>s<Space>h ':<C-u>Sgrep  *<Left><Left>'
nnoremap <expr> <Space>sh ':<C-u>Sgrep '.expand('<cword>').' *<CR>'
vnoremap <expr> <Space>sh
      \ ":<C-u>exe 'Sgrep " . '"' . "'.GetVisualSelection().'".
      \ '" *'."'<CR>"

"}}}

"{{{ TODO A recursive

"}}}

"{{{ old

" nnoremap <expr> <Space>sc g:qfloc ? 
"       \ ':<C-u>lgrep <cword> . <CR>'
"       \ : ':<C-u>grep <cword> . <CR>'
" vnoremap <expr> <Space>sc g:qfloc ? 
"       \ ":<C-u>exe 'lgrep '.GetVisualSelection().' .'<CR>"
"       \ : ":<C-u>exe 'grep '.GetVisualSelection().' .'<CR>"

" nnoremap <expr> <Space>sla g:qfloc ? 
"       \ ':<C-u>lgrep '.Expand('<cword>').' * <CR>'
"       \ : ':<C-u>grep '.Expand('<cword>').' * <CR>'
" vnoremap <expr> <Space>sla g:qfloc ? 
"       \ ':<C-u>lgrep '.GetVisualSelection().' *<CR>'
"       \ : ':<C-u>grep '.GetVisualSelection().' *<CR>'
" nnoremap <expr> <Space>slA g:qfloc ? 
"       \ ':<C-u>lgrep '.Expand('<cword>').' * <CR>'
"       \ : ':<C-u>grep '.Expand('<cword>').' * <CR>'
" vnoremap <expr> <Space>slA g:qfloc ? 
"       \ ':<C-u>lgrep '.GetVisualSelection().' *<CR>'
"       \ : ':<C-u>grep '.GetVisualSelection().' *<CR>'

" nnoremap <expr> <Space>slr g:qfloc ? 
"       \ ':<C-u>lgrep '.Expand('<cword>').' **/* <CR>'
"       \ : ':<C-u>grep '.Expand('<cword>').' **/* <CR>'
" vnoremap <expr> <Space>slr g:qfloc ? 
"       \ ':<C-u>lgrep '.GetVisualSelection().' **/*<CR>'
"       \ : ':<C-u>grep '.GetVisualSelection().' **/*<CR>'
" nnoremap <expr> <Space>slR g:qfloc ? 
"       \ ':<C-u>lgrep '.Expand('<cword>').' **/* <CR>'
"       \ : ':<C-u>grep '.Expand('<cword>').' **/* <CR>'
" vnoremap <expr> <Space>slR g:qfloc ? 
"       \ ':<C-u>lgrep '.GetVisualSelection().' **/*<CR>'
"       \ : ':<C-u>grep '.GetVisualSelection().' **/*<CR>'

" nnoremap <expr> <Space>sl<Space>a g:qfloc ? 
"       \ ':<C-u>lgrep  *<C-Left><Left>'
"       \ : ':<C-u>grep  *<C-Left><Left>'
" nnoremap <expr> <Space>sl<Space>r g:qfloc ? 
"       \ ':<C-u>lgrep  **/*<C-Left><Left>'
"       \ : ':<C-u>grep  **/*<C-Left><Left>'

" nnoremap <expr> <Space>sl<Space>l g:qfloc ? 
"             \ ':<C-u>lgrep  ##<C-Left><Left>'
"             \ : ':<C-u>grep  ##<C-Left><Left>'

"}}}

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
