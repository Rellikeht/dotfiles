
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

" Alt/meta doesn't cooperate
imap <C-x>g <Plug>(DigraphComplete)
imap <C-x>c <Plug>(UnicodeComplete)
imap <C-x>h <Plug>(HTMLEntityComplete)
imap <C-x>u <Plug>(UnicodeFuzzy)

map <Leader>nm <Plug>(MakeDigraph)
map ga <Plug>(UnicodeGA)

" vim-nuuid

let g:nuuid_no_mappings = 1
" map <Leader>nu <Plug>Nuuid
map <Leader>nN :NuuidAll<CR>
map <Leader>nu :exe 'norm a'.NuuidNewUuid()<CR>
map <Leader>nU :NuuidToggleAbbrev<CR>
