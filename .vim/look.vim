" colors {{{ 

if !has("nvim")
  colorscheme torte "industry
endif

hi CursorLine ctermbg=237 guibg=#2c2c2c cterm=none gui=none
hi CursorLineNr ctermbg=237 guibg=#3a3a3a cterm=none gui=none

hi DiffAdd
            \ ctermbg=DarkGreen guibg=#0d5826
            \ ctermfg=NONE guifg=NONE
hi DiffText
            \ ctermbg=Gray guibg=#566670
            \ ctermfg=NONE guifg=NONE
hi DiffChange
            \ ctermbg=DarkBlue guibg=#0f1a7f
            \ ctermfg=NONE guifg=NONE
hi DiffDelete
            \ ctermbg=DarkRed guibg=#800620
            \ ctermfg=NONE guifg=NONE

" }}} 

" {{{ 

" Syntax for undetected files
autocmd BufNewFile,BufRead */.xmodmap/* set syntax=xmodmap
autocmd BufNewFile,BufRead .xbindkeys* set syntax=scheme

autocmd syntax * syntax match Operator /[.]/

" }}} 
