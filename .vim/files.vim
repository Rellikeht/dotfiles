" session {{{ 

nnoremap ,usm :<C-u>mksession<CR>
xnoremap ,usm :<C-u>mksession\|norm gv<CR>
nnoremap ,usM :<C-u>mksession<Space>
xnoremap ,usM :<C-u>mksession  \|norm gv<C-Left><C-Left><Left>

" }}} 

" TODO B is that enough - diff {{{ 

" helpers {{{ 

function DiffGet(pane)
  execute 'diffget' a:pane
  diffupdate
endfunction

function DiffPut(pane)
  execute 'diffget' a:pane
  diffupdate
endfunction

" }}} 

" settings {{{ 

set diffopt=internal,filler,closeoff,algorithm:patience,context:8

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
xnoremap <silent> <Space>hqf
      \ :<C-u>call <SID>ToggleFiller()\|norm gv<CR>

" }}} 

" maps {{{ 
" TODO do I need x

nnoremap <silent> <Space>hdp :<C-u>diffput<CR>
nnoremap <silent> <Space>hdg :<C-u>diffget<CR>
nnoremap <silent> <Space>hd<Space>p :<C-u>diffput<Space>
nnoremap <silent> <Space>hd<Space>g :<C-u>diffget<Space>
nnoremap <silent> <Space>hdu :<C-u>diffupdate<CR>
xnoremap <silent> <Space>hdp :<C-u>diffput<CR>
xnoremap <silent> <Space>hdg :<C-u>diffget<CR>
xnoremap <silent> <Space>hd<Space>p :<C-u>diffput<Space>
xnoremap <silent> <Space>hd<Space>g :<C-u>diffget<Space>
xnoremap <silent> <Space>hdu :<C-u>diffupdate\|norm gv<CR>

nnoremap <silent> <Space>hg0 :<C-u>call DiffGet('//0')<CR>
nnoremap <silent> <Space>hg1 :<C-u>call DiffGet('//1')<CR>
nnoremap <silent> <Space>hg2 :<C-u>call DiffGet('//2')<CR>
nnoremap <silent> <Space>hg3 :<C-u>call DiffGet('//3')<CR>
xnoremap <silent> <Space>hg0 :<C-u>call DiffGet('//0')<CR>
xnoremap <silent> <Space>hg1 :<C-u>call DiffGet('//1')<CR>
xnoremap <silent> <Space>hg2 :<C-u>call DiffGet('//2')<CR>
xnoremap <silent> <Space>hg3 :<C-u>call DiffGet('//3')<CR>

nnoremap <silent> <Space>hp0 :<C-u>call DiffPut('//0')<CR>
nnoremap <silent> <Space>hp1 :<C-u>call DiffPut('//1')<CR>
nnoremap <silent> <Space>hp2 :<C-u>call DiffPut('//2')<CR>
nnoremap <silent> <Space>hp3 :<C-u>call DiffPut('//3')<CR>
xnoremap <silent> <Space>hp0 :<C-u>call DiffPut('//0')<CR>
xnoremap <silent> <Space>hp1 :<C-u>call DiffPut('//1')<CR>
xnoremap <silent> <Space>hp2 :<C-u>call DiffPut('//2')<CR>
xnoremap <silent> <Space>hp3 :<C-u>call DiffPut('//3')<CR>

nnoremap <silent> <Space>hpf :<C-u>call DiffPut(Expand('%:p'))<CR>
nnoremap <silent> <Space>hp;f :<C-u>call DiffPut(Expand('%:t'))<CR>
nnoremap <silent> <Space>hgf :<C-u>call DiffGet(Expand('%:p'))<CR>
nnoremap <silent> <Space>hg;f :<C-u>call DiffGet(Expand('%:t'))<CR>
xnoremap <silent> <Space>hpf :<C-u>call DiffPut(Expand('%:p'))<CR>
xnoremap <silent> <Space>hp;f :<C-u>call DiffPut(Expand('%:t'))<CR>
xnoremap <silent> <Space>hgf :<C-u>call DiffGet(Expand('%:p'))<CR>
xnoremap <silent> <Space>hg;f :<C-u>call DiffGet(Expand('%:t'))<CR>

nnoremap <silent> <Space>hoo :<C-u>diffoff<CR>
nnoremap <silent> <Space>ho<Space>t :<C-u>diffthis<Space>
nnoremap <silent> <Space>hot :<C-u>diffthis<CR>
xnoremap <silent> <Space>hoo :<C-u>diffoff\|norm gv<CR>
xnoremap <silent> <Space>hot :<C-u>diffthis\|norm gv<CR>
xnoremap <silent> <Space>ho<Space>t :<C-u>diffthis<Space>

" }}} 

" }}} 

" nops {{{ 

noremap <Space>f <Nop>
noremap <Space>g <Nop>
noremap <Space><Space>f <Nop>
noremap <Space><Space>g <Nop>
noremap <Space>b <Nop>
noremap <Space>/ <Nop>
noremap <Space>? <Nop>
noremap <Space>v <Nop>
noremap <Space>s <Nop>

" }}} 

" TODO B history {{{ 
" :later and :earlier

" }}} 

" drag and drop {{{ 

" TODO C more ?

" Pushing to dragon
nnoremap <silent> <Leader>xy
      \ :<C-u>exe '!dragon --on-top --and-exit '.
      \ Expand("%").' 2>/dev/null &'<CR>
      \ :redraw!<CR>

nnoremap <silent> <Leader>xY
      \ :<C-u>exe '!dragon --on-top --and-exit '.
      \ Expand("<cfile>").' 2>/dev/null &'<CR>
      \ :redraw!<CR>

" Editing from dragon
nnoremap <Leader>x<space>o
      \ :<C-u>exe 'argedit '.
      \ system('dragon --on-top --target --and-exit '.
      \ '2>/dev/null')<CR>
      \ :redraw<CR>
nnoremap <C-w><Leader>xo
      \ :<C-u>exe 'tabedit '.
      \ system('dragon --on-top --target --and-exit '.
      \ '2>/dev/null')<CR>
      \ :redraw<CR>
nnoremap <Leader>xo
      \ :<C-u>exe 'edit '.
      \ system('dragon --on-top --target --and-exit '.
      \ '2>/dev/null')<CR>
      \ :redraw<CR>

" }}} 

" netrw settings {{{ 
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

" netrw keymaps {{{ 

" TODO B file openinng

nnoremap <silent> <Leader>x;x :Explore<CR>
nnoremap <Leader>x;X :Explore<Space>
nnoremap <silent> <Leader>x;t :Texplore<CR>
nnoremap <Leader>x;T :Texplore<Space>
nnoremap <silent> <Leader>x;h :Sexplore<CR>
nnoremap <Leader>x;H :Sexplore<Space>
nnoremap <silent> <Leader>x;v :Vexplore<CR>
nnoremap <Leader>x;V :Vexplore<Space>
nnoremap <silent> <Leader>x;n :Nexplore<CR>
nnoremap <Leader>x;N :Nexplore<Space>
nnoremap <silent> <Leader>x;p :Pexplore<CR>
nnoremap <Leader>x;P :Pexplore<Space>
nnoremap <silent> <Leader>x;r :Rexplore<CR>
nnoremap <Leader>x;R :Rexplore<Space>
nnoremap <silent> <Leader>x;l :Lexplore<CR>
nnoremap <Leader>x;L :Lexplore<Space>
nnoremap <silent> <Leader>x;h :Hexplore<CR>
nnoremap <Leader>x;H :Hexplore<Space>

" }}} 
