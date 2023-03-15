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

set wildchar=<Tab>
set wildmode=longest,list,full
set wildmenu
set noterse

" hybrid line numbers, my favourite
set number relativenumber
set nu rnu

" searching
set ignorecase
set smartcase

set mouse=a
set shiftwidth=4
set softtabstop=4

set noar
"autocmd BufRead,BufNewFile */dzielone/* setlocal autoread

" I have probably the most minimalistic vim possible
" from Artix/Arch repositories (vim-tiny package),
" vim compiled with only features i need (binary is
" called svim for distinction) and neovim (also from repos)
" as small ide. This config is read by all of them, because
" some parts are common, so i needed to do this:
if v:progname !~? "^vi"
	" AND THIS ISN'T PROBABLY GOOD IDEA

	silent! source ~/.vim/vars.vim

	nnoremap <Space> :set hls!<CR>
	"nnoremap <CR> :set hls!<CR>

	set showcmd
	set cursorline
	set showmatch
	set ruler
	set incsearch
	set hlsearch

	filetype plugin on
	filetype indent on
	syntax on
	"silent! source ~/.vim/colors.vim
	"silent! source ~/.vim/syntax.vim
	source ~/.vim/colors.vim
	source ~/.vim/syntax.vim

	" Attempt to make vim easier to use
	" in workman layout, with preserving
	" logic (eg. d for delete, e for end...)
	let s:lay="qwe"
	function! Wmt()
		if s:lay =~? "wkm"
			source ~/.vim/qwerty.vim
			let s:lay="qwe"
		else
			source ~/.vim/workman.vim
			let s:lay="wkm"
		endif
	endfunction

	" Mapping motion in workman layout to be more
	" 'normal' and cleaning keys messed in the process
	" y n e o are h j k l
	" and second time
	" and h j k l are e y n o
	map <C-s> :call Wmt()<CR>

	if v:progname =~? ".*svi.*"
		call plug#begin('~/.vim/plugged')
		Plug 'mbbill/undotree'
		Plug 'junegunn/fzf'
		Plug 'unblevable/quick-scope'
		"Plug 'kmonad/kmonad-vim'

		"saddly has problems
		"Plug 'easymotion/vim-easymotion'
		Plug 'justinmk/vim-sneak'
		" TODO all commands
		Plug 'tpope/vim-repeat'
		" TODO all commands
		Plug 'tpope/vim-surround'
		Plug 'tpope/vim-speeddating'
		Plug 'tpope/vim-commentary'
		Plug 'tpope/vim-eunuch'

		" TODO check
		Plug 'WolfgangMehner/bash-support'
		Plug 'zah/nim.vim'
		Plug 'ziglang/zig.vim'
		Plug 'luochen1990/rainbow'
		Plug 'lilydjwg/colorizer'
		Plug 'maxboisvert/vim-simple-complete'
		Plug 'WolfgangMehner/vim-support'
		call plug#end()

		" TODO, but it takes much time with colors
		" it is copied from repos README
"		\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
"		\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
"		\		'lisp': {
"		\		'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],

		let g:rainbow_conf = {
		\	'guifgs':
		\		['royalblue3',
		\		'darkorange3',
		\		'seagreen3',
		\		'firebrick'
		\		],
		\	'ctermfgs':
		\		['blue',
		\		'lightyellow',
		\		'lightcyan',
		\		'lightmagenta'
		\		],
		\	'guis': [''],
		\	'cterms': [''],
		\	'operators': '_,_',
		\	'parentheses':
		\		['start=/(/ end=/)/ fold',
		\		'start=/\[/ end=/\]/ fold',
		\		'start=/{/ end=/}/ fold'
		\		],
		\	'separately': {
		\		'*': {},
		\		'markdown': {
		\			'parentheses_options':
		\			'containedin=markdownCode contained',
		\		},
		\		'lisp': {
		\			'guifgs':
		\				['royalblue3',
		\				'darkorange3',
		\				'seagreen3',
		\				'firebrick',
		\				'darkorchid3'
		\				],
		\		},
		\		'haskell': {
		\			'parentheses':
		\				['start=/(/ end=/)/ fold',
		\				'start=/\[/ end=/\]/ fold',
		\				'start=/\v\{\ze[^-]/ end=/}/ fold'
		\				],
		\		},
		\		'vim': {
		\			'parentheses_options':
		\			'containedin=vimFuncBody',
		\		},
		\		'perl': {
		\			'syn_name_prefix':
		\			'perlBlockFoldRainbow',
		\		}
		\	}
		\}

		" for quick scope to activate with delay
		let g:qs_delay = 50

		let g:zig_fmt_autosave = 0

	endif

	let g:rainbow_active = 1
	let g:colorizer_maxlines = 500

	" vim-sneak
	let g:sneak#label = 1
	map f <Plug>Sneak_f
	map F <Plug>Sneak_F
	map t <Plug>Sneak_t
	map T <Plug>Sneak_T
	map - <Plug>Sneak_,
	map + <Plug>Sneak_;

	" - Type sab to move the cursor immediately to the next instance of the text "ab".
	" Additional matches, if any, are highlighted until the cursor is moved.
	" - Type ; to go to the next match (or s again, if s_next is enabled; see :help sneak).
	" - Type 3; to skip to the third match from the current position.
	" - Type ctrl-o or `` to go back to the starting point.
	" This is a built-in Vim motion; Sneak adds to Vim's jumplist only on s
	" invocation—not repeats—so you can abandon a trail of ; or , by a single ctrl-o or ``.
	" - Type s<Enter> at any time to repeat the last Sneak-search.
	" - Type S to search backwards.
	" Sneak can be limited to a vertical scope by prefixing s with a count.
        " 
	" - Type 5sxy to go immediately to the next instance of "xy" within 5 columns of the cursor.
	" Sneak is invoked with operators via z (because s is taken by surround.vim).
        " 
	" - Type 3dzqt to delete up to the third instance of "qt".
	" - Type . to repeat the 3dzqt operation.
	" - Type 2. to repeat twice.
	" - Type d; to delete up to the next match.
	" - Type 4d; to delete up to the fourth next match.
	" - Type yszxy] to surround in brackets up to xy.
	" - Type . to repeat the surround operation.
	" - Type gUz\} to upper-case the text from the cursor until the next instance of the literal text \}
	" - Type . to repeat the gUz\} operation.


	"" easymotion
	"let g:EasyMotion_do_mapping = 0 " Disable default mappings
	"let mapleader = ','
	"" <Leader>f{char} to move to {char}
	"map  <Leader>f <Plug>(easymotion-bd-f)
	"nmap <Leader>f <Plug>(easymotion-overwin-f)
	"
	"" s{char}{char} to move to {char}{char}
	"map s <Plug>(easymotion-overwin-f2)
	""nmap s <Plug>(easymotion-overwin-f2)
	"
	"" Move to line
	"map <Leader>l <Plug>(easymotion-bd-jk)
	"nmap <Leader>l <Plug>(easymotion-overwin-line)
	"
	"" Move to word
	"map  <Leader>w <Plug>(easymotion-bd-w)
	"nmap <Leader>w <Plug>(easymotion-overwin-w)

endif

silent! source .vimrc.local
