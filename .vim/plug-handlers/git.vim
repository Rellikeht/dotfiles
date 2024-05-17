" fugitive
" TODO branches, remotes, blame
" gedit, gmove, ggrep

" Git commands

map <leader>gc :Git<CR>
map <leader>gC :Git<CR><C-w>T

map <leader>goi :G status<CR>
map <leader>goo :G log<CR>
map <leader>gor :G reflog<CR>
map <leader>god :G diff<CR>
map <leader>goD :G diff<Space>
" map <leader>got :G diff<CR><C-w>o
map <leader>gom :G mergetool<CR>

map <leader>goa :G add %<CR>
map <leader>goA :G add<Space>
map <leader>goc :G commit<CR>
map <leader>goC :G commit<Space>
map <leader>gos :G push<CR>
map <leader>goS :G push<Space>
map <leader>gol :G pull<CR>
map <leader>goL :G pull<Space>

map <leader>gob :G blame<CR>
map <leader>goB :G blame<Space>
map <leader>got :G tag  HEAD<C-b><C-b><C-b><C-b><C-b>
map <leader>goT :G tag<Space>

map <leader>goR :G revert<Space>
map <leader>gon :G reset<Space>
map <leader>goN :G reset --hard<Space>

map <leader>g;r :Gread<CR>
map <leader>g;R :Gread<Space>
map <leader>g;w :Gwrite<CR>
map <leader>g;W :Gwrite<Space>
map <leader>g;t :tab Git --paginate<CR>
map <leader>g;v :vert Git --paginate<CR>
map <leader>g;s :Git --paginate<CR>

map <leader>gti :G status<CR>
map <leader>gto :G log<CR>
map <leader>gtr :G reflog<CR>
map <leader>gtd :G diff<CR>
map <leader>gtD :G diff<Space>

" TODO more commands

" Diff

map <leader>gds :Gvdiffsplit<CR>
map <leader>gdS :Gvdiffsplit!<CR>
map <leader>gdh :Gdiffsplit<CR>
map <leader>gdH :Gdiffsplit!<CR>
map <leader>gdu :diffupdate<CR>

map <leader>gdp :diffput<CR>
map <leader>gdg :diffget<CR>

function DiffGet(pane)
    execute 'diffget' a:pane
    diffupdate
endfunction

function DiffPut(pane)
    execute 'diffget' a:pane
    diffupdate
endfunction

" TODO doesn't find appropriate buffer :(
" No idea how to do that properly

" ??
map <leader>gg0 :call DiffGet('//0')<CR>
map <leader>gg1 :call DiffGet('//1')<CR>
map <leader>gg2 :call DiffGet('//2')<CR>
map <leader>gg3 :call DiffGet('//3')<CR>

" ??
map <leader>gp0 :call DiffPut('//0')<CR>
map <leader>gp1 :call DiffPut('//1')<CR>
map <leader>gp2 :call DiffPut('//2')<CR>
map <leader>gp3 :call DiffPut('//3')<CR>

" ????
map <leader>gpf :call DiffPut(expand('%:p'))<CR>
map <leader>ggf :call DiffGet(expand('%:p'))<CR>

" Probably not very useful
map <leader>gp [c
map <leader>gn ]c

" fzf
map <leader>gff :GFiles<CR>
map <leader>gfs :GFiles?<CR>

" signify

map <leader>gst :SignifyToggle<CR>
map <leader>gsh :SignifyToggleHighlight<CR>
map <leader>gsD :SignifyDisableAll<CR>
map <leader>gsE :SignifyEnableAll<CR>
map <leader>gsr :SignifyRefresh<CR>
map <leader>gsl :SignifyList<CR>

map <leader>gsd :SignifyHunkDiff<CR>
map <leader>gsu :SignifyHunkUndo<CR>
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

" gv

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
