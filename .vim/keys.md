# About

This file is trial to describe all mappings and keep available
keys in one place. With hundreds of mappings it is necessary

# Unused keys

\\ | ~ ^ (hard to reach on some keyboards) _ ; (painful in
greater amounts) There may be more, but there are already enough
combinations

# <Tab> combinations

They are general purpose, mainly for tab management

## TODO make this nicer

## Tabs

- <Tab> - :tab<Space>
- e - :tab<Space>sb<Space>
- d - :tabclose<CR>
- h - gT
- H - :tabm -1<CR>
- i - :tabs<CR>
- j - :tablast<CR>
- J - :tabm $<CR>
- k - :tabfirst<CR>
- K - :tabm 0<CR>
- l - gt
- L - :tabm +1<CR>
- m - :tabm<Space>
- t - :tabedit<Space>
- T - :tabnew<CR>

## Buffers

- a - :bad<Space>
- b - :buffer<Space>
- c - :bmodified<CR>
- C - :bmodified!<CR>
- D - :bdelete<CR>
- f - :files<CR>
- g - :vsplit<Space>
- G - :split<Space>
- I - :buffers<CR>
- n - :bnext<CR>
- N - :bnext!<CR>
- p - :bprevious<CR>
- P - :bprevious!<CR>
- s - :sbprevious<CR>
- S - :sbnext<CR>
- U - :bunload<CR>
- v - :vsplit<CR>:bnext<CR>
- V - :vsplit<CR>:bprevious<CR>

## Miscelanous

- r - redraw command
- w - SudoWrite
- W - toggle wrap
- y - in normal paste, in visual copy to X11 clipboard
- Y - like ;y, but using X11 primary
- Q - source %
- M - setlocal modeline!
- E - :e

## Available

Basically all special characters besides <Tab>

A, B, R, E, O, Q, R, X, Z

k, q, u, x, z

# Leader (,) combinations

## Simple mappings

- q - miscelanous, settings:

  - f,F - toggle formatting on write
  - c,C - compiling on write
  - 0,1,2,...,9 - print variables
  - m - man program
  - M - set make program to make
  - eb - editorconfig toggle for buffer
  - eg - editorconfig toggle globally
  - er - editorconfig reload

- <Space> - set hls!

- ; - commands

## Code

- c, C - compiling
- r, R - running
- b, B - building
- i, I - running interpreted versions of compiled languages
- exceptions (in all possible casing):
  - g - data generation
  - t - templates

## With plugins

- t - tmux

- g - git

  - s,j,k (every possible casing) - signify
  - v,V,? - gv
  - others - fugitive

- s - fzf

- n - unicode, nuuid

- u - undo tree ; NOT IMPLEMENTED :(

- F - code formatting

- E,T,S,V - tinyMRU

- q misc again:

  - u - general plug upgrade
  - P - plug clean
  - t - toggle context until move
  - T - toggle context
  - W - toggle context in current window
  - de - edit envrc
  - dE - edit direnvrc
  - dl - direnv load

## Nvim only

- d - lspconfig diagnostics and lsp actions
- w, f, l, <Leader> - easymotion ; TODO
- e, E, D - code plugins ; NOT IMPLEMENTED
- h - harpoon ; NOT IMPLEMENTED

# g combinations

Available (useless otherwise): C, G, K, L, O j, o, y, z

Rather useless: D, I, Q, H d, h, r, w

Rather useful: J, M, N, V m, n

- c - vim-commentary
- C - toggle colorizer
- S - vim-surround
- a - unicode
- A - radical.vim
- x, X - netrw
- b - jump to tag under cursor (\<C-\]>)
- B - jump to previous tag on stack (<C-T>)
- Y - "+gP (I don't know if it works)
- s - vim-slime and similar

## Nvim only

- l - mdeval, femaco

## TODO

- "+" - v<C-a>
- "-" - v<C-x>

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
- TODO - cosco (inserting semicolons and colons)

# Available (or safe for remapping)

TODO
