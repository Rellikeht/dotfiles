if v:progname =~? "^s\\?v\\(im\\?\\)\\?"
  colorscheme industry
endif

hi CursorLine ctermbg=237 guibg=#4a4a4a cterm=none gui=none
hi CursorLineNr ctermbg=237 guibg=#404040 cterm=none gui=none

hi DiffAdd
            \ ctermfg=LightGray ctermbg=DarkGreen
            \ guifg=#d0d0d0 guibg=#0f9620
hi DiffText
            \ ctermfg=Black ctermbg=Gray
            \ guifg=#000000 guibg=#c6c6c6
hi DiffChange
            \ ctermfg=White ctermbg=DarkBlue
            \ guifg=#d0d0d0 guibg=#0f1a7f
hi DiffDelete
            \ ctermfg=LightGray ctermbg=DarkRed
            \ guifg=#d0d0d0 guibg=#cf0820
