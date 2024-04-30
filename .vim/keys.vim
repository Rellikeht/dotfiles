" Repeat:
" silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" Better tab
map <Tab>l :<C-u>call SwitchTab(v:count1)<CR>
map <Tab>h :<C-u>call SwitchTab(-v:count1)<CR>
map <Tab>H :<C-u>execute 'tabm -'.v:count1<CR>
map <Tab>L :<C-u>execute 'tabm +'.v:count1<CR>

map <Tab>n :<C-u>execute 'bnext '.v:count1<CR>
map <Tab>p :<C-u>execute 'bprevious '.v:count1<CR>
map <Tab>N :<C-u>execute 'bnext! '.v:count1<CR>
map <Tab>P :<C-u>execute 'bprevious! '.v:count1<CR>

" Other <Tab>
nmap <Tab>w :SudoWrite<CR>
nmap <Tab>W :We<CR>
vmap <Tab>y y:call Xcopy('clipboard')<CR>
vmap <Tab>Y y:call Xcopy('primary')<CR>
" TODO do this better
nmap <Tab>y :call Xpaste('clipboard')<CR>
nmap <Tab>Y :call Xpaste('primary')<CR>

let mapleader = ','

" General purpose leader mappings
nmap <Leader><Space> :set hls!<CR>
map <Leader>;C :!clear<CR><CR>
map <Leader>;l :!ls<CR>
map <Leader>;e :Ex<CR>
map <Leader>;m :make<CR>
map <Leader>;M :make

nmap <C-j> :<C-u>execute 'cn '.v:count1<CR>
nmap <C-k> :<C-u>execute 'cp '.v:count1<CR>
vmap <C-j> :<C-u>execute 'cn '.v:count1<CR>
vmap <C-k> :<C-u>execute 'cp '.v:count1<CR>

" TODO what is l the fuck
" TODO proper bindings
" map <Tab>j :<C-u>execute 'cn '.v:count1<CR>
" map <Tab>k :<C-u>execute 'cp '.v:count1<CR>
" map <Tab>J :<C-u>execute 'ln '.v:count1<CR>
" map <Tab>K :<C-u>execute 'lp '.v:count1<CR>
" map <Tab>c :<C-u>execute 'cc '.v:count1<CR>
" map <Tab>C :<C-u>execute 'll '.v:count1<CR>

" map <Tab>J :<C-u>execute 'cnf '.v:count1<CR>
" map <Tab>K :<C-u>execute 'cpf '.v:count1<CR>

" map <Tab>d :cdo<Space>
" map <Tab>D :ldo<Space>
" map <Tab>o :copen<CR>
" map <Tab>O :lopen<CR>
" map <Tab>r :crewind<CR>
" map <Tab>R :lrewind<CR>

" ???
" map <Leader>;r :!%<CR>

map <Leader>qq :call Wmt()<CR>
map <Leader>qm :call ToggleManProg()<CR>
map <Leader>qM :set makeprg=make<CR>
map <Leader>qE :EditorConfigReload<CR>

map <Leader>qf :let b:buffmt=!b:buffmt<CR>
map <Leader>qF :let g:buffmt=!g:buffmt<CR>
map <Leader>q1 :echo b:buffmt<CR>

map <Leader>qc :let b:bufcomp=!b:bufcomp<CR>
map <Leader>qC :let g:bufcomp=!g:bufcomp<CR>
map <Leader>q2 :echo b:bufcomp<CR>

" Yeah, copying from wiki works
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Not the best, but should work
map <Leader>;c mCggvG$:w !wc<CR>

" Netrw
" TODO C
let g:netrw_liststyle = 3
" Some day
" let g:netrw_banner = 0

" TODO D linestyle toggle
" map <Leader>xT :let g:netrw_liststyle=g:net

" TODO B file openinng

map <Leader>xx :Explore<CR>
map <Leader>xX :Explore<Space>
map <Leader>xt :Texplore<CR>
map <Leader>xh :Sexplore<CR>
map <Leader>xv :Vexplore<CR>
map <Leader>xn :Nxplore<CR>
map <Leader>xp :Pxplore<CR>

" TODO B running command under cursor
" TODO C running command in given register (???)
" TODO C https://youtu.be/w7i4amO_zaE?t=1464
" TODO D editing file in register

" Run command in register c
" map <Leader>;E 'cyy:execute '!' . getreg('c')<CR>
" map <Leader>;D 'cyydd:execute '!' . getreg('c')<CR>
"nmap <Leader>W bvw"cy:execute "!" . getreg('c')<CR>
