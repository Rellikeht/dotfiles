" fugitive

" TODO gmove, ggrep
" TODO gedit ?
" this is so fucked, there is exponentially too much of it
" TODO procedural creation ?

"{{{ basic commands

nnoremap <silent> <leader>gg :Git<CR>
nnoremap <silent> <leader>g;g :Git<CR><C-w>T
nnoremap <silent> <C-w><leader>gg :tab Git<CR>

nnoremap <leader>goc :G checkout<CR>
nnoremap <leader>goC :G checkout<Space>
nnoremap <silent> <leader>goa :G add %<CR>
nnoremap <leader>goA :G add<Space>
nnoremap <silent> <leader>goc :G commit<CR>
nnoremap <leader>goC :G commit<Space>
nnoremap <silent> <leader>gos :G push<CR>
nnoremap <leader>goS :G push<Space>
nnoremap <silent> <leader>gol :G pull<CR>
nnoremap <leader>goL :G pull<Space>

nnoremap <leader>gor :G rebase<Space>
nnoremap <leader>goR :G rebase<CR>

"}}}

"{{{ info

nnoremap <silent> <leader>gis :G status<CR>
nnoremap <silent> <leader>gil :G log<CR>
nnoremap <silent> <leader>gib :G blame<CR>
nnoremap <silent> <leader>gir :G reflog<CR>
nnoremap <silent> <leader>gio :G remote<CR>
nnoremap <silent> <leader>gii :G remote show<CR>

nnoremap <leader>giS :G status<Space>
nnoremap <leader>giL :G log<Space>
nnoremap <leader>giB :G blame<Space>
nnoremap <leader>giR :G reflog<Space>
nnoremap <leader>giO :G remote<Space>
nnoremap <leader>giI :G remote show<Space>

nnoremap <silent> <C-w><leader>gis :tab G status<CR>
nnoremap <silent> <C-w><leader>gil :tab G log<CR>
nnoremap <silent> <C-w><leader>gib :tab G blame<CR>
nnoremap <silent> <C-w><leader>gir :tab G reflog<CR>
nnoremap <silent> <C-w><leader>gio :tab G remote<CR>
nnoremap <silent> <C-w><leader>gii :tab G remote show<CR>

nnoremap <C-w><leader>giS :tab G status<Space>
nnoremap <C-w><leader>giL :tab G log<Space>
nnoremap <C-w><leader>giB :tab G blame<Space>
nnoremap <C-w><leader>giR :tab G reflog<Space>
nnoremap <C-w><leader>giO :tab G remote<Space>
nnoremap <C-w><leader>giI :tab G remote show<Space>

"}}}

"{{{ diff and merge tools

nnoremap <silent> <leader>gdc :G diff HEAD<CR>
nnoremap <silent> <C-w><leader>gdc :tab G diff HEAD<CR>

nnoremap <silent> <leader>gdd :G diff<CR>
nnoremap <silent> <leader>gdm :G mergetool<CR>

nnoremap <leader>gdD :G diff<Space>
nnoremap <leader>gdm :G mergetool<Space>

nnoremap <silent> <C-w><leader>gdd :tab G diff<CR>
nnoremap <silent> <C-w><leader>gdm :tab G mergetool<CR>

nnoremap <C-w><leader>gdD :tab G diff<Space>
nnoremap <C-w><leader>gdm :tab G mergetool<Space>

"}}}

"{{{ modifications

nnoremap <leader>gmr :G revert<Space>
nnoremap <leader>gmn :G reset<Space>
nnoremap <leader>gmh :G reset --hard<Space>

"}}}

"{{{ advanced

nnoremap <leader>gaa :G add .<CR>

nnoremap <leader>gar :G rebase --continue<CR>
nnoremap <leader>gam :G merge --continue<CR>

nnoremap <leader>gaR :G rebase --abort<CR>
nnoremap <leader>gaM :G merge --abort<CR>

"}}}

"{{{ commit

nnoremap <leader>gca :G commit --amend<CR>
nnoremap <leader>gcp :G commit --patch<CR>
nnoremap <leader>gcd :G commit --dry-run<CR>
nnoremap <leader>gcf :G commit --fixup<CR>
nnoremap <leader>gcr :G commit --fixup=reword<CR>

nnoremap <leader>gcA :G commit --amend<Space>
nnoremap <leader>gcP :G commit --patch<Space>
nnoremap <leader>gcD :G commit --dry-run<Space>
nnoremap <leader>gcF :G commit --fixup<Space>
nnoremap <leader>gcR :G commit --fixup=reword<Space>

"}}}

"{{{ push

nnoremap <leader>ghf :G push --force<CR>
nnoremap <leader>gha :G push --all<CR>
nnoremap <leader>ghu :G push --set-upstream<CR>
nnoremap <leader>ght :G push --all --force<CR>

nnoremap <leader>ghF :G push --force<Space>
nnoremap <leader>ghA :G push --all<Space>
nnoremap <leader>ghU :G push --set-upstream<Space>
nnoremap <leader>ghT :G push --all --force<Space>

"}}}

"{{{ pull

nnoremap <leader>glf :G pull --force<CR>
nnoremap <leader>glr :G pull --rebase<CR>
nnoremap <leader>gli :G pull --rebase=interactive<CR>
nnoremap <leader>gla :G pull --all<CR>
nnoremap <leader>gld :G pull --dry-run<CR>
nnoremap <leader>glu :G pull --set-upstream<CR>

nnoremap <leader>glF :G pull --force<Space>
nnoremap <leader>glR :G pull --rebase<Space>
nnoremap <leader>glI :G pull --rebase=interactive<Space>
nnoremap <leader>glA :G pull --all<Space>
nnoremap <leader>glD :G pull --dry-run<Space>
nnoremap <leader>glU :G pull --set-upstream<Space>

"}}}

"{{{ stash

nnoremap <leader>gts :G stash push<CR>
nnoremap <leader>gtp :G stash pop<CR>
nnoremap <leader>gta :G stash apply<CR>
nnoremap <leader>gtd :G stash drop<CR>
nnoremap <leader>gtw :G stash save<CR>
nnoremap <leader>gtb :G stash branch<CR>
nnoremap <leader>gtc :G stash clear<CR>
nnoremap <leader>gtm :G stash create<CR>

nnoremap <leader>gtS :G stash push<Space>
nnoremap <leader>gtP :G stash pop<Space>
nnoremap <leader>gtA :G stash apply<Space>
nnoremap <leader>gtD :G stash drop<Space>
nnoremap <leader>gtW :G stash save<Space>
nnoremap <leader>gtB :G stash branch<Space>
nnoremap <leader>gtC :G stash clear<Space>
nnoremap <leader>gtM :G stash create<Space>

nnoremap <leader>gtl :G stash list<CR>
nnoremap <leader>gtv :G stash show<CR>
nnoremap <leader>gtL :G stash list<Space>
nnoremap <leader>gtV :G stash show<Space>

nnoremap <C-w><leader>gtl :tab G stash list<CR>
nnoremap <C-w><leader>gtv :tab G stash show<CR>
nnoremap <C-w><leader>gtL :tab G stash list<Space>
nnoremap <C-w><leader>gtV :tab G stash show<Space>

"}}}

"{{{ branches

nnoremap <leader>gbt :G tag  HEAD<left><left><left><left><left>
nnoremap <leader>gbf :G checkout --force<CR>
nnoremap <leader>gbb :G branch<CR>
nnoremap <leader>gbo :G checkout --ours<CR>
nnoremap <leader>gbe :G checkout --theirs<CR>
nnoremap <leader>gbm :G checkout --merge<CR>

nnoremap <leader>gbT :G tag<Space>
nnoremap <leader>gbF :G checkout --force<Space>
nnoremap <leader>gbB :G branch<Space>
nnoremap <leader>gbO :G checkout --ours<Space>
nnoremap <leader>gbE :G checkout --theirs<Space>
nnoremap <leader>gbM :G checkout --merge<Space>

"}}}

"{{{ G*

nnoremap <silent> <leader>g;r :Gread<CR>
nnoremap <silent> <leader>g;R :Gread<Space>
nnoremap <silent> <leader>g;w :Gwrite<CR>
nnoremap <silent> <leader>g;W :Gwrite<Space>
nnoremap <silent> <leader>g;s :Git --paginate<CR>

nnoremap <silent> <leader>g;b :GBrowse<CR>
nnoremap <silent> <leader>g;<Space>b :GBrowse<Space>
" TODO more GBrowses

" TODO sourceforge

" }}}

"{{{ diff split

nnoremap <silent> <leader>gds :Gvdiffsplit<CR>
nnoremap <silent> <leader>gdS :Gvdiffsplit!<CR>
nnoremap <silent> <leader>gdh :Gdiffsplit<CR>
nnoremap <silent> <leader>gdH :Gdiffsplit!<CR>

nnoremap <silent> <C-w><leader>gds :tab Gvdiffsplit<CR>
nnoremap <silent> <C-w><leader>gdS :tab Gvdiffsplit!<CR>
nnoremap <silent> <C-w><leader>gdh :tab Gdiffsplit<CR>
nnoremap <silent> <C-w><leader>gdH :tab Gdiffsplit!<CR>

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
