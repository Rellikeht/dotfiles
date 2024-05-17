" :help fzf
" :help fzf-vim

let $FZF_DEFAULT_COMMAND='find .'

" KEYS

map <leader>sf :FZF<CR>
map <leader>sb :Buffers<CR>
map <leader>sph :FZF ~<CR>
map <leader>spT :FZF ~/Templates<CR>
map <leader>sp2 :FZF ../..<CR>
map <leader>sp3 :FZF ../../..<CR>
map <leader>sp4 :FZF ../../../..<CR>
map <leader>sp5 :FZF ../../../../..<CR>

map <leader>slf :Files<CR>
map <leader>slF :Files<Space>
map <leader>sls :Locate<Space>
map <leader>sla :Ag<CR>
map <leader>slA :Ag<Space>

map <leader>slb :BLines<CR>
map <leader>slB :BLines<Space>
map <leader>sll :Lines<CR>
map <leader>slL :Lines<Space>

map <leader>shh :History<CR>
map <leader>shc :Changes<CR>
map <leader>sh/ :History/<CR>
map <leader>sh: :History:<CR>
map <leader>shC :Commits<CR>
map <leader>shm :Marks<CR>

map <leader>sm :Maps<CR>
map <leader>sH :Helptags<CR>
map <leader>sw :Windows<CR>
map <leader>sj :Jumps<CR>

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

" Simple yet powerful amount
let g:fzf_percent = '60%'
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
