" Other _
nmap _w :SudoWrite<CR>
nmap _r :redraw!<CR>
vmap _y y:call system('echo -n '.shellescape(@").' \| xclip -i -selection clipboard')<CR>
vmap _Y y:call system('echo -n '.shellescape(@").' \| xclip -i -selection primary')<CR>
" TODO more paste-like option
nmap _y :execute 'normal a'.system('xclip -o -selection clipboard')<CR>
nmap _Y :execute 'normal a'.system('xclip -o -selection clipboard')<CR>

nmap \e 0v$"cy:execute "!" . getreg("c")<CR>
nmap \d 0v$"cydd:execute "!" . getreg("c")<CR>
"nmap \w bvw"cy:execute "!" . getreg("c")<CR>
