" w, f, l (easymotion),
" s, e (code plugins)
" ;, <Space> (my mappings)
" and their capital versions are already used
" ========================= SETUP =========================
" Using tmux

" I don't know if it is doable
"function CdUnder(path)
"    "execute "Tmux run-shell 'tmux send-keys :suspend C-M cd ".a:path." fg C-M'"
"    "execute "Tmux run-shell 'echo ".a:path." | \~/.vim/cd.sh'"
"    execute "Tmux run-shell '\~/.vim/cd.sh'"
"endfunction

function Ccd()
	let path = expand('%:h')
	execute 'cd' path
endfunction

function Setup2Panes()
	let path = expand('%:h')
	execute 'Tmux split-window -h -c' path
	execute 'Tmux select-pane -R'
	execute 'cd' path
endfunction

function Setup3Panes()
	let path = expand('%:h')
	execute 'Tmux split-window -h -c' path
	execute 'Tmux split-window -v -c' path
	execute 'Tmux select-pane -U'
	execute 'Tmux select-pane -L'
	execute 'cd' path
endfunction

map <Leader>tT :Tmux
map <Leader>t2 :call Setup2Panes()<CR>
map <Leader>t3 :call Setup3Panes()<CR>
map <Leader>tC :call Ccd()<CR>

" ========================= EXECUTION AND BUILDING =========================

" General shortcuts
" <Leader>cc - simple compilation
" starting with <Leader>cd and <Leader>cD - debug compilation
" starting with <Leader>cr and <Leader>cR - release compilation
" starting with <Leader>co and <Leader>cO - optimized compilation
" starting with <Leader>cu and <Leader>cU - unsafely optimized compilation
" starting with <Leader>cC and <Leader>ca and <Leader>cA - alternative compilers

" <Leader>r - with 
" <Leader>ra - running already compiled file (DANGEROUS)
" <Leader>C and <Leader>R - <Leader>c and <Leader>r counterparts without <CR>
" for changing command before running
" for languages that can be both compiled and interpreted
" there will be <Leader>i and <Leader>I options respectively to
" <Leader>r and <Leader>R

" Building commands will be hard
" <Leader>bb - building project

" COMPILED

function GenerateBindingsCompiled(name, compexe, bindings, prefix)
	for [key, cmd] in items(a:bindings)
		execute 'autocmd FileType' a:name
					\ 'nmap <buffer> <Leader>C'.a:prefix.key ':!'.a:compexe cmd
		execute 'autocmd FileType' a:name
					\ 'nmap <buffer> <Leader>c'.a:prefix.key
					\ '<Leader>C'.a:prefix.key '<CR>'
		execute 'autocmd FileType' a:name
					\ 'nmap <buffer> <Leader>R'.a:prefix.key
					\ '<Leader>c'.a:prefix.key ':!./%:t:r'
		execute 'autocmd FileType' a:name
					\ 'nmap <buffer> <Leader>r'.a:prefix.key
					\ '<Leader>R'.a:prefix.key '<CR>'
	endfor

	execute 'autocmd FileType' a:name 'nmap <buffer> <Leader>Ra :!./%:t:r'
	execute 'autocmd FileType' a:name 'nmap <buffer> <Leader>ra :!./%:t:r<CR>'
endfunction

" C
" TODO not tested well
let cbindings = {
			\ 'c': '-march=native -mtune=native -o %:t:r %', 
			\ 'd': '-march=native -mtune=native -Og -Wall -pedantic -o %:t:r %',
			\ 'D': '-march=native -mtune=native -Og -Wall -Werror -pedantic -o %:t:r %',
			\ 'r': '-march=native -mtune=native -O2 -o %:t:r %',
			\ 'o': '-march=native -mtune=native -O2 -Wall -o %:t:r %',
			\ 'u': '-march=native -mtune=native -O3 -o %:t:r %',
			\ 'U': '-march=native -mtune=native -Ofast -o %:t:r %'
			\}

call GenerateBindingsCompiled('c', 'gcc', cbindings, '')
call GenerateBindingsCompiled('c', 'clang', cbindings, 'C')
call GenerateBindingsCompiled('c', 'tcc', cbindings, 't')
call GenerateBindingsCompiled('c', 'musl-gcc', cbindings, 'm')

" C++
" TODO untested
let cppbindings = {
			\ 'c': '-march=native -mtune=native -o %:t:r %', 
			\ 'd': '-march=native -mtune=native -Og -Wall -pedantic -o %:t:r %',
			\ 'D': '-march=native -mtune=native -Og -Wall -Werror -pedantic -o %:t:r %',
			\ 'r': '-march=native -mtune=native -O2 -o %:t:r %',
			\ 'o': '-march=native -mtune=native -O2 -Wall -o %:t:r %',
			\ 'u': '-march=native -mtune=native -O3 -o %:t:r %',
			\ 'U': '-march=native -mtune=native -Ofast -o %:t:r %'
			\}

call GenerateBindingsCompiled('cpp', "g++", cbindings, '')
call GenerateBindingsCompiled('cpp', 'clang++', cbindings, 'C')

" nim
" TODO not tested well
let nimbindings = {
			\ 'c': '--styleCheck:hint %', 
			\ 'd': '--styleCheck:hint -d:debug %',
			\ 'r': '--styleCheck:hint --hints:off -d:release --mm:orc %',
			\ 'o': '--styleCheck:hint --hints:off -d:release --mm:arc %',
			\ 'u': '--hints:off -d:danger --mm:orc %',
			\ 'U': '--hints:off -d:danger --mm:arc %',
			\}

call GenerateBindingsCompiled('nim', 'nim c', nimbindings, '')
call GenerateBindingsCompiled('nim', 'nlvm c', nimbindings, 'n')
call GenerateBindingsCompiled('nim', 'nim cpp', nimbindings, 'p')
call GenerateBindingsCompiled('nim', 'nlvm cpp', nimbindings, 'np')
" TODO nim js

" TODO is this needed
"autocmd FileType nim nmap <buffer> <Leader>RA :!nlvm r %
"autocmd FileType nim nmap <buffer> <Leader>rA <Leader>RA<CR>

" go
" TODO

" haskell
" TODO

" ocaml
" TODO

" scheme
" TODO (gambit)

" groff
" TODO

" latex
" TODO

" rust ???
" TODO

" INTERPRETED AND JIT

function GenerateBindingsInterpreted(name, bindings)
	for [key, cmd] in items(a:bindings)
		execute 'autocmd FileType' a:name 'nmap <buffer> <Leader>R'.key cmd
		execute 'autocmd FileType' a:name 
					\ 'nmap <buffer> <Leader>r'.key '<Leader>R'.key '<CR>'
	endfor
endfunction

" python
let pybindings = {
			\ 'c': ':!python3 %', 
			\ 'd': ':!mypy %',
			\ 'o': ':!pypy3 %',
			\}
call GenerateBindingsInterpreted('python', pybindings)

" julia
" TODO untested
let jlbindings = {
			\ 'c': ':!julia %', 
			\ 'd': ':!julia -g %',
			\ 'r': ':!julia -g 0 -O 3 %',
			\ 'o': ':!julia -O 3 %',
			\ 'u': ':!julia -O 3 --min-optlevel=3 --math-mode=user --check-bounds=no %',
			\ 'U': 
			\ ':!julia -O 3 --min-optlevel=3 --math-mode=user --check-bounds=no -g 0 %',
			\}
call GenerateBindingsInterpreted('julia', jlbindings)

" shell
" TODO untested
let shbindings = {
			\ 'c': ':!%:p', 
			\ 'd': ':!shellcheck %',
			\ 'r': ':!bash %',
			\ 'o': ':!dash %',
			\ 'a': ':!ksh %',
			\
			\ 'D1': ':!shellcheck -C always-S error -s sh %',
			\ 'D2': ':!shellcheck -C always-S warning -s sh %',
			\ 'D3': ':!shellcheck -C always-S info -s sh %',
			\ 'D4': ':!shellcheck -C always-S style -s sh %',
			\
			\ 'D7': ':!shellcheck -C always -S error -s dash %',
			\ 'D8': ':!shellcheck -C always -S warning -s dash %',
			\ 'D9': ':!shellcheck -C always -S info -s dash %',
			\ 'D0': ':!shellcheck -C always -S style -s dash %',
			\
			\ 'Db1': ':!shellcheck -C always -S error -s bash %',
			\ 'Db2': ':!shellcheck -C always -S warning -s bash %',
			\ 'Db3': ':!shellcheck -C always -S info -s bash %',
			\ 'Db4': ':!shellcheck -C always -S style -s bash %',
			\
			\ 'Dk1': ':!shellcheck -C always -S error -s ksh %',
			\ 'Dk2': ':!shellcheck -C always -S warning -s ksh %',
			\ 'Dk3': ':!shellcheck -C always -S info -s ksh %',
			\ 'Dk4': ':!shellcheck -C always -S style -s ksh %',
			\
			\ 'Dr': ':!checkbashisms %',
			\}
call GenerateBindingsInterpreted('sh', shbindings)

" common lisp
" TODO

" lua ?
" TODO

" INTERPRETED COUNTERPARTS

function GenerateBindingsHybrid(name, bindings)
	for [key, cmd] in items(a:bindings)
		execute 'autocmd FileType' a:name 'nmap <buffer> <Leader>I'.key cmd
		execute 'autocmd FileType' a:name 
					\ 'nmap <buffer> <Leader>i'.key '<Leader>I'.key '<CR>'
	endfor
endfunction

" scheme
" TODO

" nim (nlvm)
" TODO not tested well
let nlvmbindings = {
			\ 'c': ':!nlvm r --styleCheck:hint %', 
			\ 'd': ':!nlvm r --styleCheck:hint -d:debug %',
			\ 'r': ':!nlvm r --styleCheck:hint --hints:off -d:release --mm:orc %',
			\ 'o': ':!nlvm r --styleCheck:hint --hints:off -d:release --mm:arc %',
			\ 'u': ':!nlvm r --hints:off -d:danger --mm:orc %',
			\ 'U': ':!nlvm r --hints:off -d:danger --mm:arc %',
			\}
call GenerateBindingsHybrid('nim', nlvmbindings)

" ocaml
" TODO
