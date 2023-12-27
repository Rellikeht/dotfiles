" fugitive

map <leader>gd :Gvdiffsplit<CR>
map <leader>gsd :Gvdiffsplit

" so there is dp and do
map <leader>gop :diffput<CR>
map <leader>gog :diffget<CR>
map <leader>gb [c
map <leader>gf ]c

map <leader>gp0 :diffput //0<CR>
map <leader>gp1 :diffput //1<CR>
map <leader>gp2 :diffput //2<CR>
map <leader>gp3 :diffput //3<CR>

function DiffGet(pane)
    execute 'diffget'.a:pane
    diffupdate
endfunction

map <leader>gg0 :call DiffGet('//0')<CR>
map <leader>gg1 :call DiffGet('//1')<CR>
map <leader>gg2 :call DiffGet('//2')<CR>
map <leader>gg3 :call DiffGet('//3')<CR>

map <leader>gm :G mergetool<CR>
map <leader>gc :Git<CR>
map <leader>gss :G status<CR>
map <leader>gl :G log<CR>
map <leader>gr :G reflog<CR>

map <leader>goa :G add %<CR>
map <leader>goc :G commit<CR>
map <leader>gos :G push<CR>
map <leader>gol :G pull<CR>
map <leader>gor :Gread<CR>
map <leader>gow :Gwrite<CR>

map <leader>GF :GFiles<CR>
map <leader>GD :GDelete<CR>

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

map <leader>gst :SignifyToggle<CR>
map <leader>gsh :SignifyToggleHighlight<CR>
map <leader>gsd :SignifyDisableAll<CR>
map <leader>gse :SignifyEnableAll<CR>
map <leader>gsr :SignifyRefresh<CR>
map <leader>gsl :SignifyList<CR>

map <leader>gh :SignifyHunkDiff<CR>
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
