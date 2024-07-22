"{{{ tmux integration
" I don't know if it is doable
" cd under vim
" probably not
"function CdUnder(path)
"    "execute "Tmux run-shell 'tmux send-keys :suspend C-M cd ".a:path." fg C-M'"
"    "execute "Tmux run-shell 'echo ".a:path." | \~/.vim/cd.sh'"
"    execute "Tmux run-shell '\~/.vim/cd.sh'"
"endfunction

let g:ret = 'C-m'
let g:default_tmux_socket = 'default'
if $TMUX_SOCKET == ""
    let g:tmux_socket = g:default_tmux_socket
else
    let g:tmux_socket = $TMUX_SOCKET
endif

function Tm(cmd)
    execute 'Tmux '.a:cmd
endfunction

function Ccd()
    let path = expand('%:h')
    execute 'cd' path
endfunction

function Setup2Panes()
    let path = expand('%:h')
    execute 'cd' path
    call Tm('split-window -h -c '.path)
    call Tm('select-pane -R')
endfunction

function MakeThirdVertical()
    let path = expand('%:h')
    execute 'cd' path
    call Tm('select-pane -R')
    call Tm('split-window -v -c '.path)
    call Tm('select-pane -R')
endfunction

function Setup3Panes()
    let path = expand('%:h')
    call Tm('split-window -h -c '.path)
    call Tm('split-window -v -c '.path)
    call Tm('select-pane -U')
    call Tm('select-pane -L')
    execute 'cd' path
endfunction

function CdPanesDangerous(clear)
    let path = expand('%:p:h')
    execute 'Tmux send-keys Escape :'
    execute 'Tmux setw synchronize-panes on'
    execute 'Tmux send-keys \"cd '.shellescape(path).'\"'
    execute 'Tmux setw synchronize-panes off'
    execute 'Tmux send-keys Escape :'
    execute 'Tmux setw synchronize-panes on'
    execute 'Tmux send-keys Enter C-l'
    execute 'Tmux setw synchronize-panes off'
endfunction

function NewWindow(home)
    call Tm('new-window')
    if a:home
        call Tm('send-keys cd ' . g:ret . ' C-l')
    endif
    call Tm('last-window')
endfunction

function ReplOnSecond()
    let program = input('Type name of program for repl: ')
    redraw
    call Tm('split-window -v '.program)
endfunction

function ReplOnThird()
    call Tm('select-pane -R')
    call Tm('select-pane -t {last}')
    let program = input("Type name of program for repl: ")
    redraw
    call Tm('split-window -v -t {last} '.program)
endfunction

nnoremap <Leader>tt :Tmux
nnoremap <silent> <Leader>tr :call ReplOnThird()<CR>
nnoremap <silent> <Leader>tR :call ReplOnSecond()<CR>
nnoremap <silent> <Leader>tn :call NewWindow(1)<CR>
nnoremap <silent> <Leader>tN :call NewWindow(0)<CR>

nnoremap <silent> <Leader>t2 :call Setup2Panes()<CR>
nnoremap <silent> <Leader>t3 :call Setup3Panes()<CR>
nnoremap <silent> <Leader>td :call CdPanesDangerous(1)<CR>
nnoremap <silent> <Leader>tD :call CdPanesDangerous(0)<CR>

nnoremap <silent> <Leader>tp :Tmux select-pane -m -t {last} <CR>
nnoremap <silent> <Leader>tP :Tmux select-pane -m<CR>

noremap <silent> <Leader>tv :Tmux send-keys -t {last} C-l<CR>
nnoremap <silent> <Leader>tV :call MakeThirdVertical()<CR>

nnoremap <silent> <Leader>tC :call Ccd()<CR>
nnoremap <Leader>tL :Tmux list-panes<CR>
nnoremap <silent> <Leader>tq :Tmux kill-pane -t {last} <CR>
"}}}

"{{{ vim-slime
let g:slime_target = 'tmux'
let g:slime_paste_file = tempname()
let g:slime_default_config = {
            \ 'socket_name':g:tmux_socket,
            \ 'target_pane':'{top-right}'
            \ }

let g:slime_dont_ask_default = 1
let g:slime_bracketed_paste = 1
let g:slime_no_mappings = 1
set shell=sh

function GetSlimePane()
    return get(b:, 'slime_config', g:slime_default_config)['target_pane']
endfunction

function SendKeys(keys)
    execute 'Tmux send-keys -t ' . GetSlimePane() . ' ' . a:keys
endfunction

function ProgNameSlime()
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
                \ }

                " this is tricky
                " ???
                " \ 'forth':'fth',

                " \ 'lua':'rlwrap luajit',
                " \ 'scheme':'gambit',
                " \ 'lisp':'rlwrap sbcl',
                " \ 'lisp':'rlwrap ecl',

                " ???
                " \ 'scheme':'rlwrap chez',
                " \ 'ocaml':'rlwrap ocaml',

    if has_key(langs, pname)
        " Only julia is almost ideal on it's own
        let pname = langs[pname]
    endif

    return pname . ' ' . g:ret
endfunction

autocmd BufEnter,VimEnter * let b:slime_config = slime_default_config

function SlimeOverride_EscapeText_sh(text)
  let l:lines = slime#common#lines(slime#common#tab_to_spaces(a:text))
  " return slime#common#unlines(l:lines)
  return l:lines
endfunction

" This is all one big shit
" hardcoding everywhere
" hard dependency on tmux, because slime isn't flexible enough
" documentation doesn't help

" Some sending

" noremap <silent> gss :SlimeSend<CR>
noremap <silent> gss :<c-u>execute 'SlimeSend1 '.GetVisualSelection()<CR>
noremap <silent> gsa :<c-u>execute 'SlimeSend0 "'.GetVisualSelection().'"'<CR>

xnoremap gsr <Plug>SlimeRegionSend
nnoremap gsp <Plug>SlimeParagraphSend
noremap gs: <Plug>SlimeConfig

nnoremap gsl <Plug>SlimeLineSend
nnoremap gsm <Plug>SlimeMotionSend

" Clear, exit
nnoremap <silent> gsc :call SendKeys("C-l")<CR>
nnoremap <silent> gsq :call SendKeys("C-c C-d")<CR>
nnoremap <silent> gse :call SendKeys("C-c")<CR>
nnoremap <silent> gs<cr> :call SendKeys("Enter")<CR>

" Launching program for currently edited langugage
nnoremap <silent> gsb :call SendKeys(ProgNameSlime())<CR>
nnoremap <silent> gsB :call SendKeys("rlwrap " . &filetype . ' ' . g:ret)<CR>
" nnoremap <silent> gsS :call SendKeys(&filetype . ' ' . g:ret)<CR>

" GDB
" Maybe in the future more debuggers will land here
" but this all is mostly useless

" line('.') - current line
" expand('%:t') - current filename (tail)
" gdb can't toggle breakpoints,
" so here should be kept list of them :(

" map gsP :call SendKeys('b '.line('.'))
"}}}

"{{{ tmux complete
let g:tmuxcomplete#trigger = 'omnifunc'
"}}}
