" rainbow

let g:rainbow_active = 1
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
