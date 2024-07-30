" TODO A test :)

"{{{ settings

" TODO B what to do here
" if has('nvim')
"   let s:suitetest = 'neovim'
" else
"   let s:suitetest = 'tslime'
" endif

" TODO A how to set this differently
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
let g:tslime = {'pane': '{down-right}'}

let test#strategy = {
  \ 'nearest': 'dispatch',
  \ 'file':    'make',
  \ 'suite':   'tslime',
\}

let g:test#preserve_screen = 1

"}}}

"{{{ maps

nmap <silent> <Leader>d;n :TestNearest<CR>
nmap <silent> <Leader>d;f :TestFile<CR>
nmap <silent> <Leader>d;s :TestSuite<CR>
nmap <silent> <Leader>d;l :TestLast<CR>
nmap <silent> <Leader>d;v :TestVisit<CR>

"}}}
