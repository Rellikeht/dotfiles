" Other ;
nmap ;w :SudoWrite<CR>
nmap ;r :redraw!<CR>
vmap ;y y:call Xcopy('clipboard')<CR>
vmap ;Y y:call Xcopy('primary')<CR>
" TODO do this better
nmap ;y :call Xpaste('clipboard')<CR>
nmap ;Y :call Xpaste('primary')<CR>

let mapleader = ','

" General purpose leader mappings
nmap <Leader><Space> :set hls!<CR>
map <Leader>qq :call Wmt()<CR>
map <Leader>;c :!clear<CR><CR>
map <Leader>;l :!ls<CR>
map <Leader>;e :Ex<CR>
map <Leader>;r :!%<CR>

" TODO B running command under cursor
" TODO C running command in given register (???)
" TODO C netrw keys
" TODO C https://youtu.be/w7i4amO_zaE?t=1464
" TODO D editing file in register

" Run command in register c
" map <Leader>;E 'cyy:execute '!' . getreg('c')<CR>
" map <Leader>;D 'cyydd:execute '!' . getreg('c')<CR>
"nmap <Leader>W bvw"cy:execute "!" . getreg('c')<CR>
