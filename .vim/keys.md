# About

This file is trial to describe all mappings and keep available
keys in one place. With hundreds of mappings it is necessary

# Unused keys

\\ | ~ ^ (hard to reach on some keyboards) _ (painful in greater
amounts) There may be more, but there are already enough
combinations

# <Tab> combinations

- They are general purpose, mainly for tab management
- List is incomplete

## TODO

- make this better

## Tabs

- <Tab> - :tab<Space>
- e - :tab<Space>sb<Space>
- E - :-tab<Space>sb<Space>
- d - :tabclose<CR>
- h - gT
- H - :tabm -1<CR>
- j - :tablast<CR>
- J - :tabm $<CR>
- k - :tabfirst<CR>
- K - :tabm 0<CR>
- l - gt
- L - :tabm +1<CR>
- m - :tabm<Space>
- t - :tabedit<Space>
- T - :-tabedit<Space>
- O - :tabnew<CR>

## Buffers

- a - :bad<Space>
- A - :balt<Space>
- b - :buffer<Space>
- c - :bmodified<CR>
- C - :bmodified!<CR>
- D - :bdelete<CR>
- n - :bnext<CR>
- N - :bnext!<CR>
- p - :bprevious<CR>
- P - :bprevious!<CR>
- U - :bunload<CR>

## Miscelanous

- r - redraw command
- w - toggle wrap
- y - in normal paste, in visual copy to X11 clipboard
- Y - like ;y, but using X11 primary
- Q - source %
- M - setlocal modeline!
- i - some info
- ^, > - resizing windows

# Leader (,) combinations

## Simple mappings

- q - miscelanous, settings:

  - ff,fF - toggle formatting on write
  - fc,fC - compiling on write
  - v0,v1,v2,...,v9 - print variables
  - pm - man program
  - pM - set make program to make
  - eb - editorconfig toggle for buffer
  - eg - editorconfig toggle globally
  - er - editorconfig reload
  - en, eN - line numbering
  - kw - toggle workman layout help
  - m - man/help opening location

- <Space> - set hls!

- ; - commands

- f - diff operations

- x, X - netrw

## Code

- c, C - compiling
- r, R - running
- b, B - building
- i, I - running interpreted versions of compiled languages

## With plugins

- t - tmux

- g - git

  - s,j,k (every possible casing) - signify
  - v,V,? - gv
  - others - fugitive

- s - fzf

- n - unicode, nuuid

- u - undo tree, tinyMRU, obsession

<!-- ?? -->

<!-- - F - code formatting -->

- E,T,S,V - tinyMRU

- q misc again:

  - u - general plug upgrade
  - P - plug clean
  - cp - toggle context until move
  - ct - toggle context
  - cw - toggle context in current window
  - de - edit envrc
  - dE - edit direnvrc
  - dl - direnv load

## Nvim only

- d - lspconfig diagnostics and lsp actions
- <Leader> - easymotion ; TODO
- e, E, D - code plugins ; NOT IMPLEMENTED
- h - harpoon ; NOT IMPLEMENTED

# g combinations

Available (useless otherwise): C, G, K, L, z

Rather useless: I, Q, H, h, r, w

Rather useful: J, M, N, V, m, n

- c - vim-commentary
- C - toggle colorizer
- S - vim-surround
- a - unicode
- A - radical.vim
- y,Y - "\*y,"+y
- s - vim-slime and similar
- "+" - v<C-a>
- "-" - v<C-x>

## Nvim only

- l - mdeval, femaco

# z combinations

Available (unused): B, I, J, K, Q, S, T, U, V, Y, Z q All
special characters, besides: +, -, ., =, <CR>, numbers

- S - sleep

## Nvim only

- (something with z probably) - zen-mode ; NOT IMPLEMENTED

# Z combinations

Only Z and Q is used

# c combinations

## TODO

- r\[dxob\] - radical.vim

# "\[" and "\]"

## TODO

# Miscelanous

- Space - <C-w>
- ae - (visual only) select whole buffer without plugins
- ie - (visual only) Not exact vie
- yae - copy whole buffer
- ; - motions
- TODO - cosco (inserting semicolons and colons)

# Available (or safe for remapping)

TODO
