" VIM-SNEAK

let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
map - <Plug>Sneak_,
map + <Plug>Sneak_;

"nmap <silent> ; <Plug>(cosco-commaOrSemiColon)
imap <silent> <C-;> <C-o><Plug>(cosco-commaOrSemiColon)

" SPEEDDATING

au VimEnter * SpeedDatingFormat %d %b %Y
au VimEnter * SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M:%S %z
au VimEnter * SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M:%S%?[Z]
au VimEnter * SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M%z
au VimEnter * SpeedDatingFormat %d-%m-%Y%[ T_-]%H:%M
au VimEnter * SpeedDatingFormat %d-%m-%Y
au VimEnter * SpeedDatingFormat %a %_d %b %H:%M:%S %Z %Y
au VimEnter * SpeedDatingFormat %a %-d %h %H:%M:%S %Y %z
au VimEnter * SpeedDatingFormat %_d %h %H:%M:%S
au VimEnter * SpeedDatingFormat %d %b, %Y

" RAINBOW

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

" VIMTEX

" Viewer options: One may configure the viewer either by specifying a built-in
let g:vimtex_view_method = 'zathura'
" Works
let g:vimtex_compiler_method = 'latexmk'

" Also workWorkss
"let g:vimtex_compiler_method = 'tectonic'

" OTHERS

" for quick scope to activate with delay
let g:qs_delay = 50

let g:zig_fmt_autosave = 1
