"{{{ setup
autocmd WinNew,VimEnter *
            \ arglocal!
            \ | let w:arglists = [argv()]
            \ | let w:prev_dir = expand('%:p:h')
"}}}

"{{{ operations

function ApplyArglist()
endfunction

function AddArglist()
endfunction

function DelArglist()
endfunction

function NextArglist()
endfunction

function ListArglists()
endfunction

function NewArglist()
endfunction

function CompleteArglist()
endfunction

"}}}

"{{{ commands

command -nargs=1 -complete=customlist,CompleteArglist()
            \ OpenArglist

command -nargs=0 DelArglist
            \ call DelArglist()
" TODO something more

command -nargs=0 ListArglists call ListArglists()

" TODO D will be painfully tough
" command ArglistsDo

"}}}

"{{{ maps

" ???
" map <Leader><Space>o :<C-u><CR>
map <Leader><Space>o :<C-u>NewArglist()<CR>
map <Leader><Space>e :<C-u>OpenArglist<Space>
map <Leader><Space>l :<C-u>ListArglists<CR>

map <Leader><Space>a :<C-u>AddArglist()<CR>
map <Leader><Space>d :<C-u>DelArglist<CR>
map <Leader><Space>+ :<C-u>NewArglist()<CR>

map <Leader><Space>n :<C-u>NextArglist(v:count1)<CR>
map <Leader><Space>p :<C-u>NextArglist(-v:count1)<CR>

" TODO D
" map <Leader><Space>: :<C-u>ArglistsDo<Space>

"}}}
