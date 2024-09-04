" {{{ TODO C speeddating

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

" }}}

" {{{ unicode
" TODO B is this complete ?

let g:Unicode_no_default_mappings = 1

inoremap <C-x><C-g> <Plug>(DigraphComplete)
inoremap <C-x><C-a> <Plug>(UnicodeComplete)
inoremap <C-x><C-h> <Plug>(HTMLEntityComplete)
inoremap <C-x><C-s> <Plug>(UnicodeFuzzy)

imap <C-x>g <C-x><C-g>
imap <C-x>a <C-x><C-a>
imap <C-x>h <C-x><C-h>
imap <C-x>s <C-x><C-s>

inoremap <expr> <C-a> pumvisible() ? '<C-n>' : '<C-a>'
inoremap <expr> <C-h> pumvisible() ? '<C-n>' : '<C-h>'

noremap <Leader>nm <Plug>(MakeDigraph)
nnoremap ga <Plug>(UnicodeGA)

" }}}

" {{{ vim-nuuid

let g:nuuid_no_mappings = 1

" map <Leader>nu <Plug>Nuuid
noremap <silent> <Leader>nn :NuuidAll<CR>
noremap <silent> <Leader>ng :exe 'norm a'.NuuidNewUuid()<CR>
noremap <silent> <Leader>na :NuuidToggleAbbrev<CR>

" }}}

" {{{ tabularize

nnoremap <Leader>it :<C-u>Tabularize /
vnoremap <Leader>it :Tabularize /
nnoremap <Leader>ip :<C-u>Tabularize //<Left>
vnoremap <Leader>ip :Tabularize //<Left>

nnoremap <Leader>i= :<C-u>Tabularize /=<CR>
vnoremap <Leader>i= :Tabularize /=<CR>
nnoremap <Leader>i: :<C-u>Tabularize /:<CR>
vnoremap <Leader>i: :Tabularize /:<CR>
nnoremap <Leader>i; :<C-u>Tabularize /;<CR>
vnoremap <Leader>i; :Tabularize /;<CR>
nnoremap <Leader>i& :<C-u>Tabularize /&<CR>
vnoremap <Leader>i& :Tabularize /&<CR>
nnoremap <Leader>i@ :<C-u>Tabularize /@<CR>
vnoremap <Leader>i@ :Tabularize /@<CR>

nnoremap <Leader>i;= :<C-u>Tabularize /=zs<CR>
vnoremap <Leader>i;= :Tabularize /=zs<CR>
nnoremap <Leader>i;: :<C-u>Tabularize /:zs<CR>
vnoremap <Leader>i;: :Tabularize /:zs<CR>
nnoremap <Leader>i;; :<C-u>Tabularize /;zs<CR>
vnoremap <Leader>i;; :Tabularize /;zs<CR>
nnoremap <Leader>i;& :<C-u>Tabularize /&zs<CR>
vnoremap <Leader>i;& :Tabularize /&zs<CR>
nnoremap <Leader>i;@ :<C-u>Tabularize /@zs<CR>
vnoremap <Leader>i;@ :Tabularize /@zs<CR>

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

function InsertAlignToggle()
  if get(b:, 'insert_align', v:null) == v:null || 
        \ b:insert_align == 0
    let b:insert_align = 1
    inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
  else
    let b:insert_align = 0
    iunmap <Bar>
  endif
endfunction

nnoremap <Leader>ii :<C-u>call InsertAlignToggle()<CR>
vnoremap <Leader>ii :<C-u>call InsertAlignToggle()\|norm gv<CR>

" }}}
