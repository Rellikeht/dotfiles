"{{{ helpers

function! Git_root(dir='')
  if a:dir == ''
    return systemlist('git rev-parse --show-toplevel')[0]
  endif
  return systemlist('cd '.a:dir.' && git rev-parse --show-toplevel')[0]
endfunction

function! Part_root(dir='')
  if a:dir == ''
    return systemlist("df -P . | awk '/^\\// {print $6}'")[0]
  endif
  return systemlist('cd '.a:dir." && df -P . | awk '/^\\// {print $6}'")[0]
endfunction

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

"}}}

"{{{ settings

"{{{ basic

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

"}}}

"{{{ paths

let g:fzf_mapping_paths = {
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
      \ 'E':'/etc',
      \ 'p':'~/gits',
      \ }

let g:fzf_mapping_specials = {
      \ 'g':"Git_root()",
      \ 'G':"Git_root(Git_root()..'/..')",
      \ 'r':"Part_root()",
      \ 'b':"g:starting_path",
      \ }

" TODO C some selection and <cwhatever>

"}}}

"{{{ custom grep

let s:grep_args = '-EI --line-number --dereference-recursive --color=always'

command! -bang -nargs=* Fgrep
      \ call fzf#vim#grep(
      \ "grep ".s:grep_args." -- "
      \ .fzf#shellescape(<q-args>),
      \ fzf#vim#with_preview(),
      \ <bang>0 )

command! -bang -nargs=* -complete=dir Dgrep
      \ call fzf#vim#grep(
      \ "grep ".s:grep_args." -- "
      \ .fzf#shellescape(s:W0(<f-args>)),
      \ extend(
      \ fzf#vim#with_preview(),
      \ s:with_dir([<f-args>]),
      \ ), <bang>0 )

command! -bang -nargs=* -complete=dir Digrep
      \ call fzf#vim#grep(
      \ "grep ".s:grep_args." -i -- "
      \ .fzf#shellescape(s:W0(<f-args>)),
      \ extend(
      \ fzf#vim#with_preview(),
      \ s:with_dir([<f-args>]),
      \ ), <bang>0)

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

" Ag from given directory
command! -bang -nargs=* -complete=dir Dag
      \ call fzf#vim#ag(s:W0(<f-args>),
      \ extend(
      \ s:with_dir([<f-args>]),
      \ extend(deepcopy(g:fzf_layout), fzf#vim#with_preview())
      \ ), <bang>0)

command! -bang -nargs=* -complete=dir Dau
      \ call fzf#vim#ag(s:W0(<f-args>),
      \ '--unrestricted',
      \ extend(
      \ s:with_dir([<f-args>]),
      \ extend(deepcopy(g:fzf_layout), fzf#vim#with_preview())
      \ ), <bang>0)

"}}}

"{{{ custom rg

let s:rgcmd = "rg --column --line-number --no-heading ".
      \ "--color=always --smart-case "
command! -bang -nargs=* -complete=dir Drg
      \ call fzf#vim#grep(
      \ s:rgcmd.' -- '.fzf#shellescape(s:W0(<f-args>)),
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

"}}}

"{{{ custom diff

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

"}}}

"{{{ arglist commands

" select from arglist
command! -bang Args call fzf#run(fzf#wrap('args',
      \ {'source': map(
      \ [argidx()]+
      \ (argidx()==0?[]:range(argc())[0:argidx()-1])+
      \ range(argc())[argidx()+1:], 'argv(v:val)')}, <bang>0))

" Not ideal, but should be good enough
command! -bang -nargs=? -complete=dir ArgeditFzf 
      \ call fzf#run({
      \ 'sink': 'argedit',
      \ 'options': '--multi',
      \ 'dir': <q-args>,
      \ })

command! -bang -nargs=? -complete=dir ArgaddFzf 
      \ call fzf#run({
      \ 'sink': 'argadd',
      \ 'options': '--multi',
      \ 'dir': <q-args>,
      \ })

command! -bang -nargs=? -complete=dir ArglistFzf 
      \ exe 'AddArglist' | ArgaddFzf <args>

"}}}

"{{{ insert mode mappings

" Insert mode completion
imap <c-X><C-w> <Plug>(fzf-complete-word)
imap <c-X>w <C-x><C-w>
imap <c-X>l <Plug>(fzf-complete-line)

imap <C-X><C-p> <Plug>(fzf-complete-path)
imap <C-X>p <C-x><C-p>

" TODO C dictionary

"}}}

"{{{ history and marks mappings

nnoremap <leader>shh :<C-u>History<CR>
nnoremap <leader>sh/ :<C-u>History/<CR>
nnoremap <leader>sh: :<C-u>History:<CR>
nnoremap <leader>shf :<C-u>Changes<CR>
nnoremap <leader>shc :<C-u>Commits<CR>
nnoremap <leader>shb :<C-u>BCommits<CR>
nnoremap <leader>shm :<C-u>Marks<CR>

"}}}

"{{{ list mappings

nnoremap <leader>slo :<C-u>Buffers<CR>
nnoremap <leader>slm :<C-u>Maps<CR>
nnoremap <leader>slH :<C-u>Helptags<CR>
nnoremap <leader>slw :<C-u>Windows<CR>
nnoremap <leader>slj :<C-u>Jumps<CR>
nnoremap <leader>slt :<C-u>Tags<CR>
nnoremap <leader>slb :<C-u>BTags<CR>
noremap <leader>slf :<C-u>Files<CR>
noremap <leader>sl<Space>f :<C-u>Files<Space>
noremap <leader>sls :<C-u>Locate<Space>
nnoremap <leader>slc :<C-u>Commands<CR>

" Not needed really
noremap <leader>slr :<C-u>FZF<CR>
noremap <leader>sl<Space>r :<C-u>FZF<Space>

"}}}

"{{{ file mappings

nnoremap <leader>sfb :<C-u>BLines<CR>
nnoremap <leader>sf<Space>b :<C-u>BLines<Space>
nnoremap <leader>sfl :<C-u>Lines<CR>
nnoremap <leader>sf<Space>l :<C-u>Lines<Space>
noremap <leader>sfa :<C-u>Ag<CR>
noremap <leader>sf<Space>a :<C-u>Ag<Space>

"}}}

"{{{ git mappings

" From official instructions
" git grep
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep '.s:grep_args.' -r -- '.fzf#shellescape(<q-args>),
      \   fzf#vim#with_preview(
      \      {'dir': Git_root()}
      \   ), <bang>0)

nnoremap <leader>gsf :<C-u>GFiles<CR>
nnoremap <leader>gss :<C-u>GFiles?<CR>

nnoremap <leader>gsc :GGrep<CR>
nnoremap <leader>gs<Space>c :GGrep<Space>

"}}}

"{{{ custom command mappings

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

" args
nnoremap <leader>sla :Args<CR>
nnoremap <leader>sl<Space>a :Args<Space>

"}}}

"{{{ path mappings

function s:PathMap(key, path, cr=1, exe=0)
  let l:ex1 = (a:exe ? "exe '" : '')
  let l:ex2 = (a:exe ? " '." : '')
  let l:end = (a:cr ? '<CR>' : '')
  for e in [
        \ ['p', 'Files'],
        \ ['o', 'ArgeditFzf'],
        \ ['a', 'ArgaddFzf'],
        \ ['A', 'ArglistFzf'],
        \ ['g', 'Dag'],
        \ ['G', 'Dau'],
        \ ['d', 'Dgrep'],
        \ ['D', 'Digrep'],
        \ ['r', 'Drg'],
        \ ['R', 'Dru'],
        \ ]
    exe 'noremap <leader>s'.e[0].a:key.' :<C-u>'.
          \ l:ex1.e[1].l:ex2.a:path.l:end
  endfor
endfunction

call s:PathMap('<Space>', '', 0)
for key in keys(g:fzf_mapping_paths)
  call s:PathMap(key, g:fzf_mapping_paths[key])
endfor
for key in keys(g:fzf_mapping_specials)
  call s:PathMap(key, g:fzf_mapping_specials[key], 1, 1)
endfor

"}}}

"{{{ actions
let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-l': function('s:populate_arg_list'),
      \ 'ctrl-a': function('s:add_arg_list'),
      \ }
"}}}
