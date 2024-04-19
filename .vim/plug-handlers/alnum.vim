
" speeddating

au VimEnter * SpeedDatingFormat %d %b %Y
au VimEnter * SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M:%S %z
au VimEnter * SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M:%S%?[Z]
au VimEnter * SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M%z
au VimEnter * SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M
au VimEnter * SpeedDatingFormat %d-%m-%Y
au VimEnter * SpeedDatingFormat %a %_d %b %H:%M:%S %Z %Y
au VimEnter * SpeedDatingFormat %a %-d %h %H:%M:%S %Y %z
au VimEnter * SpeedDatingFormat %_d %h %H:%M:%S
au VimEnter * SpeedDatingFormat %d %b, %Y

" unicode

let g:Unicode_no_default_mappings = 1

" TODO Uncomfortable mappings, should be shorter
" but fucking alt refuses to work
imap <c-x><c-g> <Plug>(DigraphComplete)
imap <c-x><c-u> <Plug>(UnicodeComplete)
imap <c-x><c-h> <Plug>(HTMLEntityComplete)
imap <c-x><c-m> <Plug>(UnicodeFuzzy)

map <Leader>nm <Plug>(MakeDigraph)
map ga <Plug>(UnicodeGA)

" ???
"map <Leader>sT <Plug>(ToggleUnicodeCompletion)
"nmap <leader>sS <Plug>(UnicodeSwapCompleteName)

" vim-nuuid

let g:nuuid_no_mappings = 1
" map <Leader>nA :NuuidAll<CR>
map <Leader>nN :NuuidAll<CR>
" map <Leader>nu <Plug>Nuuid
map <Leader>nu :exe 'norm a'.NuuidNewUuid()<CR>
map <Leader>nU :NuuidToggleAbbrev<CR>

" Pluto.jl :)
map <Leader>nC :exe 'norm i# ╔═╡ '.NuuidNewUuid()<CR>
map <Leader>nA :norm mCyyGp02lr╟lr─lxx'C<CR>
