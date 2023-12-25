" TODO some simple fugitive commands
" that won't interfere with other plugins

map <leader>gd :Gvdiffsplit<CR>
map <leader>gsd :Gvdiffsplit
map <leader>gc :Git<CR>
map <leader>gss :G status<CR>
map <leader>gl :G log<CR>
map <leader>gr :G reflog<CR>

map <leader>gfa :G add %<CR>

" gv

" TODO somehow learn to use that
map <leader>gv :GV<CR>
map <leader>gV :GV!<CR>
map <leader>g? :GV?<CR>

" - `o` or `<cr>` on a commit to display the content of it
" - `o` or `<cr>` on commits to display the diff in the range
" - `O` opens a new tab instead
" - `gb` for `:GBrowse`
" - `]]` and `[[` to move between commits
" - `.` to start command-line with `:Git [CURSOR] SHA` à la fugitive
" - `q` or `gq` to close

" signify

map <leader>gsT :SignifyToggle<CR>
map <leader>gsH :SignifyToggleHighlight<CR>
map <leader>gsR :SignifyRefresh<CR>
map <leader>gsL :SignifyList<CR>
map <leader>gsD :SignifyDisableAll<CR>
map <leader>gsE :SignifyEnableAll<CR>

map <leader>gD :SignifyHunkDiff<CR>
map <leader>gu :SignifyHunkUndo<CR>
map <leader>gj <plug>(signify-next-hunk)
map <leader>gk <plug>(signify-prev-hunk)
map <leader>gJ 9999<leader>gj
map <leader>gK 9999<leader>gk
map <leader>gsf :echo sy#repo#get_stats_decorated('.')<CR>
map <leader>gsF :echo sy#repo#get_stats_decorated(expand('%'))<CR>

autocmd User SignifyHunk call s:show_current_hunk()

function! s:show_current_hunk() abort
    let h = sy#util#get_hunk_stats()
    if !empty(h)
        echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
    endif
endfunction

" default updatetime 4000ms is not good for async update
set updatetime=100
