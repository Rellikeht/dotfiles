" :help fzf
" :help fzf-vim

let $FZF_DEFAULT_COMMAND='find .'

" KEYS

" Insert mode completion
imap <c-x>w <plug>(fzf-complete-word)
imap <c-x>p <plug>(fzf-complete-path)
imap <c-x>l <plug>(fzf-complete-line)

nnoremap <leader>sff :FZF<CR>
nnoremap <leader>svb :Buffers<CR>
nnoremap <leader>sph :FZF ~<CR>
nnoremap <leader>spT :FZF ~/Templates<CR>
nnoremap <leader>sp2 :FZF ../..<CR>
nnoremap <leader>sp3 :FZF ../../..<CR>
nnoremap <leader>sp4 :FZF ../../../..<CR>
nnoremap <leader>sp5 :FZF ../../../../..<CR>

nnoremap <leader>slf :Files<CR>
nnoremap <leader>slF :Files<Space>
nnoremap <leader>sls :Locate<Space>
nnoremap <leader>sla :Ag<CR>
nnoremap <leader>slA :Ag<Space>

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

nnoremap <leader>svm :Maps<CR>
nnoremap <leader>svH :Helptags<CR>
nnoremap <leader>svw :Windows<CR>
nnoremap <leader>svj :Jumps<CR>

nnoremap <leader>gff :GFiles<CR>
nnoremap <leader>gfs :GFiles?<CR>

command! -bang -nargs=? -complete=dir Fdiffs
            \ call fzf#run(fzf#wrap({
            \ 'sink': 'diffs',
            \ 'dir': <q-args>,
            \ 'options': [
            \ '--preview',
            \ 'delta '.expand("%:p").' {}',
            \ '--preview-window',
            \ '60%,right',
            \ ],
            \ },
            \ <bang>0))

" TODO do this better
command! -bang -nargs=? -complete=dir Fdiffv
            \ call fzf#run(fzf#wrap({
            \ 'sink': 'vert diffs',
            \ 'dir': <q-args>,
            \ 'options': [
            \ '--preview',
            \ 'delta '.expand("%:p").' {}',
            \ '--preview-window',
            \ '60%,right',
            \ ],
            \ },
            \ <bang>0))

nnoremap <leader>sds :Fdiffs<CR>
nnoremap <leader>sdS :Fdiffs<Space>
nnoremap <leader>sdv :Fdiffv<CR>
nnoremap <leader>sdV :Fdiffv<Space>

" TODO tmux
" May be too painful

" MORE KEYS

" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit',
            \ }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
    copen
    cc
endfunction

let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" SETTINGS

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" COLORS

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
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
            \ 'header':  ['fg', 'Comment'] }

" LAYOUT

" " Default fzf layout
" " - Popup window (center of the screen)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" " - Popup window (center of the current window)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }

" " - Popup window (anchored to the bottom of the current window)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }

" - down / up / left / right
" let g:fzf_layout = { 'down': '40%' }

" TODO change position in case of unusal layout
" Simple yet powerful amount
let g:fzf_percent = '55%'
if exists('$TMUX')
    " let g:fzf_layout = { 'tmux': '-p90%,60%' }
    let g:fzf_layout = { 'tmux': '-d'.g:fzf_percent }
else
    " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
    let g:fzf_layout = { 'down': g:fzf_percent }
endif

" " - Window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }
