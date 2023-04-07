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

" for quick scope to activate with delay
let g:qs_delay = 50
