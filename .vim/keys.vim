" Other <Tab>
nmap <Tab>w :SudoWrite<CR>
nmap <Tab>r :redraw!<CR>
vmap <Tab>y y:call Xcopy('clipboard')<CR>
vmap <Tab>Y y:call Xcopy('primary')<CR>
" TODO do this better
nmap <Tab>y :call Xpaste('clipboard')<CR>
nmap <Tab>Y :call Xpaste('primary')<CR>

let mapleader = ','

" General purpose leader mappings
nmap <Leader><Space> :set hls!<CR>
map <Leader>qq :call Wmt()<CR>
map <Leader>;C :!clear<CR><CR>
map <Leader>;l :!ls<CR>
map <Leader>;e :Ex<CR>
map <Leader>;r :!%<CR>
map <Leader>;m :make<CR>
map <Leader>;M :make
map <Leader>qm :call ToggleManProg()<CR>
map <Leader>qM :set makeprg=make<CR>

map <Leader>qf :let b:buffmt=!b:buffmt<CR>
map <Leader>qF :let g:buffmt=!g:buffmt<CR>
map <Leader>q1 :echo b:buffmt<CR>

map <Leader>qc :let b:bufcomp=!b:bufcomp<CR>
map <Leader>qC :let g:bufcomp=!g:bufcomp<CR>
map <Leader>q2 :echo b:bufcomp<CR>

" TODO A wc on buffer
"map <Leader>;c

" TODO B running command under cursor
" TODO C running command in given register (???)
" TODO C netrw keys
" TODO C https://youtu.be/w7i4amO_zaE?t=1464
" TODO D editing file in register

" Run command in register c
" map <Leader>;E 'cyy:execute '!' . getreg('c')<CR>
" map <Leader>;D 'cyydd:execute '!' . getreg('c')<CR>
"nmap <Leader>W bvw"cy:execute "!" . getreg('c')<CR>
