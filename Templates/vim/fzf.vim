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

autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_vim.listproc = { list -> fzf#vim#listproc#location(list) }

let g:fzf_vim.tags_command = 'ctags -R'

" }}} 

" layout {{{ 

" let g:fzf_percent = '55%'
let g:fzf_percent = '100%'

let g:fzf_layout = { 'down': g:fzf_percent }
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" if exists('$TMUX')
"     " let g:fzf_layout = { 'tmux': '-p90%,60%' }
"     let g:fzf_layout = { 'tmux': '-d'.g:fzf_percent }
" else
"     " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
"     let g:fzf_layout = { 'down': g:fzf_percent }
" endif

" ~~Preview window is hidden by default.~~ You can toggle it with ctrl-/.
" It will show on the right with 50% width, but if the width is smaller
" than 70 columns, it will show above the candidate list
" let fzf_preview_default = 'right,64%,<70(up,40%)'
" let fzf_preview_default = 'right,64%'

" let fzf_preview_default = 'right,55%'
let fzf_preview_default = 'up,50%'
let g:fzf_vim.preview_window = [fzf_preview_default, 'ctrl-/']

" " - Window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }

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
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }

" }}} 

" }}} 

" custom grep {{{ 

let s:ggrep_args = '--line-number --color=always'
let s:grep = g:grep.' --dereference-recursive '.s:ggrep_args
let s:ggrep_args = s:ggrep_args.' -EI'

" simple grep
command! -bang -nargs=* Fgrep
      \ call fzf#vim#grep(
      \ s:grep." -- ".fzf#shellescape(<q-args>),
      \ fzf#vim#with_preview(),
      \ <bang>0
      \ )

" grep on given directory
command! -bang -nargs=* -complete=dir Dgrep
      \ call fzf#vim#grep(
      \ s:grep." -- ".fzf#shellescape(s:W0(<f-args>)),
      \ extend(
      \ fzf#vim#with_preview(),
      \ s:with_dir([<f-args>]),
      \ ),
      \ <bang>0
      \ )

" case insensitive grep on given directory
command! -bang -nargs=* -complete=dir Digrep
      \ call fzf#vim#grep(
      \ s:grep." -i -- ".fzf#shellescape(s:W0(<f-args>)),
      \ extend(
      \ fzf#vim#with_preview(),
      \ s:with_dir([<f-args>]),
      \ ),
      \ <bang>0
      \ )

" }}} 

" custom ag {{{ 

let s:ahflags = '--ignore .git --ignore .hg --hidden'
let s:auflags = '--unrestricted'

command! -bang -nargs=* Ah 
      \ call fzf#vim#ag(<q-args>,
      \ s:ahflags,
      \ fzf#vim#with_preview(),
      \ <bang>0)

command! -bang -nargs=* Au 
      \ call fzf#vim#ag(<q-args>,
      \ s:auflags,
      \ fzf#vim#with_preview(),
      \ <bang>0)

" Ag from given directory
command! -bang -nargs=* -complete=dir Dah
      \ call fzf#vim#ag(s:W0(<f-args>),
      \ s:ahflags,
      \ extend(
      \ s:with_dir([<f-args>]),
      \ extend(deepcopy(g:fzf_layout), fzf#vim#with_preview())
      \ ), <bang>0)

command! -bang -nargs=* -complete=dir Dau
      \ call fzf#vim#ag(s:W0(<f-args>),
      \ s:auflags,
      \ extend(
      \ s:with_dir([<f-args>]),
      \ extend(deepcopy(g:fzf_layout), fzf#vim#with_preview())
      \ ), <bang>0)

" }}} 

" custom rg {{{ 

let s:rgcmd = "rg --column --line-number --no-heading --hidden ".
      \ "--color=always --smart-case "
command! -bang -nargs=* -complete=dir Drg
      \ call fzf#vim#grep(
      \ s:rgcmd.' --glob="!.git" --glob="!.hg" -- '.
      \ fzf#shellescape(s:W0(<f-args>)),
      \ extend(
      \ s:with_dir(<f-args>),
      \ extend(deepcopy(g:fzf_layout), fzf#vim#with_preview())
      \ ), <bang>0)

command! -bang -nargs=* -complete=dir Dru
      \ call fzf#vim#grep(
      \ s:rgcmd.' --unrestricted -- '.fzf#shellescape(s:W0(<f-args>)),
      \ extend(
      \ s:with_dir(<f-args>),
      \ extend(deepcopy(g:fzf_layout), fzf#vim#with_preview())
      \ ), <bang>0)

" }}} 

" custom diff {{{ 

" TODO C preview like in other commands (probably impossible)
command! -bang -nargs=? -complete=dir Fdiffs
      \ call fzf#run(fzf#wrap({
      \ 'sink': 'diffs',
      \ 'dir': <q-args>,
      \ 'options': [
      \ '--preview',
      \ 'delta '.Expand("%:p").' {}',
      \ '--preview-window',
      \ fzf_preview_default,
      \ ],
      \ },
      \ <bang>0))

command! -bang -nargs=? -complete=dir Fdiffv
      \ call fzf#run(fzf#wrap({
      \ 'sink': 'vert diffs',
      \ 'dir': <q-args>,
      \ 'options': [
      \ '--preview',
      \ 'delta '.Expand("%:p").' {}',
      \ '--preview-window',
      \ fzf_preview_default,
      \ ],
      \ },
      \ <bang>0)
      \ )

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

" From official instructions
" git grep
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep '.s:ggrep_args.' -r -- '.fzf#shellescape(<q-args>),
      \   fzf#vim#with_preview(
      \      {'dir': GitRoot()}
      \   ), <bang>0)

nnoremap <leader>gs/ :<C-u>GFiles<CR>
nnoremap <leader>gs? :<C-u>GFiles?<CR>
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

" let g:fzf_action = {
"       \ 'ctrl-q': function('s:build_quickfix_list'),
"       \ 'ctrl-o': function('s:tab_args'),
"       \ 'ctrl-t': 'Tabe',
"       \ 'ctrl-s': 'split',
"       \ 'ctrl-v': 'vsplit',
"       \ 'ctrl-r': 'view',
"       \ 'ctrl-w': 'TabV',
"       \ 'ctrl-l': function('s:populate_arg_list'),
"       \ 'ctrl-a': function('s:add_arg_list'),
"       \ }

let g:fzf_action = {
      \ 'alt-q': function('s:build_quickfix_list'),
      \ 'alt-t': 'Tabe',
      \ 'alt-T': 'TabV',
      \ 'alt-L': function('s:populate_arg_list'),
      \ 'alt-l': function('s:add_arg_list'),
      \ }
      " \ 'alt-o': function('s:tab_args'),
      " \ 'alt-r': 'view',
      " \ 'alt-s': 'split',
      " \ 'alt-v': 'vsplit',

" }}} 
