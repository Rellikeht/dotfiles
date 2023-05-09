# About
This file is trial to describe all mappings and keep available
keys in one place. With hundreds of mappings it is necessary

# Unused keys
\, |, ~ (hard to reach on some keyboards), ^
There may be more, but there are already enough combinations

# _ combinations
They are general purpose, mainly for tab management

## Tabs
- _<Tab> - g<Tab>
- _B - :tabnew<CR>:buffer<Space>
- _d - :tabclose<CR>
- _h - gT
- _H - :tabm -1<CR>
- _k - :tabfirst<CR>
- _i - :tabs<CR>
- _j - :tablast<CR>
- _J - :tabm $<CR>
- _K - :tabm 0<CR>
- _l - gt
- _L - :tabm +1<CR>
- _m - :tabm<Space>
- _t - :tabedit<Space>
- _T - :tabnew<CR>

## Buffers
- _a - :bad<Space>
- _b - :buffer<Space>
- _c - :bmodified<CR>
- _C - :bmodified!<CR>
- _D - :bdelete<CR>
- _f - :files<CR>
- _g - :vsplit<Space>
- _G - :split<Space>
- _I - :buffers<CR>
- _n - :bnext<CR>
- _N - :bnext!<CR>
- _p - :bprevious<CR>
- _P - :bprevious!<CR>
- _s - :sbprevious<CR>
- _S - :sbnext<CR>
- _U - :bunload<CR>
- _v - :vsplit<CR>:bnext<CR>
- _V - :vsplit<CR>:bprevious<CR>

## Miscelanous
- _r - redraw command
- _w - SudoWrite
- _y - in normal paste, in visual copy to X11 clipboard
- _Y - like _y, but using X11 primary

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
- v - vlime ; NOT IMPLEMENTED

## With plugins
- ; - commands ; TODO
- t - tmux ; TODO
- g - git ; NOT IMPLEMENTED
- u - undo tree ; NOT IMPLEMENTED
- f - fuzzy finder ; NOT IMPLEMENTED

TODO one or two for others

# g combinations
Available (useless otherwise):
A, B, C, G, K, L, O, S, Y, Z
b, j, l, o, y, z

Rather useless:
D, I, Q
d, k, q, r, s, w

Rather useful:
H, J, M, N, V
h, m, n

- c - vim-commentary ; TODO
- S - vim-surround ; TODO
- a - characterize ; TODO
- x, X - netrw ; TODO

# z combinations
Available (unused):
B, I, J, K, Q, S, T, U, V, Y, Z
q
All special characters, besides: +, -, ., =, <CR>, numbers

## Nvim only
- <Leader> - zen-mode ; NOT IMPLEMENTED

# Miscelanous

- C-y - "+gP (I don't know if it works)
- Space - <C-w>
- ae - (visual only) select whole buffer without plugins
- ie - (visual only) Not exact vie
- yae - copy whole buffer

# Available (or safe for remapping)
TODO
