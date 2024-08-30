# About

I tried to balance ergonomy and logic while providing maximum
functionality with keybindings. This results in partial
preservation of logic and very imperfect ergonomy.

## File

This file is trial to describe all mappings and keep available
keys in one place.

With hundreds of mappings it may be necessary.

All of this isn't very accurate and updated, at least for now.

# Unused keys

## good

- \_

## hard to reach in some cases

- \\
- |
- <BS>

## always hard to reach

- ~
- ^

## (control) good

<!-- - C-j -->

<!-- - C-k -->

## (control) not so useful

- `C-_` - not used
- `C-\ C-G`
- `C-\ a - z` - reserved for extensions, others not used

# Remappings

## vanilla

- ; - <C-w>
- <C-m> (<cr>) - <Tab>
- <C-h> - \<C-\]>
- .. - .
- . - TODO quick and loc lists
- <c-j>, <c-k> - quickstack (my own mini harpoon inspired thing
  built around quickfix list)

## with plugins

- <C-n>, <C-p> - sneak

# <Space> combinations

- navigation in arglist
- random stuff, because it is a good key

## Special cases

- q - settings
- m - :make, :compiler and stuff
- j - quickstack
- i - some info commands
- t - tags
- u - "+p
- U - "+P
- y - "+y
- Y - "+Y
- s - `:[l]grep` and stuff
- v - `:[l]vimgrep` and stuff
- c - eunuch find and locate commands
- h - diffs

## Free

c,k,r,w,x,z

+,-

1-9,\[,\]

# <Space><Space> combinations

- navigation between buffers (:b commands)

## Special

- f - find

## Plugins

- j - harpoon

# <Tab> combinations

## Typical

- tab management
- splits
- windows resizing

## Other

- w - save and refresh with delay
- h - help in tab
- k - K in separate tab
- u - "\*p
- U - "\*P
- y - "\*y
- Y - "\*Y

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

- <Space>:

  - <Space> - setlocal hls!
  - other - list of arglists (jumping between different
    arglists)

- ; - commands

## With plugins

- t - tmux

- g - git

  - j,k (every possible casing) - signify
  - s - signify, git grep
  - v,V,? - gv
  - others - fugitive

- s - fzf

- n:

  - v - pdf viewer
  - m - unicode
  - p - pluto.jl :)
  - l - latex to unicode
  - f, <Space>f - neoformat
  - others used - nuuid

- u - undotree, tinyMRU, obsession

<!-- - w - vim wiki -->

- q misc again:

  - u - general plug upgrade
  - P - plug clean
  - cp - toggle context until move
  - ct - toggle context
  - cw - toggle context in current window
  - de - edit envrc
  - dE - edit direnvrc
  - dl - direnv load

- x, X - netrw, vifm, drag and drop (xdragon)

- i - tabularize, vis, bullets

- h - highlighter

- m - markdown and similar

## Nvim only

- d - lspconfig diagnostics and lsp actions
- <Leader> - easymotion ; TODO

## Free

a,b,e,f,k,l,o,p,r,v,w,y,z

# g combinations

Available (useless otherwise): G, K, L, l

Rather useless: I, Q, H, h, r, w

- c - vim-commentary
- C - toggle coloring of hex codes (vim-css-color)
- S - vim-surround
- a - unicode
- A - radical.vim
- y,Y - "\*y,"+y
- s - vim-slime and similar
- z - slime send with motion
- "+" - v<C-a>
- "-" - v<C-x>
- l - (markdown) inline edit

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

# Miscelanous

- Space - <C-w>
- ae - (visual only) select whole buffer without plugins
- ie - (visual only) Not exact vie
- yae - copy whole buffer
- ; - motions
- TODO - cosco (inserting semicolons and colons)
