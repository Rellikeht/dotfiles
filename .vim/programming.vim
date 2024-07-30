"{{{ settings

autocmd BufWritePost *.ms call CompileGroffMs()

" from opam installation
set rtp^="~/.opam/default/share/ocp-indent/vim"

"}}}

"{{{ :make
" TODO A polish that
" TODO A auto

nnoremap ,mm :<C-u>make<CR>
vnoremap ,mm :<C-u>make\|norm gv<CR>
nnoremap ,m<Space>m :<C-u>make<Space>
vnoremap ,m<Space>m :<C-u>make  \|norm gv
      \ <C-Left><C-Left><Left>

nnoremap ,mpf :<C-u>set makeprg=nix\ build<CR>
vnoremap ,mpf :<C-u>set makeprg=nix\ build\|norm gv<CR>
nnoremap ,mpn :<C-u>set makeprg=nix-build<CR>
vnoremap ,mpn :<C-u>set makeprg=nix-build\|norm gv<CR>

nnoremap ,mpm :<C-u>set makeprg=make<CR>
vnoremap ,mpm :<C-u>set makeprg=make\|norm gv<CR>
nnoremap ,m<Space>p :<C-u>set makeprg=
vnoremap ,m<Space>p :<C-u>set makeprg= \|norm gv
      \ <C-Left><C-Left><Left>

"}}}

"{{{ compiler
" TODO B what is this even doing

nnoremap ,co; :<C-u>compiler<Space>
vnoremap ,co; :<C-u>compiler  \|norm gv<C-Left><C-Left><Left>

" nnoremap ,c<Space> :compiler<CR>
" vnoremap ,c<Space> :compiler\|norm gv<CR>
" nnoremap ,c; :compiler<Space>


"}}}

" TODO B filetypes

""{{{ some old shit
"" TODO make this sane, use :compiler and :make
"
"" General shortcuts
"" cc - simple compilation
"" starting with cd and cD - debug compilation
"" starting with cr and cR - release compilation
"" starting with co and cO - optimized compilation
"" starting with cu and cU - unsafely optimized compilation
"" starting with cC and ca and cA - alternative compilers
"
"" r - with 
"" ra - running already compiled file (DANGEROUS)
"" C and R - c and r counterparts without <CR>
"" for changing command before running
"" for languages that can be both compiled and interpreted
"" there will be i and I options respectively to
"" r and R
"
"" bb - building project
"
"" COMPILED
"
"" TODO background, combinations without <CR> aren't that important
"function GenerateBindingsCompiled(name, compexe, bindings, prefix)
"    for [key, cmd] in items(a:bindings)
"        execute 'autocmd FileType' a:name
"                    \ 'nnoremap <buffer> <Leader>C'.a:prefix.key ':!'.a:compexe cmd
"        execute 'autocmd FileType' a:name
"                    \ 'nnoremap <buffer> <Leader>c'.a:prefix.key
"                    \ '<Leader>C'.a:prefix.key '<CR>'
"        execute 'autocmd FileType' a:name
"                    \ 'nnoremap <buffer> <Leader>R'.a:prefix.key
"                    \ '<Leader>c'.a:prefix.key ':!./%:t:r'
"        execute 'autocmd FileType' a:name
"                    \ 'nnoremap <buffer> <Leader>r'.a:prefix.key
"                    \ '<Leader>R'.a:prefix.key '<CR>'
"    endfor
"
"    execute 'autocmd FileType' a:name 'nnoremap <silent> <buffer> <Leader>Ra :!./%:t:r'
"    execute 'autocmd FileType' a:name 'nnoremap <silent> <buffer> <Leader>ra :!./%:t:r<CR>'
"endfunction
"
"" C
"" TODO not tested well
"let cbindings = {
"            \ 'c': '-march=native -mtune=native -o %:t:r %', 
"            \ 'd': '-march=native -mtune=native -Og -Wall -pedantic -o %:t:r %',
"            \ 'D': '-march=native -mtune=native -Og -Wall -Werror -pedantic -o %:t:r %',
"            \ 'r': '-march=native -mtune=native -O2 -o %:t:r %',
"            \ 'o': '-march=native -mtune=native -O2 -Wall -o %:t:r %',
"            \ 'u': '-march=native -mtune=native -O3 -o %:t:r %',
"            \ 'U': '-march=native -mtune=native -Ofast -o %:t:r %'
"            \}
"
"call GenerateBindingsCompiled('c', 'gcc', cbindings, '')
"call GenerateBindingsCompiled('c', 'clang', cbindings, 'C')
"call GenerateBindingsCompiled('c', 'tcc', cbindings, 't')
"call GenerateBindingsCompiled('c', 'musl-gcc', cbindings, 'm')
"
"" C++
"" TODO untested
"let cppbindings = {
"            \ 'c': '-march=native -mtune=native -o %:t:r %', 
"            \ 'd': '-march=native -mtune=native -Og -Wall -pedantic -o %:t:r %',
"            \ 'D': '-march=native -mtune=native -Og -Wall -Werror -pedantic -o %:t:r %',
"            \ 'r': '-march=native -mtune=native -O2 -o %:t:r %',
"            \ 'o': '-march=native -mtune=native -O2 -Wall -o %:t:r %',
"            \ 'u': '-march=native -mtune=native -O3 -o %:t:r %',
"            \ 'U': '-march=native -mtune=native -Ofast -o %:t:r %'
"            \}
"
"call GenerateBindingsCompiled('cpp', "g++", cbindings, '')
"call GenerateBindingsCompiled('cpp', 'clang++', cbindings, 'C')
"
"" nim
"" TODO not tested well
"let nimbindings = {
"            \ 'c': '%', 
"            \ 'd': '-d:debug %',
"            \ 'r': '--hints:off -d:release --mm:orc %',
"            \ 'o': '--hints:off -d:release --mm:arc %',
"            \ 'u': '-d:danger --mm:orc %',
"            \ 'U': '-d:danger --mm:arc %',
"            \}
"
"call GenerateBindingsCompiled('nim', 'nim c', nimbindings, '')
"call GenerateBindingsCompiled('nim', 'nlvm c', nimbindings, 'n')
"call GenerateBindingsCompiled('nim', 'nim cpp', nimbindings, 'p')
"call GenerateBindingsCompiled('nim', 'nlvm cpp', nimbindings, 'P')
"
"" TODO is this needed
""autocmd FileType nim nmap <buffer> <Leader>RA :!nlvm r %
""autocmd FileType nim nmap <buffer> <Leader>rA <Leader>RA<CR>
"
"" go
"let gobindings = {
"            \ 'c': '%', 
"            \ 'd': '-race %',
"            \}
"
"call GenerateBindingsCompiled('go', 'go build', gobindings, '')
"
"" haskell
"" TODO
"
"" ocaml
"" TODO
"
"" scheme
"" TODO (gambit)
"
"" groff
"" TODO
"
"" latex
"" TODO
"
"" rust ???
"" TODO
"
"" INTERPRETED AND JIT
"
"function GenerateBindingsInterpreted(name, bindings)
"    for [key, cmd] in items(a:bindings)
"        execute 'autocmd FileType' a:name 'nmap <buffer> <Leader>R'.key cmd
"        execute 'autocmd FileType' a:name 
"                    \ 'nmap <buffer> <Leader>r'.key '<Leader>R'.key '<CR>'
"    endfor
"endfunction
"
"" python
"let pybindings = {
"            \ 'c': ':!python3 %', 
"            \ 'd': ':!mypy %',
"            \ 'o': ':!pypy3 %',
"            \}
"call GenerateBindingsInterpreted('python', pybindings)
"
"" julia
"" TODO untested
"let jlbindings = {
"            \ 'c': ':!julia %', 
"            \ 'd': ':!julia -g %',
"            \ 'r': ':!julia -g 0 -O 3 %',
"            \ 'o': ':!julia -O 3 %',
"            \ 'u': ':!julia -O 3 --min-optlevel=3 --math-mode=user --check-bounds=no %',
"            \ 'U': 
"            \ ':!julia -O 3 --min-optlevel=3 --math-mode=user --check-bounds=no -g 0 %',
"            \}
"call GenerateBindingsInterpreted('julia', jlbindings)
"
"" shell
"" TODO untested
"let shbindings = {
"            \ 'c': ':!%:p', 
"            \ 'd': ':!shellcheck %',
"            \ 'r': ':!bash %',
"            \ 'o': ':!dash %',
"            \ 'a': ':!ksh %',
"            \
"            \ 'D1': ':!shellcheck -C always-S error -s sh %',
"            \ 'D2': ':!shellcheck -C always-S warning -s sh %',
"            \ 'D3': ':!shellcheck -C always-S info -s sh %',
"            \ 'D4': ':!shellcheck -C always-S style -s sh %',
"            \
"            \ 'D7': ':!shellcheck -C always -S error -s dash %',
"            \ 'D8': ':!shellcheck -C always -S warning -s dash %',
"            \ 'D9': ':!shellcheck -C always -S info -s dash %',
"            \ 'D0': ':!shellcheck -C always -S style -s dash %',
"            \
"            \ 'Db1': ':!shellcheck -C always -S error -s bash %',
"            \ 'Db2': ':!shellcheck -C always -S warning -s bash %',
"            \ 'Db3': ':!shellcheck -C always -S info -s bash %',
"            \ 'Db4': ':!shellcheck -C always -S style -s bash %',
"            \
"            \ 'Dk1': ':!shellcheck -C always -S error -s ksh %',
"            \ 'Dk2': ':!shellcheck -C always -S warning -s ksh %',
"            \ 'Dk3': ':!shellcheck -C always -S info -s ksh %',
"            \ 'Dk4': ':!shellcheck -C always -S style -s ksh %',
"            \
"            \ 'Dr': ':!checkbashisms %',
"            \}
"call GenerateBindingsInterpreted('sh', shbindings)
"
"" common lisp
"" TODO
"
"" lua ?
"" TODO
"
"" INTERPRETED COUNTERPARTS
"
"function GenerateBindingsHybrid(name, bindings)
"    for [key, cmd] in items(a:bindings)
"        execute 'autocmd FileType' a:name 'nmap <buffer> <Leader>I'.key cmd
"        execute 'autocmd FileType' a:name 
"                    \ 'nmap <buffer> <Leader>i'.key '<Leader>I'.key '<CR>'
"    endfor
"endfunction
"
"" scheme
"" TODO
"
"" nim (nlvm)
"" TODO not tested well
"let nlvmbindings = {
"            \ 'c': ':!nlvm r --styleCheck:hint %', 
"            \ 'd': ':!nlvm r --styleCheck:hint -d:debug %',
"            \ 'r': ':!nlvm r --styleCheck:hint --hints:off -d:release --mm:orc %',
"            \ 'o': ':!nlvm r --styleCheck:hint --hints:off -d:release --mm:arc %',
"            \ 'u': ':!nlvm r --hints:off -d:danger --mm:orc %',
"            \ 'U': ':!nlvm r --hints:off -d:danger --mm:arc %',
"            \}
"call GenerateBindingsHybrid('nim', nlvmbindings)
"
"" ocaml
"" TODO
"
"" TODO incorporate internal make and compile tools
"
"" SOME ADDITIONAL MAPPINGS
"
"" Random numbers
"nnoremap ,igr !!python -c "from random import randint;
"    \ [print(randint(-100,100),end=',') for _ in range(20)]"<CR><CR>
"
"nnoremap ,igR !!python -c "from random import randint;
"    \ [print(randint(-100,100),end=',') for _ in range(20)]"<A-b>
"
"" TODO templates
"
"" }}}
