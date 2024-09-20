# What is this

Some simple document with (mostly) automatically generated
mappings to quickly check what to press

# textobjects

## builtin

- `"` - double quoted string
- `'` - single quoted string
- `(` - same as ab
- `)` - same as ab
- `<` - "a `<>`" from `<` to the matching `>`
- `>` - same as a\<
- `B` - "a Block" from `[{` to `]}` (with brackets)
- `W` - "a WORD" (with white space)
- `[` - "a `[]`" from `[` to the matching `]`
- `]` - same as a\[
- \` - string in backticks
- `b` - "a block" from `[(` to `])` (with braces)
- `p` - "a paragraph" (with white space)
- `s` - "a sentence" (with white space)
- `t` - "a tag block" (with white space)
- `w` - "a word" (with white space)
- `{` - same as aB
- `}` - same as aB

## from plugins

- `a` - function argument
- `I` - indentation
- `i` - indentation with line below
- `q` - single typographic quote
- `Q` - double typographic quote
- `v` - continuous line
- `u` - url

## targets.vim

### modifiers (ex. `an)`)

- `n` - next
- `l` last

### around

- `(` `)` - (work on parentheses)
- `{` `}` - B (work on curly braces)
- `[` `]` - (work on square brackets)
- `<` `>` - (work on angle brackets)
- `t` - (work on tags)
- `'` - (work on single quotes)
- `"` - (work on double quotes)
- \` - (work on back ticks)

### separators (ex. `i,`)

- `,`
- `.`
- `;`
- `:`
- `+`
- `-`
- `=`
- `~`
- `_`
- `*`
- `#`
- `/`
- `|`
- `\`
- `&`
- `$`

## extra (e, ex. `aee`)

- `e` - whole buffer
- `p`, `P` - path
- `u` - url
- `=` - any two same characters
- `b` - any delimiter (`()`, `[]`, `""`, ...)

## specialized

### treesitter

TODO

### other

TODO

## matchit (keys)

- `%` - go to matching parent

- `<Space>{` - `[%`

- `<Space>}` - `]%`

- `%` - Cycle forward through matching groups, such as "if",
  "else", "endif", as specified by `b:match_words`.

- `g%` - Cycle backwards through matching groups, as specified
  by `b:match_words`. For example, go from "if" to "endif" to
  "else".

- `[%` - Go to \[count\] previous unmatched group, as specified
  by `b:match_words`. Similar to `[{`.

- `]%` - Go to \[count\] next unmatched group, as specified by
  `b:match_words`. Similar to `]}`.

- `a%` - In Visual mode, select the matching group, as specified
  by `b:match_words`, containing the cursor. Similar to `v_a[`.
  A \[count\] is ignored, and only the first character of the
  closing pattern is selected.

# fzf

## generated

```vimscript
let s:fzf_mapping_paths = {
      \ '1':'..',
      \ '2':'../..',
      \ '3':'../../..',
      \ '4':'../../../..',
      \ '5':'../../../../..',
      \ '6':'../../../../../..',
      \ '7':'../../../../../../..',
      \ '8':'../../../../../../../..',
      \ '9':'../../../../../../../../..',
      \ 'h':'~',
      \ 't':'~/Templates',
      \ 'd':'~/Dbackup',
      \ 'D':'~/Downloads',
      \ 'f':'~/Documents',
      \ 'p':'~/gits',
      \ 'c':'~/.config/',
      \ '.':'',
      \ ',':'.',
      \ }

let s:fzf_mapping_specials = {
      \ 'g':"GitRoot()",
      \ 'G':"GitRoot(GitRoot().'/..')",
      \ 'm':"HgRoot()",
      \ 'M':"HgRoot(HgRoot().'/..')",
      \ 'r':"PartRoot()",
      \ 'b':"g:starting_path",
      \ 'e':"EnvrcRoot()",
      \ 'E':"EnvrcRoot(EnvrcRoot().'/..')",
      \ '<C-e>':"EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')",
      \ }

let s:path_maps = [
      \ ['p', 'Files'],
      \ ['o', 'ArgeditFzf'],
      \ ['a', 'ArgaddFzf'],
      \ ['A', 'ArglistFzf'],
      \ ['s', 'Dag'],
      \ ['S', 'Dau'],
      \ ['d', 'Dgrep'],
      \ ['D', 'Digrep'],
      \ ['r', 'Drg'],
      \ ['R', 'Dru'],
      \ ]
```

# (vim)grep

## vimgrep (`<Space>v`)

```vimscript
let s:vgmaps = [
      \ ['vc', '', '', 0, 0],
      \ ['vC', '', '', 1, 0],
      \ ]

let s:vgcmaps = [
      \ ['<Space>u', '//gj', " '.Expand('<cfile>').' <Home><C-Right><Right>"],
      \ ] + [
      \ ['<Space>c', '//gj', '<C-Left><Right>'],
      \ ['<Space>f', "//gj", ' %<C-Left><C-Left><Right>'],
      \ ['<Space>a', "//gj", ' ## <C-Left><C-Left><Right>'],
      \ ['<Space>l', "//gj", ' * <C-Left><C-Left><Right>'],
      \ ['<Space>h', "//gj", ' .* * <C-Left><C-Left><C-Left><Right>'],
      \ ['<Space>r', "//gj", ' ** <C-Left><C-Left><Right>'],
      \ ['<Space>R', "//gj", ' .*/** ** <C-Left><C-Left><C-Left><Right>'],
      \ ] + [
      \ ['uc', "/'.Expand('<cword>').'/gj", ' ', 'n'],
      \ ['uf', "/'.Expand('<cword>').'/gj", ' % <CR>', 'n'],
      \ ['ua', "/'.Expand('<cword>').'/gj", ' ## <CR>', 'n'],
      \ ['ul', "/'.Expand('<cword>').'/gj", ' * <CR>', 'n'],
      \ ['uh', "/'.Expand('<cword>').'/gj", ' .* * <CR>', 'n'],
      \ ['ur', "/'.Expand('<cword>').'/gj", ' ** <CR>', 'n'],
      \ ['uR', "/'.Expand('<cword>').'/gj", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['wc', "/'.Expand('<cWORD>').'/gj", ' ', 'n'],
      \ ['wf', "/'.Expand('<cWORD>').'/gj", ' % <CR>', 'n'],
      \ ['wa', "/'.Expand('<cWORD>').'/gj", ' ## <CR>', 'n'],
      \ ['wl', "/'.Expand('<cWORD>').'/gj", ' * <CR>', 'n'],
      \ ['wh', "/'.Expand('<cWORD>').'/gj", ' .* * <CR>', 'n'],
      \ ['wr', "/'.Expand('<cWORD>').'/gj", ' ** <CR>', 'n'],
      \ ['wR', "/'.Expand('<cWORD>').'/gj", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['ec', "/'.Expand('<cexpr>').'/gj", ' ', 'n'],
      \ ['ef', "/'.Expand('<cexpr>').'/gj", ' % <CR>', 'n'],
      \ ['ea', "/'.Expand('<cexpr>').'/gj", ' ## <CR>', 'n'],
      \ ['el', "/'.Expand('<cexpr>').'/gj", ' * <CR>', 'n'],
      \ ['eh', "/'.Expand('<cexpr>').'/gj", ' .* * <CR>', 'n'],
      \ ['er', "/'.Expand('<cexpr>').'/gj", ' ** <CR>', 'n'],
      \ ['eR', "/'.Expand('<cexpr>').'/gj", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['fc', "/'.Expand('<cfile>').'/gj", ' ', 'n'],
      \ ['ff', "/'.Expand('<cfile>').'/gj", ' % <CR>', 'n'],
      \ ['fa', "/'.Expand('<cfile>').'/gj", ' ## <CR>', 'n'],
      \ ['fl', "/'.Expand('<cfile>').'/gj", ' * <CR>', 'n'],
      \ ['fh', "/'.Expand('<cfile>').'/gj", ' .* * <CR>', 'n'],
      \ ['fr', "/'.Expand('<cfile>').'/gj", ' ** <CR>', 'n'],
      \ ['fR', "/'.Expand('<cfile>').'/gj", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['yc', "/'.Vescape(@\").'/gj", ' ', 'n'],
      \ ['yf', "/'.Vescape(@\").'/gj", ' % <CR>', 'n'],
      \ ['ya', "/'.Vescape(@\").'/gj", ' ## <CR>', 'n'],
      \ ['yl', "/'.Vescape(@\").'/gj", ' * <CR>', 'n'],
      \ ['yh', "/'.Vescape(@\").'/gj", ' .* * <CR>', 'n'],
      \ ['yr', "/'.Vescape(@\").'/gj", ' ** <CR>', 'n'],
      \ ['yR', "/'.Vescape(@\").'/gj", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['gc', "/'.Vescape(@*).'/gj", ' ', 'n'],
      \ ['gf', "/'.Vescape(@*).'/gj", ' % <CR>', 'n'],
      \ ['ga', "/'.Vescape(@*).'/gj", ' ## <CR>', 'n'],
      \ ['gl', "/'.Vescape(@*).'/gj", ' * <CR>', 'n'],
      \ ['gh', "/'.Vescape(@*).'/gj", ' .* * <CR>', 'n'],
      \ ['gr', "/'.Vescape(@*).'/gj", ' ** <CR>', 'n'],
      \ ['gR', "/'.Vescape(@*).'/gj", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['pc', "/'.Vescape(@+).'/gj", ' ', 'n'],
      \ ['pf', "/'.Vescape(@+).'/gj", ' % <CR>', 'n'],
      \ ['pa', "/'.Vescape(@+).'/gj", ' ## <CR>', 'n'],
      \ ['pl', "/'.Vescape(@+).'/gj", ' * <CR>', 'n'],
      \ ['ph', "/'.Vescape(@+).'/gj", ' .* * <CR>', 'n'],
      \ ['pr', "/'.Vescape(@+).'/gj", ' ** <CR>', 'n'],
      \ ['pR', "/'.Vescape(@+).'/gj", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['sc', "/'.Vescape(GetVisualSelection()).'/gj", ' '],
      \ ['sf', "/'.Vescape(GetVisualSelection()).'/gj", ' %<CR>'],
      \ ['sa', "/'.Vescape(GetVisualSelection().'/gj", ' ## <CR>'],
      \ ['sl', "/'.Vescape(GetVisualSelection().'/gj", ' * <CR>'],
      \ ['sh', "/'.Vescape(GetVisualSelection().'/gj", ' .* * <CR>'],
      \ ['sr', "/'.Vescape(GetVisualSelection().'/gj", ' ** <CR>'],
      \ ['sR', "/'.Vescape(GetVisualSelection().'/gj", ' .*/** ** <CR>'],
      \ ]
```

## grep (`<Space>g`) and ag/rg (`<Space>s`)

```vimscript
let s:gmaps = [
      \ ['c', '', '', 0, 0],
      \ ['C', '', '', 1, 0],
      \ ]

let s:egmaps = copy(s:gmaps)

let s:gcmaps = [
      \ ['<Space>u', '', " '.Expand('<cfile>').' <Home><C-Right><Right>"],
      \ ] + [
      \ ['<Space>f', '', " '.shellescape(expand('%')).'<Home><C-Right><Right>"],
      \ ['<Space>a', '', ' ## <Home><C-Right><Right>'],
      \ ['<Space>l', '', ' * <Home><C-Right><Right>'],
      \ ['<Space>h', '', ' .* * <Home><C-Right><Right>'],
      \ ['<Space>r', '', ' ** <Home><C-Right><Right>'],
      \ ['<Space>R', '', ' .*/** ** <Home><C-Right><Right>'],
      \ ] + [
      \ ['uc', "'.Expand('<cword>').'", ' ', 'n'],
      \ ['uf', "'.Expand('<cword>').'", " '.shellescape(expand('%')).' <CR>", 'n'],
      \ ['ua', "'.Expand('<cword>').'", ' ## <CR>', 'n'],
      \ ['ul', "'.Expand('<cword>').'", ' * <CR>', 'n'],
      \ ['uh', "'.Expand('<cword>').'", ' .* * <CR>', 'n'],
      \ ['ur', "'.Expand('<cword>').'", ' ** <CR>', 'n'],
      \ ['uR', "'.Expand('<cword>').'", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['wc', "'.Expand('<cWORD>').'", ' ', 'n'],
      \ ['wf', "'.Expand('<cWORD>').'", " '.shellescape(expand('%')).' <CR>", 'n'],
      \ ['wa', "'.Expand('<cWORD>').'", ' ## <CR>', 'n'],
      \ ['wl', "'.Expand('<cWORD>').'", ' * <CR>', 'n'],
      \ ['wh', "'.Expand('<cWORD>').'", ' .* * <CR>', 'n'],
      \ ['wr', "'.Expand('<cWORD>').'", ' ** <CR>', 'n'],
      \ ['wR', "'.Expand('<cWORD>').'", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['ec', "'.Expand('<cexpr>').'", ' ', 'n'],
      \ ['ef', "'.Expand('<cexpr>').'", " '.shellescape(expand('%')).' <CR>", 'n'],
      \ ['ea', "'.Expand('<cexpr>').'", ' ## <CR>', 'n'],
      \ ['el', "'.Expand('<cexpr>').'", ' * <CR>', 'n'],
      \ ['eh', "'.Expand('<cexpr>').'", ' .* * <CR>', 'n'],
      \ ['er', "'.Expand('<cexpr>').'", ' ** <CR>', 'n'],
      \ ['eR', "'.Expand('<cexpr>').'", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['yc', "'.Vescape(@\").'", ' ', 'n'],
      \ ['yf', "'.Vescape(@\").'", " '.shellescape(expand('%')).' <CR>", 'n'],
      \ ['ya', "'.Vescape(@\").'", ' ## <CR>', 'n'],
      \ ['yl', "'.Vescape(@\").'", ' * <CR>', 'n'],
      \ ['yh', "'.Vescape(@\").'", ' .* * <CR>', 'n'],
      \ ['yr', "'.Vescape(@\").'", ' ** <CR>', 'n'],
      \ ['yR', "'.Vescape(@\").'", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['gc', "'.Vescape(@*).'", ' ', 'n'],
      \ ['gf', "'.Vescape(@*).'", " '.shellescape(expand('%')).' <CR>", 'n'],
      \ ['ga', "'.Vescape(@*).'", ' ## <CR>', 'n'],
      \ ['gl', "'.Vescape(@*).'", ' * <CR>', 'n'],
      \ ['gh', "'.Vescape(@*).'", ' .* * <CR>', 'n'],
      \ ['gr', "'.Vescape(@*).'", ' ** <CR>', 'n'],
      \ ['gR', "'.Vescape(@*).'", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['pc', "'.Vescape(@+).'", ' ', 'n'],
      \ ['pf', "'.Vescape(@+).'", " '.shellescape(expand('%')).' <CR>", 'n'],
      \ ['pa', "'.Vescape(@+).'", ' ## <CR>', 'n'],
      \ ['pl', "'.Vescape(@+).'", ' * <CR>', 'n'],
      \ ['ph', "'.Vescape(@+).'", ' .* * <CR>', 'n'],
      \ ['pr', "'.Vescape(@+).'", ' ** <CR>', 'n'],
      \ ['pR', "'.Vescape(@+).'", ' .*/** ** <CR>', 'n'],
      \ ] + [
      \ ['sc', "'.Vescape(GetVisualSelection()).'", ' '],
      \ ['sf', "'.Vescape(GetVisualSelection()).'", " '.shellescape(expand('%')).'<CR>"],
      \ ['sa', "'.Vescape(GetVisualSelection().'", ' ## <CR>'],
      \ ['sl', "'.Vescape(GetVisualSelection().'", ' * <CR>'],
      \ ['sh', "'.Vescape(GetVisualSelection().'", ' .* * <CR>'],
      \ ['sr', "'.Vescape(GetVisualSelection().'", ' ** <CR>'],
      \ ['sR', "'.Vescape(GetVisualSelection().'", ' .*/** ** <CR>'],
      \ ]
```
