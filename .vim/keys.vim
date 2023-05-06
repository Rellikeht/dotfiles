function Xcopy(name)
    call system('echo -n '.shellescape(@").' | xclip -i -selection '.a:name)
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

let mapleader = ','

nnoremap <Leader><Space> :set hls!<CR>

command! -nargs=+ Silent
			\	execute 'silent <args>'
			\	| redraw!

" Attempt to make vim easier to use
" in workman layout, with preserving
" logic (eg. d for delete, e for end...)
let s:lay="qwe"
function! Wmt()
	if s:lay =~? "wkm"
		source ~/.vim/qwerty.vim
		let s:lay="qwe"
	else
		source ~/.vim/workman.vim
		let s:lay="wkm"
	endif
endfunction

" Mapping motion in workman layout to be more
" 'normal' and cleaning keys messed in the process
" y n e o are h j k l
" and second time
" and h j k l are e y n o
map <C-s> :call Wmt()<CR>

" General purpose leader mappings
map <Leader>;c :!clear<CR><CR>
map <Leader>;l :!ls<CR>
map <Leader>;e :Ex<CR>
