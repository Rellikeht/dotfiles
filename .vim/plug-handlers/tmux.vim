" {{{ tmux variables

let g:ret = 'Enter' "'C-m'
let g:default_tmux_socket = 'default'
if $TMUX_SOCKET == ""
  let g:tmux_socket = g:default_tmux_socket
else
  let g:tmux_socket = $TMUX_SOCKET
endif

" }}}

" {{{ tmux functions

function s:Tm(cmd)
  execute 'Tmux '.a:cmd
endfunction

function s:Ccd()
  let path = Expand('%:h')
  execute 'cd' path
endfunction

function s:Setup2Panes()
  let path = Expand('%:h')
  execute 'cd' path
  call s:Tm('split-window -h -c '.path)
  call s:Tm('select-pane -R')
endfunction

function s:MakeThirdVertical()
  let path = Expand('%:h')
  execute 'cd' path
  call s:Tm('select-pane -R')
  call s:Tm('split-window -v -c '.path)
  call s:Tm('select-pane -R')
endfunction

function s:Setup3Panes()
  let path = Expand('%:h')
  call s:Tm('split-window -h -c '.path)
  call s:Tm('split-window -v -c '.path)
  call s:Tm('select-pane -U')
  call s:Tm('select-pane -L')
  execute 'cd' path
endfunction

function s:CdPanes()
  let path = Expand('%:p:h')
  " And this all is simply because this shit can't simply send keys
  " and has to open command line window and fuck codes
  " FUCK
  execute 'Tmux send-keys Escape Q'
  execute '!tmux-cdall '.shellescape(path)
  execute 'Tmux send-keys Enter visual Enter'
endfunction

function s:NewWindow(home)
  call s:Tm('new-window')
  if a:home
    call s:Tm('send-keys cd ' . g:ret . ' C-l')
  endif
  call s:Tm('last-window')
endfunction

function s:ReplOnSecond()
  let program = input('Type name of program for repl: ')
  redraw
  call s:Tm('split-window -v '.program)
endfunction

function s:ReplOnThird()
  call s:Tm('select-pane -R')
  call s:Tm('select-pane -t {last}')
  let program = input("Type name of program for repl: ")
  redraw
  call s:Tm('split-window -v -t {last} '.program)
endfunction

function s:CopyPath()
  exe 'Tmux set-buffer -b vimpath '.shellescape(expand('%:p:h'))
endfunction

" }}}

" {{{ tmux mappings

nnoremap <Leader>tt :<C-u>Tmux
noremap <silent> <Leader>tr :<C-u>call <SID>ReplOnThird()<CR>
noremap <silent> <Leader>tR :<C-u>call <SID>ReplOnSecond()<CR>
noremap <silent> <Leader>tn :<C-u>call <SID>NewWindow(1)<CR>
noremap <silent> <Leader>tN :<C-u>call <SID>NewWindow(0)<CR>

nnoremap <silent> <Leader>t2 :<C-u>call <SID>Setup2Panes()<CR>
vnoremap <silent> <Leader>t2 :<C-u>call <SID>Setup2Panes()\|norm gv<CR>
nnoremap <silent> <Leader>t3 :<C-u>call <SID>Setup3Panes()<CR>
vnoremap <silent> <Leader>t3 :<C-u>call <SID>Setup3Panes()\|norm gv<CR>
nnoremap <silent> <Leader>tc :<C-u>call <SID>CopyPath()<CR>
vnoremap <silent> <Leader>tc :<C-u>call <SID>CopyPath()\|norm gv<CR>
nnoremap <silent> <Leader>td :<C-u>call <SID>CdPanes()<CR>

nnoremap <silent> <Leader>tp :<C-u>Tmux select-pane -m -t {last} <CR>
nnoremap <silent> <Leader>tP :<C-u>Tmux select-pane -m<CR>

noremap <silent> <Leader>tv :<C-u>Tmux send-keys -t {last} C-l<CR>
nnoremap <silent> <Leader>tV :<C-u>call <SID>MakeThirdVertical()<CR>

nnoremap <silent> <Leader>tC :<C-u>call <SID>Ccd()<CR>
nnoremap <Leader>tL :<C-u>Tmux list-panes<CR>
nnoremap <silent> <Leader>tq :<C-u>Tmux kill-pane -t {last} <CR>

" }}}

" {{{ vim-slime

" {{{ setup

let g:slime_target = 'tmux'
let g:slime_paste_file = tempname()
let g:slime_default_config = {
      \ 'socket_name':g:tmux_socket,
      \ 'target_pane':'{top-right}'
      \ }

let g:slime_dont_ask_default = 1
let g:slime_bracketed_paste = 1
let g:slime_no_mappings = 1

autocmd BufEnter,VimEnter *
      \ let b:slime_config = slime_default_config

" }}}

" {{{ functions

function s:GetSlimePane()
  return get(b:, 'slime_config', g:slime_default_config)['target_pane']
endfunction

function s:SendKeys(keys)
  execute 'Tmux send-keys -t '.s:GetSlimePane().' '.a:keys
endfunction

function s:ProgNameSlime()
  let pname = &filetype
  let langs = {
        \ 'shell':'rlwrap bash',
        \ 'python':'bpython',
        \ 'tcl':'rlwrap tclsh',
        \ 'lisp':'clisp',
        \ 'scheme':'guile',
        \ 'r':'R',
        \ 'ocaml':'utop',
        \ 'haskell':'ghci',
        \ 'nim':'rlwrap nim secret',
        \ 'forth':'gforth',
        \ 'nix':'nix repl',
        \ }

  if has_key(langs, pname)
    " Only julia is almost ideal on it's own
    let pname = langs[pname]
  endif

  return "'".pname."' ".g:ret
endfunction

function s:SlimeOverride_EscapeText_sh(text)
  let l:lines = slime#common#lines(slime#common#tab_to_spaces(a:text))
  " return slime#common#unlines(l:lines)
  return l:lines
endfunction

" }}}

" {{{ maps

nnoremap gsl <Plug>SlimeLineSend
nnoremap gz <Plug>SlimeMotionSend

noremap <silent> gss :SlimeSend<CR>
vnoremap <silent> gz :<c-u>execute 'SlimeSend1 '.GetVisualSelection()<CR>
vnoremap <silent> gZ :<c-u>execute 'SlimeSend0 "'.GetVisualSelection().'"'<CR>

xnoremap gsr <Plug>SlimeRegionSend
nnoremap gsp <Plug>SlimeParagraphSend
noremap gs: <Plug>SlimeConfig

" Clear, exit
nnoremap <silent> gsc :call <SID>SendKeys("C-l")<CR>
nnoremap <silent> gsq :call <SID>SendKeys("C-c C-d")<CR>
nnoremap <silent> gse :call <SID>SendKeys("C-c")<CR>
nnoremap <silent> gs<cr> :call <SID>SendKeys("Enter")<CR>

" Launching program for currently edited langugage
nnoremap <silent> gsb :call <SID>SendKeys(<SID>ProgNameSlime())<CR>
nnoremap <silent> gsB :call <SID>SendKeys("rlwrap\ " . &filetype . ' ' . g:ret)<CR>

nnoremap <silent> gsn :call <SID>SendKeys('z\ -t\ . Enter')<CR>

" }}}

" {{{ todos

" GDB
" Maybe in the future more debuggers will land here
" but this all is mostly useless

" gdb can't toggle breakpoints,
" so here should be kept list of them :(

" map gsP :call SendKeys('b '.line('.'))

" }}}

" }}}

" {{{ tmux complete

let g:tmuxcomplete#trigger = ''

" Because that wasn't suppled by plugin creator
function TmuxComplete()
  let l:start = tmuxcomplete#complete(1, '')
  let l:base = getline('.')[l:start:col('.')-1]
  call complete(l:start+1, tmuxcomplete#complete(0, l:base))
  return ''
endfunction

inoremap <expr> <C-x><C-m> '<C-r>=TmuxComplete()<CR>'
imap <C-x>m <C-x><C-m>

" }}}
