" Vim color file

"hi clear
if exists("syntax_on")
	syntax reset
endif

autocmd BufNewFile,BufRead *.h setlocal background=light
autocmd FileType sh setlocal background=light
autocmd FileType haskell colorscheme elflord

" ========================
"	PROGRAMMING

" TODO {
"	variable names not colored in haskell and c;
"	haskell and c functions aren't colored;
"	variables are colored in go as special;
"	functions from libraries are colored as types in go;
"	c coloring is really far from perfect;
"	c macros;
"	differentiate statements;
"	}

"	Text
hi Normal	guifg=#18388c	guibg=#01080b
hi NonText	guifg=#ffff00	guibg=#0f0f0f
hi Comment	guifg=#a0a0a0	guibg=#1f1f1f	gui=italic

"	Constant
hi Constant	guifg=#017f30	gui=bold "TODO prettier color
"hi Constant	guifg=#0b6868	gui=bold
" String, Character, Number, Boolean, Float

"	Identifier
"hi Identifier	guifg=#18ea4f	gui=NONE
hi Identifier	guifg=#900a12	gui=NONE
hi Function	guifg=#c2dcd2	gui=NONE

"	Statements
hi Statement	guifg=#a014c8	gui=NONE

hi Conditional	guifg=#a014c8	gui=NONE
hi Repeat	guifg=#08caca	gui=NONE
hi Operator	guifg=#d8e000
"hi Label	guifg=#ffcf2f
hi Label	guifg=#00ff00
hi Keyword	guifg=#a014c8	gui=NONE
hi Exception	guifg=#bf1a18	guibg=#100d08

"	Special
hi Special	guifg=#c48214
" TODO
"hi Debug	guifg=#ff0000
"hi SpecialComment	guifg=#ff0000
"hi SpecialChar	guifg=#c48214
"hi Delimiter	guifg=#ff00ff

"	Type Signature
hi Type		guifg=#a82070	gui=bold
hi Structure	guifg=#a82070	gui=bold	"TODO
hi Typedef	guifg=#a82070	gui=bold	"TODO
"StorageClass

"	Macros
hi Preproc	guifg=#0c8bd0
"Include, Define, Macro, PreCondit

" ========================
"	EDITOR

"	Commands
hi ErrorMsg	guifg=#bf1a18	guibg=#051018
hi WarningMsg	guifg=#101f2f	guibg=#18ea4f
hi WildMenu	guifg=#00ff00	guibg=#01080b

"	Cursor
hi Cursor	guifg=#00ff00	guibg=#60a060 
hi CursorLine	guibg=#0e1224
hi Search	guifg=#010d08	guibg=#4f5f6f	gui=bold 
hi IncSearch	guifg=#032a1a	guibg=#02aacd	gui=NONE

hi Todo		guifg=#ffcf2f	guibg=#0e1224	gui=bold
hi ShowMarksHL	guifg=#d8e000	guibg=#000000	gui=bold
hi clear Visual
hi Visual	term=reverse cterm=reverse gui=reverse
hi ModeMsg	guifg=#04a0dc

"	Completion
hi Pmenu	guifg=#18ea4f	guibg=#304050
hi PmenuSel	guifg=#00ffff	guibg=#101f2f
hi PmenuSbar	guibg=#202020
hi PmenuThumb	guibg=#00ffff

"	Lines
hi Vertsplit	guifg=#061040
hi StatusLineNC	guifg=#c2dcd2	guibg=#405060	gui=NONE	
hi StatusLine	guifg=#00ffff	guibg=#0000ff	gui=bold	

"	Side
hi SignColumn	guibg=#0e1224
hi LineNr	guifg=#c2dcd2
hi Error	guifg=#bf1a18	guibg=#100d08
" Idk if it has any effect
hi Warning	guifg=#d8e000	guibg=#100d08

"	Tabs
"Numbers in tabs
hi Title	guifg=#101f2f	guibg=#c2dcd2
hi TabLine	guifg=#08caca	guibg=#101f2f
hi TabLineFill	guifg=#000000	guibg=#043221
hi TabLineSel	guifg=#00ffff	guibg=#0000ff	gui=bold

if v:progname =~? ".*svi.*"
	colorscheme default
	"autocmd FileType ocaml colorscheme default
	"autocmd FileType ocaml setlocal background=dark
	"autocmd FileType go colorscheme default
	"autocmd FileType go setlocal background=dark
	"autocmd FileType c colorscheme default
	"autocmd FileType c setlocal background=dark
	"autocmd FileType cpp colorscheme default
	"autocmd FileType cpp setlocal background=dark
endif

set background=dark
