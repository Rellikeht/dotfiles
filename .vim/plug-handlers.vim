let g:zig_fmt_autosave = 0
let g:rainbow_active = 1

" for quick scope to activate with delay
let g:qs_delay = 50

" vim-sneak
let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
map - <Plug>Sneak_,
map + <Plug>Sneak_;

" TODO A check
nmap <silent> ; <Plug>(cosco-commaOrSemiColon)
imap <silent> <C-;> <C-o><Plug>(cosco-commaOrSemiColon)

" - Type sab to move the cursor immediately to the next
"   instance of the text "ab".
" Additional matches, if any, are highlighted until the cursor is moved.
" - Type ; to go to the next match (or s again, if s_next is enabled;
"   see :help sneak).
" - Type 3; to skip to the third match from the current position.
" - Type ctrl-o or `` to go back to the starting point.
" This is a built-in Vim motion; Sneak adds to Vim's jumplist only on s
" invocation—not repeats—so you can abandon a trail of ; or ,
" by a single ctrl-o or ``.
" - Type s<Enter> at any time to repeat the last Sneak-search.
" - Type S to search backwards.
" Sneak can be limited to a vertical scope by prefixing s with a count.
" 
" - Type 5sxy to go immediately to the next instance of "xy" within
"   5 columns of the cursor.
" Sneak is invoked with operators via z (because s is taken by surround.vim).
" 
" - Type 3dzqt to delete up to the third instance of "qt".
" - Type . to repeat the 3dzqt operation.
" - Type 2. to repeat twice.
" - Type d; to delete up to the next match.
" - Type 4d; to delete up to the fourth next match.
" - Type yszxy] to surround in brackets up to xy.
" - Type . to repeat the surround operation.
" - Type gUz\} to upper-case the text from the cursor until
"   the next instance of the literal text \}
" - Type . to repeat the gUz\} operation.

" TODO, but it takes much time with colors
" it is copied from repos README
"\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
"\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
"\		'lisp': {
"\		'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],

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
