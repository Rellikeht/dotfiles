" fugitive

" TODO remotes, gedit, gmove, ggrep
" this is so fucked, there is exponentially too much of it

"{{{ basic commands

nnoremap <silent> <leader>gc :Git<CR>
nnoremap <silent> <leader>gC :Git<CR><C-w>T

nnoremap <silent> <leader>god :G diff<CR>
nnoremap <leader>goD :G diff<Space>
nnoremap <silent> <leader>gom :G mergetool<CR>

" ??
" map <silent> <leader>goq :G diff<CR><C-w>o

"}}}

"{{{ info

nnoremap <silent> <leader>goi :G status<CR>
nnoremap <silent> <leader>goo :G log<CR>
nnoremap <silent> <leader>goI :G reflog<CR>

nnoremap <silent> <leader>gob :G blame<CR>
nnoremap <leader>goB :G blame<Space>

"}}}

"{{{ modifications

nnoremap <silent> <leader>goa :G add %<CR>
nnoremap <leader>goA :G add<Space>
nnoremap <silent> <leader>goc :G commit<CR>
nnoremap <leader>goC :G commit<Space>
nnoremap <silent> <leader>gos :G push<CR>
nnoremap <leader>goS :G push<Space>
nnoremap <silent> <leader>gol :G pull<CR>
nnoremap <leader>goL :G pull<Space>

nnoremap <leader>goR :G revert<Space>
nnoremap <leader>gon :G reset<Space>
nnoremap <leader>goN :G reset --hard<Space>
nnoremap <leader>gor :G rebase<Space>

"}}}

"{{{ advanced

nnoremap <silent> <leader>gac :G commit --amend<CR>
nnoremap <leader>gaC :G commit --amend<Space>
nnoremap <leader>gas :G push --force<Space>

nnoremap <leader>gar :G remote<CR>
nnoremap <leader>gaR :G remote<Space>
nnoremap <leader>gaI :G remote show<Space>

"}}}

"{{{ branches

nnoremap <leader>got :G tag  HEAD<C-b><C-b><C-b><C-b><C-b>
nnoremap <leader>goT :G tag<Space>
nnoremap <leader>goh :G checkout<Space>
nnoremap <leader>goH :G branch<Space>

"}}}

"{{{ G*

nnoremap <silent> <leader>g;r :Gread<CR>
nnoremap <silent> <leader>g;R :Gread<Space>
nnoremap <silent> <leader>g;w :Gwrite<CR>
nnoremap <silent> <leader>g;W :Gwrite<Space>
nnoremap <silent> <leader>g;s :Git --paginate<CR>

" }}}

"{{{ split and tab versions

nnoremap <silent> <leader>g;t :tab Git --paginate<CR>
nnoremap <silent> <leader>g;v :vert Git --paginate<CR>

nnoremap <silent> <leader>gti :tab G status<CR>
nnoremap <silent> <leader>gto :tab G log<CR>
nnoremap <silent> <leader>gtI :tab G reflog<CR>
nnoremap <silent> <leader>gtd :tab G diff<CR>
nnoremap <leader>gtD :tab G diff<Space>

"}}}

"{{{ diff

nnoremap <silent> <leader>gds :Gvdiffsplit<CR>
nnoremap <silent> <leader>gdS :Gvdiffsplit!<CR>
nnoremap <silent> <leader>gdh :Gdiffsplit<CR>
nnoremap <silent> <leader>gdH :Gdiffsplit!<CR>

" TODO there may be other (better ?) map <silent>s for this

"}}}

"{{{ signify

nnoremap <silent> <leader>gst :SignifyToggle<CR>
nnoremap <silent> <leader>gsh :SignifyToggleHighlight<CR>
nnoremap <silent> <leader>gsD :SignifyDisableAll<CR>
nnoremap <silent> <leader>gsE :SignifyEnableAll<CR>
nnoremap <silent> <leader>gsr :SignifyRefresh<CR>
nnoremap <silent> <leader>gsl :SignifyList<CR>

nnoremap <silent> <leader>gsd :SignifyHunkDiff<CR>
nnoremap <silent> <leader>gsu :SignifyHunkUndo<CR>
nnoremap <leader>gj <plug>(signify-next-hunk)
nnoremap <leader>gk <plug>(signify-prev-hunk)
nnoremap <leader>gJ 9999<leader>gj
nnoremap <leader>gK 9999<leader>gk
nnoremap <silent> <leader>gsf :echo sy#repo#get_stats_decorated('.')<CR>
nnoremap <silent> <leader>gsF :echo sy#repo#get_stats_decorated(expand('%'))<CR>

autocmd User SignifyHunk call s:show_current_hunk()

function! s:show_current_hunk() abort
    let h = sy#util#get_hunk_stats()
    if !empty(h)
        echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
    endif
endfunction

" default updatetime 4000ms is not good for async update
set updatetime=50

"}}}

"{{{ gv

nnoremap <silent> <leader>gv :GV<CR>
nnoremap <silent> <leader>gV :GV!<CR>
nnoremap <silent> <leader>g? :GV?<CR>

"}}}

"{{{ info

" - `o` or `<cr>` on a commit to display the content of it
" - `o` or `<cr>` on commits to display the diff in the range
" - `O` opens a new tab instead
" - `gb` for `:GBrowse`
" - `]]` and `[[` to move between commits
" - `.` to start command-line with `:Git [CURSOR] SHA` à la fugitive
" - `q` or `gq` to close

"}}}
