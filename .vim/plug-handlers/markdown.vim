" vim-markdown {{{ 

" https://codeinthehole.com/tips/writing-markdown-in-vim/

let g:vim_markdown_borderless_table = 1
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_folding_level = 0
let g:vim_markdown_no_default_key_mappings = 0

" Fold heading in with the contents.
let g:vim_markdown_folding_style_pythonic = 1

" Autoshrink TOCs.
let g:vim_markdown_toc_autofit = 1

" Indentation for new lists. We don't insert bullets as it doesn't play
" nicely with `gq` formatting. It relies on a hack of treating bullets
" as comment characters.
" See https://github.com/plasticboy/vim-markdown/issues/232
let g:vim_markdown_new_list_item_indent = 0 " 2 ?
let g:vim_markdown_auto_insert_bullets = 0

" Filetype names and aliases for fenced code blocks.
let g:vim_markdown_fenced_languages = [
      \ 'py=python',
      \ 'hs=haskell',
      \ 'js=javascript',
      \ 'ts=typescript',
      \ 'viml=vim',
      \ ]

" Format strike-through text (wrapped in `~~`).
let g:vim_markdown_strikethrough = 1

let g:vim_markdown_follow_anchor = 1

let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_no_extensions_in_markdown = 1

function s:NoExGe()
  let l:ex = g:vim_markdown_no_extensions_in_markdown
  let g:vim_markdown_no_extensions_in_markdown = 0
  norm ge
  let g:vim_markdown_no_extensions_in_markdown = l:ex
endfunction

" Because ge isn't intelligent enough
noremap gE :<C-u>call <SID>NoExGe()<CR>

" }}} 

" TODO B markdownfootnotes {{{ 

" autocmd VimEnter
"       \ iunmap <Leader>r
"       \ | iunmap <Leader>i

" }}} 

" bullets.vim {{{ 

" file types {{{ 
" You can choose which file types this plugin will work on:
let g:bullets_enabled_file_types = [
      \ 'markdown',
      \ 'text',
      \ 'viminfo',
      \ 'conf',
      \ 'gitcommit',
      \ 'org',
      \ 'vimwiki',
      \ 'pandoc',
      \]

" You can disable this plugin for empty buffers (no filetype):
let g:bullets_enable_in_empty_buffers = 0
" }}} 

" mappings {{{ 

" Enable/disable default key mappings:
let g:bullets_set_mappings = 0

" Add a leader key before default mappings:
" let g:bullets_mapping_leader = '<M-b>'

" disable adding default key mappings
let g:bullets_set_mappings = 1

" N.B. You can set these mappings as-is without using this 
" g:bullets_custom_mappings option but it
" will apply in this case for all file types while when using
" g:bullets_custom_mappings it would
" take into account file types filter set in
" g:bullets_enabled_file_types, and also
" g:bullets_enable_in_empty_buffers option.
let g:bullets_custom_mappings = [
      \ ['imap', '<cr>', '<Plug>(bullets-newline)'],
      \ ['inoremap', '<C-cr>', '<cr>'],
      \
      \ ['nmap', 'o', '<Plug>(bullets-newline)'],
      \
      \ ['xmap', '<Leader>.n', '<Plug>(bullets-renumber)'],
      \ ['nmap', '<Leader>.n', '<Plug>(bullets-renumber)'],
      \
      \ ['nmap', '<Leader>.x', '<Plug>(bullets-toggle-checkbox)'],
      \
      \ ['nmap', '>>', '<Plug>(bullets-demote)'],
      \ ['xmap', '>', '<Plug>(bullets-demote)'],
      \ ['nmap', '<<', '<Plug>(bullets-promote)'],
      \ ['xmap', '<', '<Plug>(bullets-promote)'],
      \
      \ ['imap', '<C-t>', '<Plug>(bullets-demote)'],
      \ ['imap', '<C-d>', '<Plug>(bullets-promote)'],
      \ ]

" }}} 

" padding {{{ 
" Don't/add extra padding between the bullet and text when
" bullets are multiple characters long:
" let g:bullets_pad_right = 1
" I. text
" II. text
" III. text
" IV.  text
" V.   text
"     ^ extra spaces to align the text with the longest bullet

let g:bullets_pad_right = 0
" I. text
" II. text
" III. text
" IV. text
"    ^ no extra space between bullet and text
" }}} 

" max characters {{{ 
" Maximum number of alphabetic characters to use for bullets:
let g:bullets_max_alpha_characters = 3
" ...
" y. text
" z. text
" aa. text
" ab. text

" let g:bullets_max_alpha_characters = 1
" ...
" y. text
" z. text
" text
" }}} 

" levels {{{ 
" Nested outline bullet levels:
let g:bullets_outline_levels = [
      \ 'ROM',
      \ 'ABC',
      \ 'num',
      \ 'abc',
      \ 'rom',
      \ 'std-',
      \ 'std*',
      \ 'std+'
      \ ]

" Ordered list containing the heirarchical bullet levels, starting from the 
" outer most level.
" Available bullet level options (cannot use the same marker more than once)
" ROM/rom = upper/lower case Roman numerals (e.g., I, II, III, IV)
" ABC/abc = upper/lower case alphabetic characters (e.g., A, B, C)
" std[-/*/+] = standard bullets using a hyphen (-), asterisk (*), or plus (+) 
" as the marker.
" chk = checkbox (- [ ])

" let g:bullets_outline_levels = ['num', 'abc', 'std-']
" Example [keys pressed to get this bullet]:
" 1. first parent
"   a. child bullet [ <cr><C-t> ]
"     - unordered bullet [ <cr><C-t> ]
"   b. second child bullet [ <cr><C-d> ]
" 2. second parent [ <cr><C-d> ]
" }}} 

" renumber {{{ 
" Enable/disable automatically renumbering the current ordered bullet list 
" when changing the indent level of bullets or inserting a new bullet:
let g:bullets_renumber_on_change = 1

" Example 1:
" 1. first existing bullet
"   a. second existing bullet [ hit <C-t> ]
" 2. third existing bullet [ this got renumbered 3 -> 2 when bullet 2 got 
"    demoted ]
"
" Example 2:
" 1. first existing bullet
" 2. second existing bullet [ use <cr>/o to add a new bullet below this ]
" 3. new bullet
" 4. third existing bullet [ this got renumbered 3 -> 2 when bullet 2 got 
"    demoted ]

" let g:bullets_renumber_on_change = 0
" Example:
" 1. first existing bullet
"   a. second existing bullet [ hit <C-t> ]
" 3. third existing bullet [ no renumbering so this bullet remained `3` ]
"
" Example 2:
" 1. first existing bullet
" 2. second existing bullet [ use <cr>/o to add a new bullet below this ]
" 3. new bullet
" 3. third existing bullet [ no renumbering so this bullet remained `3` ]
" }}} 

" {{{ 
" Enable/disable toggling parent and child checkboxes to indicate "completion" 
" of child checkboxes:
let g:bullets_nested_checkboxes = 1
" Example:
" - [ ] first bullet
"   - [ ] child bullet  [ type <leader>x ]
"     - [ ] sub-child
"   - [ ] child bullet
"
" Result:
" - [o] first bullet   [ <- indicates partial completion of sub-tasks ]
"   - [X] child bullet
"     - [X] sub-child  [ <- children get checked when parents get checked ]
"   - [ ] child bullet

" Define the checkbox markers to use to indicate unchecked, checked, and 
" "partially" checked. When only two marker characters are defined, the use of 
" partial completion markers will be disabled. If more than two markers are 
" defined, each character between the first and last characters will be used 
" to indicate a percentage of the child checkboxes that are checked. Each 
" marker corresponds to 1/n, where n is the number of partial completion 
" markers. By default, there are three partial completion markers, ., o, and 
" O, corresponding to 33%, 66%, and up to but less than 100%, respectively. 
" Note that unchecked ([ ]) and checked ([x] or [X]) statuses using the 
" default markers are always valid, even if you set custom markers for 
" unchecked and checked.
" }}} 

" markers {{{ 
let g:bullets_checkbox_markers = ' .oOX'
" Example:
" - [o] parent bullet  [ <- `o` indicates 66% - 99% of children are checked ]
"   - [ ] child bullet
"   - [.] child bullet [ <- partial completions don't count as complete ]
"     - [ ] sub-child bullet [ <- 1/4 of children checked so parent is `.` ]
"     - [ ] sub-child bullet
"     - [ ] sub-child bullet
"     - [X] sub-child bullet
"   - [X] child bullet
"   - [X] child bullet

" You can use fancy markers:
" let g:bullets_checkbox_markers = '✗○◐●✓'
" - [✗] unchecked
" - [○] partial
"   - [✓] checked
"   - [✗] unchecked
"   - [✗] unchecked
"   - [✗] unchecked

" Define whether toggling partially complete checkboxes sets the checkbox to 
" checked or unchecked:
" }}} 

" partial checkboxes {{{ 
" Example 1:
let g:bullets_checkbox_partials_toggle = 1
" - [o] partially checked  [ type <leader>x ]
"   - [x] sub bullet
"   - [ ] sub bullet
"
" Result:
" - [x] checked
"   - [x] sub bullet
"   - [x] sub bullet

" Example 2:
" let g:bullets_checkbox_partials_toggle = 0
" - [o] partially checked  [ type <leader>x ]
"   - [x] sub bullet
"   - [ ] sub bullet
"
" Result:
" - [ ] checked
"   - [ ] sub bullet
"   - [ ] sub bullet
" }}} 

" other {{{ 
" Enable/disable deleting the last empty bullet when hitting
" <cr> (insert mode) or o (normal mode):
let g:bullets_delete_last_bullet_if_empty = 1

" Line spacing between bullets
" (1 = no blank lines, 2 = one blank line, etc.):
let g:bullets_line_spacing = 1

" Indent new bullets when the previous bullet ends with a colon:
let g:bullets_auto_indent_after_colon = 1
" a. text
" b. text:
"   i. text
" }}} 

" }}} 
