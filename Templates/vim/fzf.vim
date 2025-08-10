" helpers {{{ 

function! s:with_dir(dir='')
  if len(a:dir) == 0
    return {}
  endif
  if type(a:dir) == v:t_list
    let l:dir = a:dir[0]
  else
    let l:dir = a:dir
  endif
  return {'dir': l:dir}
endfunction

function! s:W0(...)
  return join(a:000[1:], '')
endfunction

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines, action = 'r')
  let lns = map(deepcopy(a:lines),
        \ '{ "filename": v:val'.
        \ ', "lnum": 1'.
        \ ' }'
        \ )
  if g:qfloc
    call setloclist(0, lns)
  else
    call setqflist(lns)
  endif
  call QFcmd('open')
endfunction

func s:fnameescape(key, val)
  return fnameescape(a:val)
endfunc

function! s:populate_arg_list(lines)
  execute 'args ' . join(map(a:lines, function('s:fnameescape')), ' ')
endfunction

function! s:add_arg_list(lines)
  execute 'argadd ' . join(map(a:lines, function('s:fnameescape')), ' ')
endfunction

function! s:tab_args(lines)
  Tabe
  execute 'args ' . join(map(a:lines, function('s:fnameescape')), ' ')
endfunction

" }}} 

" settings {{{ 

" basic {{{ 

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_vim = {}

function g:fzf_vim.listproc(list)
  if g:qfloc
    fzf#vim#listproc#location(list)
  else
    fzf#vim#listproc#quickfix(list)
  endif
endfunction

let g:fzf_vim.tags_command = 'ctags -R'

let g:fzf_layout = {'down': '100%'}
" border is useful here
let g:fzf_preview_default = 'up,50%'
let g:fzf_vim.preview_window = [g:fzf_preview_default, 'ctrl-s']

" }}} 

" colors {{{ 

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }

" }}} 

" }}} 

" insert mode mappings {{{ 

" Insert mode completion
imap <c-X><C-w> <Plug>(fzf-complete-word)
imap <c-X>w <C-x><C-w>
imap <c-X>l <Plug>(fzf-complete-line)

imap <C-X><C-p> <Plug>(fzf-complete-path)
imap <C-X>p <C-x><C-p>

" }}} 

" builtin mappings {{{ 

nnoremap <leader>slf :<C-u>History<CR>
nnoremap <leader>sl/ :<C-u>History/<CR>
nnoremap <leader>sl: :<C-u>History:<CR>
nnoremap <leader>slp :<C-u>Marks<CR>
nnoremap <leader>slm :<C-u>Changes<CR>

" lists
nnoremap <leader>slo :<C-u>Buffers<CR>
nnoremap <leader>slk :<C-u>Maps<CR>
nnoremap <leader>slh :<C-u>Helptags<CR>
nnoremap <leader>slw :<C-u>Windows<CR>
nnoremap <leader>slj :<C-u>Jumps<CR>
nnoremap <leader>slt :<C-u>Tags<CR>
nnoremap <leader>slb :<C-u>BTags<CR>

" noremap <leader>slf :<C-u>Files<CR>
" noremap <leader>sl<Space>f :<C-u>Files<Space>

" other
noremap <leader>sls :<C-u>Locate<Space>
nnoremap <leader>slc :<C-u>Commands<CR>

" Not needed really
noremap <leader>slr :<C-u>FZF<CR>
noremap <leader>sl<Space>r :<C-u>FZF<Space>

" }}} 

" file mappings {{{ 

nnoremap <leader>sfb :<C-u>BLines<CR>
nnoremap <leader>sf<Space>b :<C-u>BLines<Space>
nnoremap <leader>sfl :<C-u>Lines<CR>
nnoremap <leader>sf<Space>l :<C-u>Lines<Space>

" }}} 

" git mappings {{{ 

nnoremap <leader>gsf :<C-u>GFiles<CR>
nnoremap <leader>gsm :<C-u>GFiles?<CR>
nnoremap <leader>gsg :GGrep<CR>
nnoremap <leader>gs<Space>g :GGrep<Space>

" history and marks
nnoremap <leader>gsc :<C-u>Commits<CR>
nnoremap <leader>gsb :<C-u>BCommits<CR>

" }}} 

" custom command mappings {{{ 

" grep
nnoremap <leader>sfg :Fgrep<CR>
nnoremap <leader>sfg :Fgrep<Space>

" ag
nnoremap <leader>sfh :Ah<CR>
nnoremap <leader>sf<Space>h :Ah<Space>
nnoremap <leader>sfu :Au<CR>
nnoremap <leader>sf<Space>u :Au<Space>

" diff
nnoremap <leader>sfd :Fdiffs<CR>
nnoremap <leader>sf<Space>d :Fdiffs<Space>
nnoremap <leader>sfv :Fdiffv<CR>
nnoremap <leader>sf<Space>v :Fdiffv<Space>

" }}} 

" actions {{{ 

let g:fzf_action = {
      \ 'alt-q': function('s:build_quickfix_list'),
      \ 'alt-t': function('s:tab_args'),
      \ 'alt-T': 'Tabe',
      \ 'alt-v': 'view',
      \ 'alt-V': 'TabV',
      \ 'alt-L': function('s:populate_arg_list'),
      \ 'alt-l': function('s:add_arg_list'),
      \ }
      " TODO C

" }}} 
