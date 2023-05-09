function Xcopy(name)
    call system('echo -n '.shellescape(@").' | xclip -i -selection '.a:name)
endfunction

function Xpaste(name)
    execute 'normal a'.system('xclip -o -selection '.a:name)
endfunction

command! -nargs=+ Silent
			\	execute 'silent <args>'
			\	| redraw!

" Attempt to make vim easier to use
" in workman layout, with preserving
" logic (eg. d for delete, e for end...)

" Mapping motion in workman layout to be more
" 'normal' and cleaning keys messed in the process
" y n e o are h j k l
" and second time
" and h j k l are e y n o

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
