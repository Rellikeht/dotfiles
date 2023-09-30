" ============================================================
" Main
" ============================================================

" I don't know if it is doable
" cd under vim
" probably not
"function CdUnder(path)
"    "execute "Tmux run-shell 'tmux send-keys :suspend C-M cd ".a:path." fg C-M'"
"    "execute "Tmux run-shell 'echo ".a:path." | \~/.vim/cd.sh'"
"    execute "Tmux run-shell '\~/.vim/cd.sh'"
"endfunction

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
        call Tm('send-keys cd C-m C-l')
    endif
	call Tm('last-window')
endfunction

function ReplOnSecond()
    let program = input("Type name of program for repl: ")
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

map <Leader>tt :Tmux
map <Leader>tr :call ReplOnThird()<CR>
map <Leader>tR :call ReplOnSecond()<CR>
map <Leader>tn :call NewWindow(1)<CR>
map <Leader>tN :call NewWindow(0)<CR>

map <Leader>t2 :call Setup2Panes()<CR>
map <Leader>t3 :call Setup3Panes()<CR>
map <Leader>td :call CdPanesDangerous(1)<CR>
map <Leader>tD :call CdPanesDangerous(0)<CR>

map <Leader>tp :Tmux select-pane -m -t {last} <CR>
map <Leader>tP :Tmux select-pane -m<CR>

map <Leader>tv :Tmux send-keys -t {last} C-l<CR>
map <Leader>tV :call MakeThirdVertical()<CR>

" map <Leader>t :call Ccd()<CR>
map <Leader>tL :Tmux list-panes <CR>
map <Leader>tq :Tmux kill-pane -t {last} <CR>

" ============================================================
" vim-slime
" ============================================================

let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_default_config =
            \ {"socket_name":"default", "target_pane":"{top-right}"}
let g:slime_dont_ask_default = 1
let g:slime_bracketed_paste = 1
let g:slime_no_mappings = 1

function CleanSlime()
    let pane = get(b:, "slime_config", g:slime_default_config)["target_pane"]
    execute "Tmux send-keys -t " . pane . " C-l"
endfunction

map gsr <Plug>SlimeRegionSend
map gsp <Plug>SlimeParagraphSend
map gs: <Plug>SlimeConfig
map gss :SlimeSend<CR>
map gsc :call CleanSlime()<CR>
map gsl <Plug>SlimeLineSend
