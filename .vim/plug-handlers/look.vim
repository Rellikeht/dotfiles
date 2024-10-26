" rainbow {{{ 
" TODO B make this better

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
      \   },
      \   'css': 0,
      \ }
      \}

" }}} 

" quick-scope {{{ 

let g:qs_hi_priority = 2

let g:qs_lazy_highlight = 1

" quick scope delay
let g:qs_delay = 30

" Trigger a highlight in the appropriate direction when pressing these keys:
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" }}} 

" signature {{{ 

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

" }}} 

" vim-highlighter {{{ 

" TODO C external grep tools
" let s:hft = 0
" function s:HiToolToggle()
"   if s:hft
"     let HiFindTool = g:grep.' -r'
"   endif
" endfunction
" call <SID>HiToolToggle()
" noremap ,ht :<C-u>call <SID>HiToolToggle()<CR>

" let HiFindTool = 'rg --color=never -H --no-heading --column'
"       \ .' --smart-case --hidden'
" let HiFindTool = 'ag --nocolor --noheading --column'.
"       \ ' --nobreak --smart-case --hidden'
let HiFindTool = g:grep.' -r'

noremap ,hc :<C-u>Hi<Space>
noremap ,hw :<C-u>Hi <><CR>
noremap ,hl :<C-u>Hi >><CR>

noremap <expr> <silent> ,hk ':<C-u>'.v:count1.'Hi{<CR>'
noremap <expr> <silent> ,hj ':<C-u>'.v:count1.'Hi}<CR>'
noremap <expr> <silent> ,hp ':<C-u>'.v:count1.'Hi<<CR>'
noremap <expr> <silent> ,hn ':<C-u>'.v:count1.'Hi><CR>'
noremap <expr> <silent> ,hP ':<C-u>'.v:count1.'Hi[<CR>'
noremap <expr> <silent> ,hN ':<C-u>'.v:count1.'Hi]<CR>'

noremap <silent> ,h/ :<C-u>Hi//<CR>
noremap <silent> ,hw :<C-u>Hi/open<CR>
noremap <silent> ,hc :<C-u>Hi/close<CR>

noremap <expr> <silent> ,ho ':<C-u>'.v:count1.'Hi/older<CR>'
noremap <expr> <silent> ,hi ':<C-u>'.v:count1.'Hi/never<CR>'
noremap <expr> <silent> ,hf ':<C-u>'.v:count1.'Hi/next<CR>'
noremap <expr> <silent> ,hb ':<C-u>'.v:count1.'Hi/previous<CR>'

noremap <silent> ,h= :<C-u>Hi=<CR>
noremap <silent> ,ht :<C-u>Hi==<CR>
noremap <silent> ,hT :<C-u>Hi===<CR>

" }}} 

" info {{{ 

noremap <Leader>imc :<C-u>Info<Space>
noremap <Leader>imu :<C-u>exe 'Info '.expand('<cword>')<CR>
noremap <Leader>imw :<C-u>exe 'Info '.expand('<cWORD>')<CR>
noremap <Leader>imf :<C-u>exe 'Info '.expand('<cfile>')<CR>

noremap <Leader>imm :<C-u>Menu<CR>
noremap <Leader>im<Space>m :<C-u>Menu<Space>
noremap <Leader>imo :<C-u>Follow<CR>
noremap <Leader>im<Space>o :<C-u>Follow<Space>
noremap <Leader>img :<C-u>GotoNode<CR>
noremap <Leader>im<Space>g :<C-u>GotoNode<Space>
noremap <Leader>imi :<C-u>Index<CR>
noremap <Leader>im<Space>i :<C-u>Index<Space>

noremap <Leader>in :<C-u>InfoNext<CR>
noremap <Leader>ip :<C-u>InfoPrev<CR>
noremap <Leader>iu :<C-u>InfoUp<CR>

cnoreabbrev info Info

" }}} 

" other {{{ 

let g:wheel#line#threshold = 2*&scrolloff " lines from start or end

let g:accelerated_jk_acceleration_limit = 250
let g:accelerated_jk_enable_deceleration = 1
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" }}} 
