function Xcopy(name)
    call system('echo -n '.shellescape(@").' \| xclip -i -selection '.a:name)
endfunction

function Xpaste(name)
    execute 'normal a'.system('xclip -o -selection '.a:name)
endfunction

" Other _
nmap _w :SudoWrite<CR>
nmap _r :redraw!<CR>
vmap _y y:call Xcopy('clipboard')<CR>
vmap _Y y:call Xcopy('primary')<CR>
" TODO more paste-like option
nmap _y :call Xpaste('clipboard')<CR>
nmap _Y :call Xpaste('primary')<CR>

nmap \e "cyy:execute "!" . getreg("c")<CR>
nmap \d "cyydd:execute "!" . getreg("c")<CR>
"nmap \w bvw"cy:execute "!" . getreg("c")<CR>
