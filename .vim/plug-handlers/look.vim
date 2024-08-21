"{{{ rainbow
" TODO C clean this

let g:rainbow_active = 1
let g:rainbow_conf = {
      \ 'guifgs':
      \   ['royalblue3',
      \   'darkorange3',
      \   'seagreen3',
      \   'firebrick'
      \   ],
      \ 'ctermfgs':
      \   ['blue',
      \   'lightyellow',
      \   'lightcyan',
      \   'lightmagenta'
      \   ],
      \ 'guis': [''],
      \ 'cterms': [''],
      \ 'operators': '_,_',
      \ 'parentheses':
      \   ['start=/(/ end=/)/ fold',
      \   'start=/\[/ end=/\]/ fold',
      \   'start=/{/ end=/}/ fold'
      \   ],
      \ 'separately': {
      \   '*': {},
      \   'markdown': {
      \     'parentheses_options':
      \     'containedin=markdownCode contained',
      \   },
      \   'lisp': {
      \     'guifgs':
      \       ['royalblue3',
      \       'darkorange3',
      \       'seagreen3',
      \       'firebrick',
      \       'darkorchid3'
      \       ],
      \   },
      \   'haskell': {
      \     'parentheses':
      \       ['start=/(/ end=/)/ fold',
      \       'start=/\[/ end=/\]/ fold',
      \       'start=/\v\{\ze[^-]/ end=/}/ fold'
      \       ],
      \   },
      \   'vim': {
      \     'parentheses_options':
      \     'containedin=vimFuncBody',
      \   },
      \   'perl': {
      \     'syn_name_prefix':
      \     'perlBlockFoldRainbow',
      \   }
      \ }
      \}

" }}}

"{{{ quick-scope

let g:qs_hi_priority = 2

let g:qs_lazy_highlight = 1

" quick scope delay
let g:qs_delay = 30

" Trigger a highlight in the appropriate direction when pressing these keys:
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"}}}

"{{{ signature

let g:SignatureEnabledAtStartup = 1

noremap <silent> <Leader>qst
      \ :<C-u>SignatureToggleSigns<CR>
noremap <silent> <Leader>qsr 
      \ :<C-u>SignatureRefresh<CR>

noremap <silent> <Leader>qsl
      \ :<C-u>exe 'SignatureListBufferMarks '
      \ .v:count1<CR>
noremap <silent> <Leader>qsg
      \ :<C-u>exe 'SignatureListGlobalMarks '
      \ .v:count1<CR>

"}}}

"{{{ other

"}}}
