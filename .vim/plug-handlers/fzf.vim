" TODO A arguments, local arguments
" TODO A make this help with new setup
" TODO B multiple selections
" TODO C which can be in visual
" TODO D <C-w> (tab) versions

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

let fzf_preview_default = 'right,55%'
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

" Insert mode completion
imap <c-x>w <plug>(fzf-complete-word)
imap <c-x>p <plug>(fzf-complete-path)
imap <c-x>l <plug>(fzf-complete-line)

" Not needed really
nnoremap <leader>sff :FZF<CR>

nnoremap <leader>slf :Files<CR>
nnoremap <leader>slF :Files<Space>
nnoremap <leader>sls :Locate<Space>
nnoremap <leader>sla :Ag<CR>
nnoremap <leader>slA :Ag<Space>

"}}}

"{{{ file mappings

nnoremap <leader>sp1 :Files ..<CR>
nnoremap <leader>sp2 :Files ../..<CR>
nnoremap <leader>sp3 :Files ../../..<CR>
nnoremap <leader>sp4 :Files ../../../..<CR>
nnoremap <leader>sp5 :Files ../../../../..<CR>
nnoremap <leader>sp6 :Files ../../../../../..<CR>
nnoremap <leader>sp7 :Files ../../../../../../..<CR>
nnoremap <leader>sp8 :Files ../../../../../../../..<CR>
nnoremap <leader>sp9 :Files ../../../../../../../../..<CR>

nnoremap <leader>sph :Files ~<CR>
nnoremap <leader>spt :Files ~/Templates<CR>
nnoremap <leader>spd :Files ~/Dbackup<CR>
nnoremap <leader>spD :Files ~/Downloads<CR>
nnoremap <leader>spf :Files ~/Documents<CR>
nnoremap <leader>spe :Files /etc<CR>
nnoremap <leader>spg :Files ~/gits<CR>

"}}}

"{{{ fzf-vim additional mappings

nnoremap <leader>slb :BLines<CR>
nnoremap <leader>slB :BLines<Space>
nnoremap <leader>sll :Lines<CR>
nnoremap <leader>slL :Lines<Space>

nnoremap <leader>shh :History<CR>
nnoremap <leader>shc :Changes<CR>
nnoremap <leader>sh/ :History/<CR>
nnoremap <leader>sh: :History:<CR>
nnoremap <leader>shC :Commits<CR>
nnoremap <leader>shm :Marks<CR>

nnoremap <leader>s;f :Buffers<CR>
nnoremap <leader>s;m :Maps<CR>
nnoremap <leader>s;H :Helptags<CR>
nnoremap <leader>s;w :Windows<CR>
nnoremap <leader>s;j :Jumps<CR>

nnoremap <leader>gff :GFiles<CR>
nnoremap <leader>gfs :GFiles?<CR>

"}}}

"{{{ custom commands

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

command! -bang -nargs=* Ah 
            \ call fzf#vim#ag(<q-args>, '--hidden', fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Au 
            \ call fzf#vim#ag(<q-args>, '--unrestricted', fzf#vim#with_preview(), <bang>0)

command! -bang Args call fzf#run(fzf#wrap('args',
    \ {'source': map([argidx()]+(argidx()==0?[]:range(argc())[0:argidx()-1])+range(argc())[argidx()+1:], 'argv(v:val)')}, <bang>0))

"}}}

"{{{ custom command mappings

nnoremap <leader>sds :Fdiffs<CR>
nnoremap <leader>sdS :Fdiffs<Space>
nnoremap <leader>sdv :Fdiffv<CR>
nnoremap <leader>sdV :Fdiffv<Space>

nnoremap <leader>slp :Fgrep<CR>
nnoremap <leader>slP :Fgrep<Space>
nnoremap <leader>slg :GGrep<CR>
nnoremap <leader>slG :GGrep<Space>
nnoremap <leader>slh :Ah<CR>
nnoremap <leader>slH :Ah<Space>
nnoremap <leader>slu :Au<CR>
nnoremap <leader>slU :Au<Space>

nnoremap <leader>sfa :Args<CR>
nnoremap <leader>sfA :Args<Space>

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
