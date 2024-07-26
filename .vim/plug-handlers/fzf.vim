"{{{ TODO
"}}}

"{{{ settings

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

let $FZF_DEFAULT_COMMAND='find .'
let g:fzf_vim = {}

autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_vim.listproc = { list -> fzf#vim#listproc#location(list) }

"}}}

"{{{ layout

" " Default fzf layout

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

"}}}

"{{{ colors

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

"}}}

"{{{ basic mappings

" Not needed really
noremap <leader>sff :<C-u>FZF<CR>

noremap <leader>slf :<C-u>Files<CR>
noremap <leader>sl<Space>f :<C-u>Files<Space>
noremap <leader>sls :<C-u>Locate<Space>
noremap <leader>sla :<C-u>Ag<CR>
noremap <leader>sl<Space>a :<C-u>Ag<Space>

"}}}

"{{{ insert mode

" Insert mode completion
imap <c-X><C-w> <Plug>(fzf-complete-word)
imap <c-X>w <C-x><C-w>
imap <c-X>l <Plug>(fzf-complete-line)

imap <C-X><C-p> <Plug>(fzf-complete-path)
imap <C-X>p <C-x><C-p>

" TODO C dictionary

"}}}

"{{{ fzf-vim additional mappings

nnoremap <leader>slb :<C-u>BLines<CR>
nnoremap <leader>sl<Space>b :<C-u>BLines<Space>
nnoremap <leader>sll :<C-u>Lines<CR>
nnoremap <leader>sl<Space>l :<C-u>Lines<Space>

nnoremap <leader>shh :<C-u>History<CR>
nnoremap <leader>sh/ :<C-u>History/<CR>
nnoremap <leader>sh: :<C-u>History:<CR>
nnoremap <leader>shf :<C-u>Changes<CR>
nnoremap <leader>shc :<C-u>Commits<CR>
nnoremap <leader>shm :<C-u>Marks<CR>

nnoremap <leader>s;f :<C-u>Buffers<CR>
nnoremap <leader>s;m :<C-u>Maps<CR>
nnoremap <leader>s;H :<C-u>Helptags<CR>
nnoremap <leader>s;w :<C-u>Windows<CR>
nnoremap <leader>s;j :<C-u>Jumps<CR>
nnoremap <leader>s;t :<C-u>Tags<CR>

nnoremap <leader>gff :<C-u>GFiles<CR>
nnoremap <leader>gfs :<C-u>GFiles?<CR>

"}}}

" TODO on a directory
"{{{ custom greps

let grep_args = '-EI --line-number'

command! -bang -nargs=* Fgrep
      \ call fzf#vim#grep(
      \ "grep ".grep_args."  --dereference-recursive -- "
      \ .fzf#shellescape(<q-args>),
      \ fzf#vim#with_preview(),
      \ <bang>0
      \ )

" From official instructions
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep '.grep_args.' --recursive -- '.fzf#shellescape(<q-args>),
      \   fzf#vim#with_preview(
      \      {'dir': systemlist('git rev-parse --show-toplevel')[0]}
      \   ), <bang>0)

nnoremap <leader>slg :Fgrep<CR>
nnoremap <leader>sl<Space>g :Fgrep<Space>
nnoremap <leader>slc :GGrep<CR>
nnoremap <leader>sl<Space>c :GGrep<Space>

"}}}

"{{{ custom ag

command! -bang -nargs=* Ah 
      \ call fzf#vim#ag(<q-args>,
      \ '--hidden',
      \ fzf#vim#with_preview(),
      \ <bang>0)

command! -bang -nargs=* Au 
      \ call fzf#vim#ag(<q-args>,
      \ '--unrestricted',
      \ fzf#vim#with_preview(),
      \ <bang>0)

function! s:with_git_root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  return v:shell_error ? {} : {'dir': root}
endfunction

" Ag from git root
command! -bang -nargs=* Rag
      \ call fzf#vim#ag(<q-args>,
      \ extend(
      \ s:with_git_root(),
      \ extend(g:fzf_layout, fzf#vim#with_preview())
      \ ),
      \ <bang>0)
command! -bang -nargs=* Rau
      \ call fzf#vim#ag(<q-args>,
      \ '--unrestricted',
      \ extend(
      \ s:with_git_root(),
      \ extend(g:fzf_layout, fzf#vim#with_preview())
      \ ),
      \ <bang>0)

function! s:with_dir(dir)
  return {'dir': a:dir}
endfunction

function! s:Empty(A, L, C)
  return ''
endfunction

function! s:W0(...)
  return join(a:000[1:], '')
endfunction

" Ag from given directory
command! -bang -nargs=+ -complete=dir -complete=custom,s:Empty Dag
      \ call fzf#vim#ag(s:W0(<f-args>),
      \ extend(
      \ s:with_dir([<f-args>][0]),
      \ extend(g:fzf_layout, fzf#vim#with_preview())
      \ ),
      \ <bang>0)
command! -bang -nargs=+ -complete=dir -complete=custom,s:Empty Dau
      \ call fzf#vim#ag(s:W0(<f-args>),
      \ '--unrestricted',
      \ extend(
      \ s:with_dir([<f-args>][0]),
      \ extend(g:fzf_layout, fzf#vim#with_preview())
      \ ),
      \ <bang>0)

nnoremap <leader>slh :Ah<CR>
nnoremap <leader>sl<Space>h :Ah<Space>
nnoremap <leader>slu :Au<CR>
nnoremap <leader>sl<Space>u :Au<Space>
nnoremap <leader>slr :Rag<CR>
nnoremap <leader>sl<Space>r :Rag<Space>
nnoremap <leader>slR :Rau<CR>
nnoremap <leader>sl<Space>R :Rau<Space>
nnoremap <leader>sld :Dag<Space>
nnoremap <leader>slD :Dau<Space>

"}}}

"{{{ custom diffs

" TODO preview like in other commands (probably impossible)
command! -bang -nargs=? -complete=dir Fdiffs
      \ call fzf#run(fzf#wrap({
      \ 'sink': 'diffs',
      \ 'dir': <q-args>,
      \ 'options': [
      \ '--preview',
      \ 'delta '.expand("%:p").' {}',
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
      \ 'delta '.expand("%:p").' {}',
      \ '--preview-window',
      \ fzf_preview_default,
      \ ],
      \ },
      \ <bang>0)
      \ )

nnoremap <leader>sds :Fdiffs<CR>
nnoremap <leader>sd<Space>s :Fdiffs<Space>
nnoremap <leader>sdv :Fdiffv<CR>
nnoremap <leader>sd<Space>v :Fdiffv<Space>

"}}}

"{{{ arglist

"{{{ select from arglist

command! -bang Args call fzf#run(fzf#wrap('args',
      \ {'source': map(
      \ [argidx()]+
      \ (argidx()==0?[]:range(argc())[0:argidx()-1])+
      \ range(argc())[argidx()+1:], 'argv(v:val)')}, <bang>0))

nnoremap <leader>sfa :Args<CR>
nnoremap <leader>sf<Space>a :Args<Space>

"}}}

"{{{ arglist single

command! -bang -nargs=? -complete=dir ArgeditFzf 
      \ call fzf#run({
      \ 'sink': 'argedit',
      \ })

nnoremap <leader>slo :ArgeditFzf<CR>
nnoremap <leader>sl<Space>o :ArgeditFzf<Space>

"}}}

"{{{
" Not ideal, but should be good enough

command! -bang -nargs=? -complete=dir MArgeditFzf 
      \ call fzf#run({
      \ 'sink': 'argedit',
      \ 'options': '--multi',
      \ })

nnoremap <leader>slm :MArgeditFzf<CR>
nnoremap <leader>sl<Space>m :MArgeditFzf<Space>

"}}}

"}}}

"{{{ dirs mappings

function PathMap(key, path)
  exe 'noremap <leader>sp'.a:key.
        \ ' :<C-u>Files '.a:path.'<CR>'
  exe 'noremap <leader>sa'.a:key.
        \ ' :<C-u>Args '.a:path.'<CR>'
  exe 'noremap <leader>sm'.a:key.
        \ ' :<C-u>MArgs '.a:path.'<CR>'
  exe 'noremap <leader>sg'.a:key.
        \ ' :<C-u>Dag '.a:path.'<CR>'
  exe 'noremap <leader>su'.a:key.
        \ ' :<C-u>Dau '.a:path.'<CR>'
endfunction

let paths = {
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
      \ 'e':'/etc',
      \ 'g':'~/gits',
      \ }

for key in keys(paths)
  call PathMap(key, paths[key])
endfor

"}}}

"{{{ additional keys

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  call QFcmd('open')
  call QFsel('cc', 'll')
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

" TODO this is so bad
let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-l': function('s:populate_arg_list'),
      \ 'ctrl-a': function('s:add_arg_list'),
      \ }

"}}}
