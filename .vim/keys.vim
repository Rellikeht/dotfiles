" Repeat:
" silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
" https://jdhao.github.io/2019/04/29/nvim_map_with_a_count/
" https://vi.stackexchange.com/questions/20760/how-to-add-a-count-to-a-binding

" Tags
" TODO

noremap <Leader>jf <C-]>
nnoremap <Leader>jb <C-t>
noremap <silent> <Leader>jts :ts<CR>
noremap <silent> <Leader>jth :sts<CR>
noremap <silent> <Leader>jtv :vert sts<CR>
noremap <silent> <Leader>jtl :tags<CR>

" Better tab
noremap <silent> <Tab>l :<C-u>call SwitchTab(v:count1)<CR>
" noremap <silent> <Tab>h :<C-u>call SwitchTab(-v:count1)<CR>
noremap <silent> <Tab>H :<C-u>execute 'tabm -'.v:count1<CR>
noremap <silent> <Tab>L :<C-u>execute 'tabm +'.v:count1<CR>

noremap <silent> <Tab>n :<C-u>execute 'bnext '.v:count1<CR>
noremap <silent> <Tab>p :<C-u>execute 'bprevious '.v:count1<CR>
noremap <silent> <Tab>N :<C-u>execute 'bnext! '.v:count1<CR>
noremap <silent> <Tab>P :<C-u>execute 'bprevious! '.v:count1<CR>

" TODO do this better

" Other <silent> <Tab>
noremap <silent> <Tab>y :call Xpaste('clipboard')<CR>
noremap <silent> <Tab>Y :call Xpaste('primary')<CR>
nnoremap <silent> <Tab>w :We<CR>

" General purpose leader mappings
noremap <Leader>;l :!ls<CR>
noremap <Leader>;m :make<CR>
noremap <Leader>;M :make<Space>

" pwd
noremap <Leader>;c :silent! lcd %:p:h<CR>
noremap <Leader>;p :silent! cd %:p:h<CR>
noremap <Leader>;C :lcd<Space>
noremap <Leader>;P :cd<Space>

noremap <silent> <C-j> :<C-u>execute 'cn '.v:count1<CR>
noremap <silent> <C-k> :<C-u>execute 'cp '.v:count1<CR>

" TODO what is l the fuck
" TODO proper bindings
" map <silent> <Tab>j :<C-u>execute 'cn '.v:count1<CR>
" map <silent> <Tab>k :<C-u>execute 'cp '.v:count1<CR>
" map <silent> <Tab>J :<C-u>execute 'ln '.v:count1<CR>
" map <silent> <Tab>K :<C-u>execute 'lp '.v:count1<CR>
" map <silent> <Tab>c :<C-u>execute 'cc '.v:count1<CR>
" map <silent> <Tab>C :<C-u>execute 'll '.v:count1<CR>

" map <silent> <Tab>J :<C-u>execute 'cnf '.v:count1<CR>
" map <silent> <Tab>K :<C-u>execute 'cpf '.v:count1<CR>

" map <Tab>d :cdo<Space>
" map <Tab>D :ldo<Space>
" map <silent> <Tab>o :copen<CR>
" map <silent> <Tab>O :lopen<CR>
" map <silent> <Tab>r :crewind<CR>
" map <silent> <Tab>R :lrewind<CR>

" ???
" map <Leader>;r :!%<CR>

" Matchit
map <Leader>{ [%
map <Leader>} ]%

" Yeah, copying from wiki works
inoremap <expr> <Cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <Tab> pumvisible() ? "<C-y>" : "<TAB>"

" Not the best, but should work
noremap <silent> <Leader>;wc mCggvG$:w !wc<CR>

" TODO B running command under cursor
" TODO C running command in given register (???)
" TODO C https://youtu.be/w7i4amO_zaE?t=1464

" Run command in register c
" map <silent> <Leader>;E 'cyy:execute '!' . getreg('c')<CR>
" map <silent> <Leader>;D 'cyydd:execute '!' . getreg('c')<CR>
"nmap <silent> <Leader>W bvw"cy:execute "!" . getreg('c')<CR>
