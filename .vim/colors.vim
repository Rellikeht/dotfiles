
" if exists("syntax_on")
" 	syntax reset
" endif

if v:progname =~? ".*svi.*"
    " colorscheme default
    colorscheme industry
endif

hi CursorLine ctermbg=237 guibg=#505050 cterm=none gui=none
hi CursorLineNr ctermbg=237 guibg=#404040 cterm=none gui=none
