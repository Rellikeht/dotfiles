"{{{ TODO speeddating

" au VimEnter * SpeedDatingFormat %d %b %Y
" au VimEnter * SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M:%S %z
" au VimEnter * SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M:%S%?[Z]
" au VimEnter * SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M%z
" au VimEnter * SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M
" au VimEnter * SpeedDatingFormat %d-%m-%Y
" au VimEnter * SpeedDatingFormat %a %_d %b %H:%M:%S %Z %Y
" au VimEnter * SpeedDatingFormat %a %-d %h %H:%M:%S %Y %z
" au VimEnter * SpeedDatingFormat %_d %h %H:%M:%S
" au VimEnter * SpeedDatingFormat %d %b, %Y

" execute "SpeedDatingFormat %d %b %Y"
" execute "SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M:%S %z"
" execute "SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M:%S%?[Z]"
" execute "SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M%z"
" execute "SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M"
" execute "SpeedDatingFormat %d-%m-%Y"
" execute "SpeedDatingFormat %a %_d %b %H:%M:%S %Z %Y"
" execute "SpeedDatingFormat %a %-d %h %H:%M:%S %Y %z"
" execute "SpeedDatingFormat %_d %h %H:%M:%S"
" execute "SpeedDatingFormat %d %b, %Y"

"}}}

"{{{ unicode

let g:Unicode_no_default_mappings = 1

" Alt/meta doesn't cooperate
inoremap <C-x>g <Plug>(DigraphComplete)
inoremap <C-x>c <Plug>(UnicodeComplete)
inoremap <C-x>h <Plug>(HTMLEntityComplete)
inoremap <C-x>u <Plug>(UnicodeFuzzy)

noremap <Leader>nm <Plug>(MakeDigraph)
nnoremap ga <Plug>(UnicodeGA)

"}}}

"{{{ vim-nuuid

let g:nuuid_no_mappings = 1

" map <Leader>nu <Plug>Nuuid
noremap <silent> <Leader>nn :NuuidAll<CR>
noremap <silent> <Leader>ng :exe 'norm a'.NuuidNewUuid()<CR>
noremap <silent> <Leader>nt :NuuidToggleAbbrev<CR>

"}}}
