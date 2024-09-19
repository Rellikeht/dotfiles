" {{{ helpers

command! -nargs=* -complete=file -count=1 Tabe
      \ <count>tabnew
      \ | arglocal!
      \ | args! <args>

command! -bang -nargs=? -complete=arglist Argument 
      \ if len(<q-args>) == 0
      \ | argument
      \ | else
      \ | exe "argedit<bang> <args>"
      \ | argdedupe
      \ | endif

command! -nargs=+ Silent
      \ execute 'silent! <args>'
      \ | redraw!

command! -nargs=1 -complete=arglist TabA
      \ Tabe <args>

command! -nargs=1 -complete=buffer TabB
      \ Tabe <args>

" Nope
" command! -nargs=1 -complete=arglist Vargument
"             \vertical argument <args>
" command! -nargs=1 -complete=arglist Hargument
"             \horizontal argument <args>
" command! -nargs=1 -complete=arglist Dargument
"             \botright vertical argument <args>
" command! -nargs=1 -complete=arglist Rargument
"             \botright horizontal argument <args>

" }}}

" {{{ basic mappings

" Because ; is more comfortable to press
" but all of that is not worth effort
" map ; <C-w>
" map ;; <C-w><C-w>

" Has to be that way
" <CR> is equal to <C-m> !!
noremap <C-m> <Tab>

noremap <Space>y "+y
noremap <Space>Y "+Y
noremap <Tab>y "*y
noremap <Tab>Y "*Y
noremap <Space>u "+p
noremap <Space>U "+P
noremap <Tab>u "*p
noremap <Tab>U "*P

" TODO D this is harder than it should be
" noremap g+ v<C-a>
" noremap g- v<C-x>

noremap <Space><Tab> <C-^>

" }}}

" {{{ nops, mostly because escape doesn't work sometimes

map <Space> <Nop>
map <Space><Space> <Nop>

noremap <Space>;<Esc> <Nop>
noremap <Space>i<Esc> <Nop>

" not that comfortable
" map . <Nop>

" }}}

" {{{ settings with <Space>

nnoremap <Space>qw :<C-u>setlocal wrap!<CR>
vnoremap <Space>qw :<C-u>setlocal wrap!\|norm gv<CR>
nnoremap <Space>qW :<C-u>set wrap!<CR>
vnoremap <Space>qW :<C-u>set wrap!\|norm gv<CR>
nnoremap <Space>qs :<C-u>source %<CR>
vnoremap <Space>qs :<C-u>source %\|norm gv<CR>
nnoremap <Space>qm :<C-u>setlocal modeline!<CR>:e<CR>
vnoremap <Space>qm :<C-u>setlocal modeline!<CR>:e\|norm gv<CR>
nnoremap <Space>qM :<C-u>setlocal modeline!<CR>
vnoremap <Space>qM :<C-u>setlocal modeline!\|norm gv<CR>

" }}}

" {{{ tabs with <Tab>

noremap <Tab>o :<C-u>Tabe<Space>
noremap <Tab>O :<C-u>-Tabe<Space>
noremap <Tab><Space>o :<C-u>TabA<Space>
noremap <Tab><Space>O :<C-u>-TabA<Space>
noremap <Tab>;o :<C-u>TabA<Space>
noremap <Tab>;O :<C-u>-TabA<Space>

noremap <silent> <expr> <Tab>;e
      \(v:count ? ':<C-u>exe "tabnext "'.v:count.'<CR>' : '')
noremap <Tab><Tab> :<C-u>tab<Space>
noremap <Tab>;<Tab> :<C-u>-tab<Space>

" TODO B logic
noremap <Tab>gp :<C-u>tabfind<Space>
noremap <Tab>gP :<C-u>-tabfind<Space>

noremap <Tab><Space>o :<C-u>Tabe  \|
      \exe 'arglocal! '.fnameescape(expand('%'))
      \<Home><C-Right><Right>
noremap <Tab><Space>O :<C-u>-Tabe  \|
      \exe 'arglocal! '.fnameescape(expand('%'))
      \<Home><C-Right><Right>

" noremap <Tab>a :<C-u>tabnew\|arglocal!<Space>
" noremap <Tab>A :<C-u>tabnew\|arglocal!<CR>

nnoremap <Tab>l :<C-u>tabs<CR>
vnoremap <Tab>l :<C-u>tabs\|norm gv<CR>
noremap <Tab><Space>l :filter  tabs<C-Left><Left>

noremap <silent> <Tab>+ :<C-u>tabnew<CR>
noremap <silent> <Tab>- :<C-u>tabclose<CR>
nnoremap <silent> <Tab>! :<C-u>tabonly<CR>
vnoremap <silent> <Tab>! :<C-u>tabonly\|norm gv<CR>
noremap <Tab>b :<C-u>tab<Space>sb<Space>
noremap <Tab>B :<C-u>-tab<Space>sb<Space>

noremap <silent> <Tab>0 :<C-u>tabfirst<CR>
noremap <silent> <Tab>$ :<C-u>tablast<CR>
noremap <Tab>n gt
noremap <Tab>p gT

nnoremap <Tab>m :<C-u>tabm<Space>
vnoremap <Tab>m :<C-u>tabm\|norm gv<Space>
nnoremap <silent> <Tab>N :<C-u>tabm +1<CR>
vnoremap <silent> <Tab>N :<C-u>tabm +1\|norm gv<CR>
nnoremap <silent> <Tab>P :<C-u>tabm -1<CR>
vnoremap <silent> <Tab>P :<C-u>tabm -1\|norm gv<CR>
nnoremap <silent> <Tab>J :<C-u>tabm $<CR>
vnoremap <silent> <Tab>J :<C-u>tabm $\|norm gv<CR>
nnoremap <silent> <Tab>K :<C-u>tabm 0<CR>
vnoremap <silent> <Tab>K :<C-u>tabm 0\|norm gv<CR>

nnoremap <Tab>: :<C-u>tabdo<Space>
vnoremap <Tab>: :<C-u>tabdo  \|norm gv
      \<C-Left><C-Left><Left>

" }}}

" {{{ TODO C refine - resizing with <Tab>

nnoremap <silent> <Tab>>1 :<C-u>vertical resize 10<CR>
vnoremap <silent> <Tab>>1 :<C-u>vertical resize 10\|norm gv<CR>
nnoremap <silent> <Tab>>2 :<C-u>vertical resize 20<CR>
vnoremap <silent> <Tab>>2 :<C-u>vertical resize 20\|norm gv<CR>
nnoremap <silent> <Tab>>3 :<C-u>vertical resize 30<CR>
vnoremap <silent> <Tab>>3 :<C-u>vertical resize 30\|norm gv<CR>
nnoremap <silent> <Tab>>4 :<C-u>vertical resize 40<CR>
vnoremap <silent> <Tab>>4 :<C-u>vertical resize 40\|norm gv<CR>
nnoremap <silent> <Tab>>5 :<C-u>vertical resize 50<CR>
vnoremap <silent> <Tab>>5 :<C-u>vertical resize 50\|norm gv<CR>
noremap <Tab>>r :<C-u>vertical resize <Space>

nnoremap <silent> <Tab>>= :<C-u>vertical resize +1<CR>
vnoremap <silent> <Tab>>= :<C-u>vertical resize +1\|norm gv<CR>
nnoremap <silent> <Tab>>+ :<C-u>vertical resize +5<CR>
vnoremap <silent> <Tab>>+ :<C-u>vertical resize +5\|norm gv<CR>
nnoremap <silent> <Tab>>a :<C-u>vertical resize +10<CR>
vnoremap <silent> <Tab>>a :<C-u>vertical resize +10\|norm gv<CR>
nnoremap <silent> <Tab>>A :<C-u>vertical resize +20<CR>
vnoremap <silent> <Tab>>A :<C-u>vertical resize +20\|norm gv<CR>
nnoremap <silent> <Tab>>- :<C-u>vertical resize -1<CR>
vnoremap <silent> <Tab>>- :<C-u>vertical resize -1\|norm gv<CR>
nnoremap <silent> <Tab>>_ :<C-u>vertical resize -5<CR>
vnoremap <silent> <Tab>>_ :<C-u>vertical resize -5\|norm gv<CR>
nnoremap <silent> <Tab>>d :<C-u>vertical resize -10<CR>
vnoremap <silent> <Tab>>d :<C-u>vertical resize -10\|norm gv<CR>
nnoremap <silent> <Tab>>D :<C-u>vertical resize -20<CR>
vnoremap <silent> <Tab>>D :<C-u>vertical resize -20\|norm gv<CR>

nnoremap <silent> <Tab>^1 :<C-u>resize 10<CR>
vnoremap <silent> <Tab>^1 :<C-u>resize 10\|norm gv<CR>
nnoremap <silent> <Tab>^2 :<C-u>resize 20<CR>
vnoremap <silent> <Tab>^2 :<C-u>resize 20\|norm gv<CR>
nnoremap <silent> <Tab>^3 :<C-u>resize 30<CR>
vnoremap <silent> <Tab>^3 :<C-u>resize 30\|norm gv<CR>
nnoremap <silent> <Tab>^4 :<C-u>resize 40<CR>
vnoremap <silent> <Tab>^4 :<C-u>resize 40\|norm gv<CR>
nnoremap <silent> <Tab>^5 :<C-u>resize 50<CR>
vnoremap <silent> <Tab>^5 :<C-u>resize 50\|norm gv<CR>
noremap <silent> <Tab>^r :<C-u>resize <Space>

nnoremap <silent> <Tab>^= :<C-u>resize +1<CR>
vnoremap <silent> <Tab>^= :<C-u>resize +1\|norm gv<CR>
nnoremap <silent> <Tab>^+ :<C-u>resize +5<CR>
vnoremap <silent> <Tab>^+ :<C-u>resize +5\|norm gv<CR>
nnoremap <silent> <Tab>^a :<C-u>resize +10<CR>
vnoremap <silent> <Tab>^a :<C-u>resize +10\|norm gv<CR>
nnoremap <silent> <Tab>^A :<C-u>resize +20<CR>
vnoremap <silent> <Tab>^A :<C-u>resize +20\|norm gv<CR>
nnoremap <silent> <Tab>^- :<C-u>resize -1<CR>
vnoremap <silent> <Tab>^- :<C-u>resize -1\|norm gv<CR>
nnoremap <silent> <Tab>^_ :<C-u>resize -5<CR>
vnoremap <silent> <Tab>^_ :<C-u>resize -5\|norm gv<CR>
nnoremap <silent> <Tab>^d :<C-u>resize -10<CR>
vnoremap <silent> <Tab>^d :<C-u>resize -10\|norm gv<CR>
nnoremap <silent> <Tab>^D :<C-u>resize -20<CR>
vnoremap <silent> <Tab>^D :<C-u>resize -20\|norm gv<CR>

" }}}

" {{{ buffers with <Space><Space>

noremap <Space><Space>e :<C-u>buffer<Space>
noremap <Space><Space>E :<C-u>buffer!<Space>
noremap <silent> <Space><Space>;e :<C-u>exe
      \'buffer '.(v:count ? v:count : '')<CR>
noremap <silent> <Space><Space>;E :<C-u>exe
      \'buffer! '.(v:count ? v:count : '')<CR>
noremap <Space><Space>s <C-^>
noremap <Space><Space>o :<C-u>edit<Space>
noremap <Space><Space>O :<C-u>edit!<Space>

noremap <silent> <Space><Space>+ :<C-u>enew<CR>
noremap <silent> <Space><Space>- :<C-u>bdelete<CR>
noremap <silent> <Space><Space>;- :<C-u>bdelete!<CR>

nnoremap <Space><Space>l :<C-u>buffers<CR>
vnoremap <Space><Space>l :<C-u>buffers\|norm gv<CR>
nnoremap <Space><Space>L :<C-u>buffers!<CR>
vnoremap <Space><Space>L :<C-u>buffers!\|norm gv<CR>
noremap <Space><Space>;l :<C-u>filter  buffers<C-Left><Left>
noremap <Space><Space>;L :<C-u>filter  buffers!<C-Left><Left>

noremap <silent> <Space><Space>n :<C-u>bnext<CR>
noremap <silent> <Space><Space>p :<C-u>bprevious<CR>
noremap <silent> <Space><Space>N :<C-u>bnext!<CR>
noremap <silent> <Space><Space>P :<C-u>bprevious!<CR>
noremap <silent> <Space><Space>m :<C-u>bmodified<CR>
noremap <silent> <Space><Space>M :<C-u>bmodified!<CR>

noremap <silent> <Space><Space>0 :<C-u>bfirst<CR>
noremap <silent> <Space><Space>0 :<C-u>bfirst!<CR>
noremap <Space><Space>;0 :<C-u>bfirst<Space>
noremap <Space><Space>;0 :<C-u>bfirst!<Space>
noremap <silent> <Space><Space>$ :<C-u>blast<CR>
noremap <silent> <Space><Space>$ :<C-u>blast!<CR>
noremap <Space><Space>;$ :<C-u>blast<Space>
noremap <Space><Space>;$ :<C-u>blast!<Space>

noremap <silent> <Space><Space>d :<C-u>bunload<CR>
noremap <silent> <Space><Space>D :<C-u>bunload!<CR>
noremap <silent> <Space><Space>w :<C-u>bwipeout<CR>
noremap <silent> <Space><Space>W :<C-u>bwipeout!<CR>

noremap <Space><Space>;n :<C-u>bnext<Space>
noremap <Space><Space>;p :<C-u>bprevious<Space>
noremap <Space><Space>;N :<C-u>bnext!<Space>
noremap <Space><Space>;P :<C-u>bprevious!<Space>
noremap <Space><Space>;m :<C-u>bmodified<Space>
noremap <Space><Space>;M :<C-u>bmodified!<Space>

nnoremap <Space><Space>A :<C-u>balt<Space>
vnoremap <Space><Space>A :<C-u>balt  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space><Space>a :<C-u>badd<Space>
vnoremap <Space><Space>a :<C-u>badd  \|norm gv<C-Left><C-Left><Left>
noremap <Space><Space>;d :<C-u>bdelete<Space>
noremap <Space><Space>;D :<C-u>bdelete!<Space>
noremap <Space><Space>;u :<C-u>bunload<Space>
noremap <Space><Space>;U :<C-u>bunload!<Space>
noremap <Space><Space>;w :<C-u>bwipeout<Space>
noremap <Space><Space>;W :<C-u>bwipeout!<Space>

nnoremap <Space><Space>: :<C-u>bufdo<Space>
vnoremap <Space><Space>: :<C-u>bufdo<Space> \|norm gv<C-Left><C-Left><Left>
nnoremap <Space><Space>;: :<C-u>bufdo!<Space>
vnoremap <Space><Space>;: :<C-u>bufdo!  \|norm gv<C-Left><C-Left><Left>

" }}}

" {{{ args with <Space>

nnoremap <Space>l :<C-u>args<CR>
vnoremap <Space>l :<C-u>args\|norm gv<CR>
noremap <Space>;l :<C-u>filter  args<C-Left><Left>

noremap <Space>e :<C-u>Argument<Space>
noremap <Space>E :<C-u>Argument!<Space>
noremap <silent> <Space>;e :<C-u>exe
      \ 'argument '.(v:count ? v:count : '')<CR>
noremap <silent> <Space>;E :<C-u>exe
      \ 'argument! '.(v:count ? v:count : '')<CR>
noremap <Space>o :<C-u>argedit<Space>
noremap <Space>O :<C-u>argedit!<Space>

nnoremap <Space>a :<C-u>argadd<Space>
vnoremap <Space>a :<C-u>argadd  \|norm gv<C-Left><C-Left><Left>
nnoremap <silent> <Space>A :<C-u>argadd\|next<CR>
vnoremap <silent> <Space>A :<C-u>argadd\|next\|norm gv<CR>
nnoremap <Space>d :<C-u>argdelete<Space>
vnoremap <Space>d :<C-u>argdelete  \|norm gv<C-Left><C-Left><Left>
noremap <silent> <Space>D :<C-u>if argc() == 1
      \ \| q
      \ \| elseif argc() == 2
      \ \| argdelete
      \ \| first
      \ \| else
      \ \| argdelete
      \ \| if argidx() == argc() - 1
      \ \| argument 1
      \ \| else
      \ \| next
      \ \| endif
      \ \| endif<CR>

noremap <silent> <Space>n :<C-u>next<CR>
noremap <silent> <Space>N :<C-u>next!<CR>
noremap <Space><Space>n :<C-u>next<Space>
noremap <Space><Space>N :<C-u>next!<Space>
noremap <silent> <Space>p :<C-u>previous<CR>
noremap <silent> <Space>P :<C-u>previous!<CR>
noremap <Space><Space>p :<C-u>previous<Space>
noremap <Space><Space>P :<C-u>previous!<Space>

noremap <silent> <Space>. :<C-u>wnext<CR>
noremap <silent> <Space>> :<C-u>wnext!<CR>
noremap <Space><Space>. :<C-u>wnext<Space>
noremap <Space><Space>> :<C-u>wnext!<Space>
noremap <silent> <Space>, :<C-u>wprevious<CR>
noremap <silent> <Space>< :<C-u>wprevious!<CR>
noremap <Space><Space>, :<C-u>wprevious<Space>
noremap <Space><Space>< :<C-u>wprevious!<Space>

noremap <silent> <Space>0 :<C-u>first<CR>
noremap <silent> <Space>0 :<C-u>first!<CR>
noremap <Space>;0 :<C-u>first<Space>
noremap <Space>;0 :<C-u>first!<Space>
noremap <silent> <Space>$ :<C-u>last<CR>
noremap <silent> <Space>$ :<C-u>last!<CR>
noremap <Space>;$ :<C-u>last<Space>
noremap <Space>;$ :<C-u>last!<Space>

noremap <Space>= :<C-u>args!<Space>
nnoremap <Space>@ :<C-u>argdedupe<CR>
vnoremap <Space>@ :<C-u>argdedupe\|norm gv<CR>
noremap <Space>: :<C-u>argdo<Space>
noremap <Space>;: :<C-u>argdo!<Space>

nnoremap <silent> <Space>ql :<C-u>arglocal<CR>
vnoremap <silent> <Space>ql :<C-u>arglocal\|norm gv<CR>
nnoremap <silent> <Space>qL :<C-u>arglocal!<CR>
vnoremap <silent> <Space>qL :<C-u>arglocal!\|norm gv<CR>
nnoremap <Space>q<Space>l :<C-u>arglocal<Space>
vnoremap <Space>q<Space>l :<C-u>arglocal  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space>q<Space>L :<C-u>arglocal!<Space>
vnoremap <Space>q<Space>L :<C-u>arglocal!  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space>qf :<C-u>exe 'arglocal '.fnameescape(expand('%'))<CR>
vnoremap <Space>qf :<C-u>exe 'arglocal '.fnameescape(expand('%'))\|norm gv<CR>
nnoremap <Space>qF :<C-u>exe 'arglocal! '.fnameescape(expand('%'))<CR>
vnoremap <Space>qF :<C-u>exe 'arglocal! '.fnameescape(expand('%'))\|norm gv<CR>

nnoremap <silent> <Space>qg :<C-u>argglobal<CR>
vnoremap <silent> <Space>qg :<C-u>argglobal\|norm gv<CR>
nnoremap <silent> <Space>qG :<C-u>argglobal!<CR>
vnoremap <silent> <Space>qG :<C-u>argglobal!\|norm gv<CR>
nnoremap <Space>q<Space>g :<C-u>argglobal<Space>
vnoremap <Space>q<Space>g
      \ :<C-u>argglobal  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space>q<Space>G :<C-u>argglobal!<Space>
vnoremap <Space>q<Space>G
      \ :<C-u>argglobal!  \|norm gv<C-Left><C-Left><Left>

nnoremap <Space>qu :<C-u>update<CR>
vnoremap <Space>qu :<C-u>update\|norm gv<CR>
nnoremap <Space>qU :<C-u>update!<CR>
vnoremap <Space>qU :<C-u>update!\|norm gv<CR>
nnoremap <Space><Space>qu :<C-u>update<Space>
vnoremap <Space><Space>qu 
      \ :<C-u>update  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space><Space>qU :<C-u>update!<Space>
vnoremap <Space><Space>qU
      \ :<C-u>update!  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space>q;u :<C-u>update ##<CR>
vnoremap <Space>q;u :<C-u>update ## \|norm gv<CR>
nnoremap <Space>q;U :<C-u>update! ##<CR>
vnoremap <Space>q;U :<C-u>update! ## \|norm gv<CR>

" }}}

" {{{ splits with <Tab>

noremap <Tab>sv :<C-u>vsplit<Space>
noremap <Tab>ss :<C-u>split<Space>
noremap <Tab>sd :<C-u>botright split<Space>
noremap <Tab>sr :<C-u>botright vsplit<Space>

" Doesn't work
" noremap <Space>sv :<C-u>Vargument<Space>
" noremap <Space>ss :<C-u>Hargument<Space>
" noremap <Space>sd :<C-u>Dargument<Space>
" noremap <Space>sr :<C-u>Rargument<Space>

" }}}

" {{{ <Space> list and help

nnoremap <Space>ie :<C-u>oldfiles<CR>
vnoremap <Space>ie :<C-u>oldfiles\|norm gv<CR>
nnoremap <Space>ir :<C-u>registers<CR>
vnoremap <Space>ir :<C-u>registers\|norm gv<CR>
nnoremap <Space>ip :<C-u>history<CR>
vnoremap <Space>ip :<C-u>history\|norm gv<CR>
nnoremap <Space>ic :<C-u>changes<CR>
vnoremap <Space>ic :<C-u>changes\|norm gv<CR>
nnoremap <Space>ij :<C-u>jumps<CR>
vnoremap <Space>ij :<C-u>jumps\|norm gv<CR>
nnoremap <Space>io :<C-u>files<CR>
vnoremap <Space>io :<C-u>files\|norm gv<CR>
nnoremap <Space>im :<C-u>marks<CR>
vnoremap <Space>im :<C-u>marks\|norm gv<CR>
nnoremap <Space>ig :<C-u>marks ABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>
vnoremap <Space>ig :<C-u>marks ABCDEFGHIJKLMNOPQRSTUVWXYZ\|norm gv<CR>

noremap <Space>i<Space>e
      \:<C-u>filter  oldfiles<C-Left><Left>
noremap <Space>i<Space>r
      \:<C-u>filter  registers<C-Left><Left>
noremap <Space>i<Space>p
      \:<C-u>filter  history<C-Left><Left>
noremap <Space>i<Space>c
      \:<C-u>filter  changes<C-Left><Left>
noremap <Space>i<Space>j
      \:<C-u>filter  jumps<C-Left><Left>
noremap <Space>i<Space>o
      \:<C-u>filter  files<C-Left><Left>
noremap <Space>i<Space>m
      \:<C-u>filter  marks<C-Left><Left>

nnoremap <Space>ikk :<C-u>map<Space>
vnoremap <Space>ikk :<C-u>map  \|norm gv
      \<C-Left><C-Left><Left>
nnoremap <Space>ikn :<C-u>nmap<Space>
vnoremap <Space>ikn :<C-u>nmap  \|norm gv
      \<C-Left><C-Left><Left>
nnoremap <Space>ikv :<C-u>vmap<Space>
vnoremap <Space>ikv :<C-u>vmap  \|norm gv
      \<C-Left><C-Left><Left>
nnoremap <Space>iki :<C-u>imap<Space>
vnoremap <Space>iki :<C-u>imap  \|norm gv
      \<C-Left><C-Left><Left>
nnoremap <Space>ikc :<C-u>cmap<Space>
vnoremap <Space>ikc :<C-u>cmap  \|norm gv
      \<C-Left><C-Left><Left>

nnoremap <space>i<space>n :g//#<Left><Left>
vnoremap <space>i<space>n :g//#\|norm gv
      \ <Home><Right><Right>

noremap <Space>ih :<C-u>help<Space>
" noremap <C-w><Space>ih :<C-u>tab help<Space>
noremap <Tab>h :<C-u>tab help<Space>

" }}}

" {{{ <Space> operations

nnoremap <Space>iJ :<C-u>clearjumps<CR>
vnoremap <Space>iJ :<C-u>clearjumps\|norm gv<CR>

nnoremap <Space>;m :move<Space>
noremap <Space>_ "_d

" }}}

" {{{ other mappings

" Select whole buffer without plugins
vnoremap ae gg0oG$
nnoremap yae gg0vG$y`'

" }}}

" {{{ settings

" {{{ completion

set wildchar=<Tab>
set wildmode=list:longest,full
set wildoptions=fuzzy,tagfile,pum
set wildmenu
set wildignore+=*.o,*.elf,*.bin,*.dll,*.so

set complete=w,b,s,i,d,t,.,k
set completeopt=menu,menuone,noselect,noinsert,preview

" }}}

" {{{ display

" set terse
set ruler
set number
set relativenumber

set showcmd
set showmode
set showmatch
set nohlsearch
" set textwidth=72

" }}}

" {{{ search

set history=10000
set incsearch
set ignorecase
set smartcase

" }}}

" {{{ indent

set autoindent
set cindent
set expandtab
set shiftwidth=4
set tabstop=4
set breakindent

" }}}

" {{{ ui

set linebreak

set nowrap
set showbreak=\\>\ 
set wrapmargin=1

set notimeout
set ttimeout
set ttimeoutlen=100

set mouse=a
" set clipboard=unnamed
set clipboard=

set switchbuf+=usetab,useopen

" }}}

" {{{ editing

set formatoptions=tcroqlwn

" Neovim default setting at time of writing this
set backspace=indent,eol,start

set undolevels=10000

" }}}

" {{{ other

set noautoread
set noautochdir
set termencoding=utf-8

set modelines=3
set nomodeline
set hidden

set cedit=<C-j>
set cmdwinheight=30

" }}}

" {{{ files

set encoding=utf-8
set fileformat=unix

" }}}

" }}}

if v:progname =~? "^tv\\(im\\?\\)\\?"
      \ || v:progname =~? "^vim.tiny" " {{{
  set background=dark
  set hlsearch
  set secure
  set modeline

  nnoremap ,<Space><Space> :setlocal hls!<CR>
  vnoremap ,<Space><Space> :setlocal hls!\|norm gv<CR>
  nnoremap ,qeh :<C-u>set hls!<CR>
  vnoremap ,qeh :<C-u>set hls!\|norm gv<CR>

  map <C-p> ,
    " = gets tricked by this comma
  map <C-n> ;
endif " }}}

if v:progname =~? "^sv\\(im\\?\\)\\?" " {{{
  silent! set completeopt+=fuzzy,fuzzycollect
endif " }}}
