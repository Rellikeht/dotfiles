# About
This file is trial to describe all mappings and keep available
keys in one place. With hundreds of mappings it is necessary

# Unused keys
\ | ~ ^ (hard to reach on some keyboards)
_ ; (painful in greater amounts)
There may be more, but there are already enough combinations

# <Tab> combinations
They are general purpose, mainly for tab management

## Tabs
- <Tab> - g<Tab>
- B - :tabnew<CR>:buffer<Space>
- d - :tabclose<CR>
- h - gT
- H - :tabm -1<CR>
- k - :tabfirst<CR>
- i - :tabs<CR>
- j - :tablast<CR>
- J - :tabm $<CR>
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
- y - in normal paste, in visual copy to X11 clipboard
- Y - like ;y, but using X11 primary

## Available
Basically all special characters besides <Tab>
A, R, E, M, O, Q, R, W, X, Z
e, k, o, q, u, x, z

# Leader (,) combinations
## Simple mappings
- q - miscelanous
- c, C, r, R, i, I, b, B - code ; TODO
- <Space> - set hls!

## Nvim only
- w, f, l, <Leader> - easymotion ; TODO
- e, E, d, D - code plugins ; NOT IMPLEMENTED
- s - treesitter ; NOT IMPLEMENTED
- h - harpoon ; NOT IMPLEMENTED

## With plugins
- ; - commands ; TODO
- t - tmux ; TODO
- g - git ; NOT IMPLEMENTED
- u - undo tree ; NOT IMPLEMENTED
- f - fuzzy finder ; NOT IMPLEMENTED

TODO one or two for others

# g combinations
Available (useless otherwise):
C, G, K, L, O
j, l, o, y, z

Rather useless:
D, I, Q, H
d, h, k, q, r, w

Rather useful:
J, M, N, V
m, n

- c - vim-commentary
- C - toggle colorizer
- S - vim-surround
- a - characterize
- A - radical.vim
- x, X - netrw
- b - jump to tag under cursor (<C-]>)
- B - jump to previous tag on stack (<C-T>)
- Y - "+gP (I don't know if it works)
- s - vim-slime and similar

# z combinations
Available (unused):
B, I, J, K, Q, S, T, U, V, Y, Z
q
All special characters, besides: +, -, ., =, <CR>, numbers

- S - sleep

## Nvim only
- (something with z probably) - zen-mode ; NOT IMPLEMENTED

# Z combinations
Only Z and Q is used

# c combinations
## TODO
- r[dxob] - radical.vim

# [ and ]
## TODO

# Miscelanous

- Space - <C-w>
- ae - (visual only) select whole buffer without plugins
- ie - (visual only) Not exact vie
- yae - copy whole buffer
- TODO - cosco (inserting semicolons and colons)

# Available (or safe for remapping)
TODO
