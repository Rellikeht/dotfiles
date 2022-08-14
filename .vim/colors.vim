" Vim color file

set background=dark
"hi clear
if exists("syntax_on")
  syntax reset
endif

hi Normal	guifg=#18388c	guibg=#01080b
hi NonText	guifg=yellow	guibg=#0f0f0f
hi Comment	guifg=#a0a0a0	guibg=#1f1f1f	gui=italic
hi Constant	guifg=#18ea4f	gui=bold

hi Identifier	guifg=#02aacd	gui=NONE
hi Statement	guifg=#a014c8	gui=NONE
hi Conditional	guifg=#a014c8	gui=NONE
hi Repeat	guifg=#a014c8	gui=NONE
hi Type		guifg=#a82070	gui=bold

hi Preproc	guifg=#0c8bd0
hi Label	guifg=#ffcf2f
hi Operator	guifg=#d8e000
hi Special	guifg=#c48214

hi ErrorMsg	guifg=#bf1a18	guibg=#051018
hi WarningMsg	guifg=#101f2f	guibg=#18ea4f
hi Error	guifg=#bf1a18	guibg=#100d08
hi Warning	guifg=#d8e000	guibg=#100d08

hi Cursor	guifg=#00ff00	guibg=#60a060 
hi CursorLine	guibg=#0e1224
hi Search	guifg=#010d08	guibg=#4f5f6f	gui=bold 
hi IncSearch	guifg=#032a1a	guibg=#02aacd	gui=NONE
hi LineNr	guifg=#c2dcd2
"Numbers in tabs
hi Title	guifg=#101f2f	guibg=#c2dcd2

hi TabLine	guifg=#08caca	guibg=#101f2f
hi TabLineFill	guifg=#000000	guibg=#043221
hi TabLineSel	guifg=cyan	guibg=darkblue	gui=bold

hi Todo		guifg=#ffcf2f	guibg=#0e1224
hi ShowMarksHL	guifg=#d8e000	guibg=black	gui=bold
hi StatusLineNC	guifg=#c2dcd2	guibg=#405060	gui=NONE	
hi StatusLine	guifg=cyan	guibg=darkblue	gui=bold	
hi clear Visual
hi Visual	term=reverse cterm=reverse gui=reverse
hi ModeMsg	guifg=#04a0dc
hi SignColumn	guibg=#0e1224
hi Vertsplit	guifg=#061040

hi WildMenu	guifg=lime	guibg=#01080b
hi Pmenu	guifg=#18ea4f	guibg=#304050
hi PmenuSel	guifg=cyan	guibg=#101f2f
hi PmenuSbar	guibg=#202020
hi PmenuThumb	guibg=cyan
