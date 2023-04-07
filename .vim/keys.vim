tnoremap <C-w> <C-\><C-n>
map <C-y> "+gP

" This is alt, but should be altgr
"map <A-s> <A-s><A-s>
"map <A-s> :q!<CR>
"imap <a-s> :q!<CR>
"imap <m-s> :q!<CR>

" Hyper modifier from emacs
" working in console (even
" bindings are similar):
map <C-x>@hc :wqa<CR>
map <C-x>@hs :w<CR>
map <C-x>@ho :e
map <C-x>@h0 :q<CR>
map <C-x>@h2 :sp<CR>
map <C-x>@h3 :vs<CR>

" Those are not
nnoremap <C-x>@hh :wincmd h<CR>
nnoremap <C-x>@hj :wincmd j<CR>
nnoremap <C-x>@hk :wincmd k<CR>
nnoremap <C-x>@hl :wincmd l<CR>

nnoremap <C-x>@hH :wincmd H<CR>
nnoremap <C-x>@hJ :wincmd J<CR>
nnoremap <C-x>@hK :wincmd K<CR>
nnoremap <C-x>@hL :wincmd L<CR>

" tabs with unused _
nnoremap _k :tabfirst<CR>
nnoremap _j :tablast<CR>
nnoremap _l :tabnext<CR>
nnoremap _h :tabprev<CR>
nnoremap _t :tabedit<Space>
"nnoremap _e :tabedit<Space>
nnoremap _m :tabm<Space>
nnoremap _d :tabclose<CR>
nnoremap _T :tabnew<CR>
nnoremap _L :tabm +1<CR>
nnoremap _H :tabm -1<CR>
nnoremap _J :tabm $<CR>
nnoremap _K :tabm 0<CR>
nnoremap _B :tabnew<CR>:buffer<Space>

" buffers
nnoremap _b :buffer<Space>
nnoremap _n :bnext<CR>
nnoremap _p :bprevious<CR>
nnoremap _N :bnext!<CR>
nnoremap _P :bprevious!<CR>
nnoremap _D :bdelete<CR>
nnoremap _U :bunload<CR>
nnoremap _s :sbprevious<CR>
nnoremap _S :sbnext<CR>
nnoremap _v :vsplit<CR>:bnext<CR>
nnoremap _V :vsplit<CR>:bprevious<CR>
nnoremap _a :bad<Space>
"nnoremap _A :balt<Space>
nnoremap _f :files<CR>
nnoremap _c :bmodified<CR>
nnoremap _C :bmodified!<CR>
nnoremap _g :vsplit<Space>
nnoremap _G :split<Space>
nnoremap _w :SudoWrite<CR>

nnoremap \e 0v$"cy:execute "!" . getreg("c")<CR>
nnoremap \d 0v$"cydd:execute "!" . getreg("c")<CR>
"nnoremap \w bvw"cy:execute "!" . getreg("c")<CR>

" Select whole buffer without plugins
vnoremap ae <Esc>gg0vG$
" Not exact vie
vnoremap ie <Esc>gg}{vG{}k$
"vae defined earlier doesn't work here
nnoremap yae mcggvG$y'c

" For custom mapping
silent! unmap gc
silent! unmap gC
silent! unmap gr
silent! unmap gR
silent! unmap gm
silent! unmap gM
