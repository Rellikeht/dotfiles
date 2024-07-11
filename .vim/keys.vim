"{{{ TODO Tags

noremap <C-j> <C-]>

noremap <silent> <Leader>jts :ts<CR>
noremap <silent> <Leader>jth :sts<CR>
noremap <silent> <Leader>jtv :vert sts<CR>
noremap <silent> <Leader>jtl :tags<CR>

" }}}

"{{{ Better tab

noremap <silent> <Tab>k K<C-w>T

noremap <silent> <Tab>n :<C-u>call SwitchTab(v:count1)<CR>
noremap <silent> <Tab>H :<C-u>execute 'tabm -'.v:count1<CR>
noremap <silent> <Tab>L :<C-u>execute 'tabm +'.v:count1<CR>

nnoremap <silent> <Tab>w :<C-u>We<CR>

"}}}

" TODO counts

" {{{ resizing with <Tab>
" TODO counts
" TODO better
" TODO more

noremap <Tab>>1 :vertical resize 10<CR>
noremap <Tab>>2 :vertical resize 20<CR>
noremap <Tab>>3 :vertical resize 30<CR>
noremap <Tab>>4 :vertical resize 40<CR>
noremap <Tab>>5 :vertical resize 50<CR>
noremap <Tab>>r :vertical resize <Space>

noremap <Tab>>= :vertical resize +1<CR>
noremap <Tab>>+ :vertical resize +5<CR>
noremap <Tab>>a :vertical resize +10<CR>
noremap <Tab>>A :vertical resize +20<CR>
noremap <Tab>>- :vertical resize -1<CR>
noremap <Tab>>_ :vertical resize -5<CR>
noremap <Tab>>d :vertical resize -10<CR>
noremap <Tab>>D :vertical resize -20<CR>

noremap <Tab>^1 :resize 10<CR>
noremap <Tab>^2 :resize 20<CR>
noremap <Tab>^3 :resize 30<CR>
noremap <Tab>^4 :resize 40<CR>
noremap <Tab>^5 :resize 50<CR>
noremap <Tab>^r :resize <Space>

noremap <Tab>^= :resize +1<CR>
noremap <Tab>^+ :resize +5<CR>
noremap <Tab>^a :resize +10<CR>
noremap <Tab>^A :resize +20<CR>
noremap <Tab>^- :resize -1<CR>
noremap <Tab>^_ :resize -5<CR>
noremap <Tab>^d :resize -10<CR>
noremap <Tab>^D :resize -20<CR>

" }}}

" {{{ buffers with <Space>

noremap <silent> <Space>n :<C-u>exe v:count1.'bnext'<CR>
noremap <silent> <Space>p :<C-u>exe v:count1.'bprevious'<CR>
noremap <silent> <Space>N :<C-u>exe v:count1.'bnext!'<CR>
noremap <silent> <Space>P :<C-u>exe v:count1.'bprevious!'<CR>
noremap <silent> <Space>m :<C-u>exe v:count1.'bmodified'<CR>
noremap <silent> <Space>M :<C-u>exe v:count1.'bmodified!'<CR>

" }}}

"{{{ args with <BS>

noremap <silent> <BS>n :<C-u>exe v:count1.'next'<CR>
noremap <silent> <BS>N :<C-u>exe v:count1.'next!'<CR>
noremap <silent> <BS>p :<C-u>exe v:count1.'previous'<CR>
noremap <silent> <BS>P :<C-u>exe v:count1.'previous!'<CR>

noremap <silent> <BS>. :<C-u>exe v:count1.'wnext'<CR>
noremap <silent> <BS>> :<C-u>exe v:count1.'wnext!'<CR>
noremap <silent> <BS>, :<C-u>exe v:count1.'wprevious'<CR>
noremap <silent> <BS>< :<C-u>exe v:count1.'wprevious!'<CR>

"}}}

"{{{ leader stuff

" TODO add more commands

" General purpose leader mappings
noremap <Leader>;l :!ls<CR>
noremap <Leader>;m :make<CR>
noremap <Leader>;M :make<Space>

" pwd
noremap <Leader>;c :silent! lcd %:p:h<CR>
noremap <Leader>;p :silent! cd %:p:h<CR>
noremap <Leader>;C :lcd<Space>
noremap <Leader>;P :cd<Space>

" Not the best, but should work
noremap <silent> <Leader>;wc mCggvG$:w !wc<CR>

" ???
" map <Leader>;r :!%<CR>

"}}}

"{{{ free keys

"}}}

"{{{ free control maps

" CTRL-@           not used
" 
" |CTRL-H|  CTRL-H      1  same as "h"
" |<NL>|        <NL>        1  same as "j"
" |CTRL-J|  CTRL-J      1  same as "j"
"       CTRL-K         not used
" |CTRL-N|  CTRL-N      1  same as "j"
" |CTRL-P|  CTRL-P      1  same as "k"
" CTRL-Q           not used, or used for terminal control flow
" CTRL-S           not used, or used for terminal control flow
" 
" |CTRL-\_CTRL-G|   CTRL-\ CTRL-G      go to Normal mode (no-op)
" CTRL-\ a - z     reserved for extensions
" CTRL-\ others    not used
" |CTRL-<Tab>|  CTRL-<Tab>     same as `g<Tab>` : go to last accessed tab
" CTRL-_           not used

"}}}

"{{{ TODO quickfix

" noremap <silent> <C-j> :<C-u>execute v:count1.'cn'<CR>
" noremap <silent> <C-k> :<C-u>execute v:count1.'cp'<CR>
" noremap <silent> <C-n> :<C-u>execute v:count1.'cnf'<CR>
" noremap <silent> <C-p> :<C-u>execute v:count1.'cpf'<CR>
" noremap <silent> <C-_> :<C-u>execute v:count1.'cc'<CR>

noremap <silent> <C-j> :<C-u>execute v:count1.'cn'<CR>
noremap <silent> <C-k> :<C-u>execute v:count1.'cp'<CR>
noremap <silent> <C-n> :<C-u>execute v:count1.'cnf'<CR>
noremap <silent> <C-p> :<C-u>execute v:count1.'cpf'<CR>
noremap <silent> <C-_> :<C-u>execute v:count1.'cc'<CR>

" TODO proper bindings
" map <silent> <Tab>J :<C-u>execute 'ln '.v:count1<CR>
" map <silent> <Tab>K :<C-u>execute 'lp '.v:count1<CR>
" map <silent> <Tab>c :<C-u>execute 'cc '.v:count1<CR>
" map <silent> <Tab>C :<C-u>execute 'll '.v:count1<CR>

" map <Tab>d :cdo<Space>
" map <Tab>D :ldo<Space>
" map <silent> <Tab>o :copen<CR>
" map <silent> <Tab>O :lopen<CR>
" map <silent> <Tab>r :crewind<CR>
" map <silent> <Tab>R :lrewind<CR>

"}}}

"{{{ TODO loclist

"}}}

"{{{ Matchit

noremap <Leader>{ [%
noremap <Leader>} ]%

"}}}

"{{{ completion

" Yeah, copying from wiki works
inoremap <expr> <Cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <Tab> pumvisible() ? "<C-y>" : "<TAB>"

"}}}

"{{{ TODO

" TODO B running command under cursor
" TODO C running command in given register (???)
" TODO C https://youtu.be/w7i4amO_zaE?t=1464

" Run command in register c
" map <silent> <Leader>;E 'cyy:execute '!' . getreg('c')<CR>
" map <silent> <Leader>;D 'cyydd:execute '!' . getreg('c')<CR>
"nmap <silent> <Leader>W bvw"cy:execute "!" . getreg('c')<CR>

"}}}
