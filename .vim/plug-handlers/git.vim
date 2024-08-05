"{{{ settings

autocmd FileType gitcommit,gitsendmail
      \ setlocal textwidth=72

"}}}

"{{{ fugitive

"{{{ TODO
" TODO gmove, ggrep
" TODO gedit ?
" this is so fucked, there is exponentially too much of it
" TODO procedural creation ?
"}}}

"{{{ G* (g)

nnoremap <silent> <leader>ggc :Git\|e<CR>
nnoremap <silent> <leader>ggC :Git\|e<CR><C-w>T
nnoremap <silent> <C-w><leader>ggc :tab Git\|e<CR>

nnoremap <silent> <leader>ggr :Gread<CR>
nnoremap <silent> <leader>gg<Space>r :Gread<Space>
nnoremap <silent> <leader>ggw :Gwrite<CR>
nnoremap <silent> <leader>gg<Space>w :Gwrite<Space>

nnoremap <silent> <leader>ggb :GBrowse<CR>
nnoremap <silent> <leader>gg<Space>b :GBrowse<Space>

nnoremap <silent> <leader>ggs :Gvdiffsplit<CR>
nnoremap <silent> <leader>gg<Space>s :Gvdiffsplit!<CR>
nnoremap <silent> <leader>ggh :Gdiffsplit<CR>
nnoremap <silent> <leader>gg<Space>h :Gdiffsplit!<CR>

nnoremap <silent> <C-w><leader>ggs :tab Gvdiffsplit<CR>
nnoremap <silent> <C-w><leader>gg<Space>s :tab Gvdiffsplit!<CR>
nnoremap <silent> <C-w><leader>ggh :tab Gdiffsplit<CR>
nnoremap <silent> <C-w><leader>gg<Space>h :tab Gdiffsplit!<CR>

" TODO sourceforge

" }}}

"{{{ info (i)

nnoremap <silent> <leader>gis :G status<CR>
nnoremap <silent> <leader>gil :G log<CR>
nnoremap <silent> <leader>gib :G blame<CR>
nnoremap <silent> <leader>gir :G reflog<CR>
nnoremap <silent> <leader>gio :G remote<CR>
nnoremap <silent> <leader>gi- :G remote show<CR>
nnoremap <silent> <leader>gii :G show<CR>

nnoremap <leader>gi<space>s :G status<Space>
nnoremap <leader>gi<space>l :G log<Space>
nnoremap <leader>gi<space>b :G blame<Space>
nnoremap <leader>gi<space>r :G reflog<Space>
nnoremap <leader>gi<space>o :G remote<Space>
nnoremap <leader>gi<space>- :G remote show<Space>
nnoremap <leader>gi<space>i :G show<Space>

nnoremap <silent> <C-w><leader>gis :tab G status<CR>
nnoremap <silent> <C-w><leader>gil :tab G log<CR>
nnoremap <silent> <C-w><leader>gib :tab G blame<CR>
nnoremap <silent> <C-w><leader>gir :tab G reflog<CR>
nnoremap <silent> <C-w><leader>gio :tab G remote<CR>
nnoremap <silent> <C-w><leader>gi- :tab G remote show<CR>
nnoremap <silent> <C-w><leader>gii :tab G show<CR>

nnoremap <C-w><leader>gi<Space>s :tab G status<Space>
nnoremap <C-w><leader>gi<Space>l :tab G log<Space>
nnoremap <C-w><leader>gi<Space>b :tab G blame<Space>
nnoremap <C-w><leader>gi<Space>r :tab G reflog<Space>
nnoremap <C-w><leader>gi<Space>o :tab G remote<Space>
nnoremap <C-w><leader>gi<Space>- :tab G remote show<Space>
nnoremap <C-w><leader>gi<Space>i :tab G show<Space>

"}}}

"{{{ diff and merge (i)

nnoremap <silent> <leader>gih :G diff HEAD<CR>
nnoremap <silent> <C-w><leader>gi<Space>h :tab G diff HEAD
nnoremap <silent> <leader>gih :G diff HEAD<CR>
nnoremap <silent> <C-w><leader>gi<Space>h :tab G diff HEAD

nnoremap <silent> <leader>gid :G diff<CR>
nnoremap <silent> <leader>gim :G mergetool<CR>
nnoremap <leader>gi<Space>d :G diff<Space>
nnoremap <leader>gim :G mergetool<Space>

nnoremap <silent> <C-w><leader>gid :tab G diff<CR>
nnoremap <silent> <C-w><leader>gim :tab G mergetool<CR>
nnoremap <C-w><leader>gi<Space>d :tab G diff<Space>
nnoremap <C-w><leader>gim :tab G mergetool<Space>

"}}}

"{{{ stash (t)

nnoremap <leader>gts :G stash push<CR>
nnoremap <leader>gtp :G stash pop<CR>
nnoremap <leader>gta :G stash apply<CR>
nnoremap <leader>gtd :G stash drop<CR>
nnoremap <leader>gtb :G stash branch<CR>
nnoremap <leader>gt! :G stash clear<CR>

nnoremap <leader>gt<Space>s :G stash push<Space>
nnoremap <leader>gt;s :G stash push -m<Space>
nnoremap <leader>gt<Space>p :G stash pop<Space>
nnoremap <leader>gt<Space>a :G stash apply<Space>
nnoremap <leader>gt<Space>d :G stash drop<Space>
nnoremap <leader>gt<Space>b :G stash branch<Space>

nnoremap <leader>gtl :G stash list<CR>
nnoremap <leader>gtv :G stash show<CR>
nnoremap <leader>gt<Space>l :G stash list<Space>
nnoremap <leader>gt<Space>v :G stash show<Space>

nnoremap <C-w><leader>gtl :tab G stash list<CR>
nnoremap <C-w><leader>gtv :tab G stash show<CR>
nnoremap <C-w><leader>gt<Space>l :tab G stash list<Space>
nnoremap <C-w><leader>gt<Space>v :tab G stash show<Space>

"}}}

" TODO A go from here

"{{{ basic commands (o)

nnoremap <silent> <leader>goa :G add %<CR>
nnoremap <leader>go<Space>a :G add<Space>

nnoremap <silent> <leader>goc :G commit<CR>
nnoremap <leader>go<Space>c :G commit<Space>

nnoremap <silent> <leader>gos :G push<CR>
nnoremap <leader>go<Space>s :G push<Space>

nnoremap <silent> <leader>gol :G pull<CR>
nnoremap <leader>go<Space>l :G pull<Space>

nnoremap <leader>gor :G rebase<Space>
nnoremap <leader>go<Space>r :G rebase<CR>

"}}}

"{{{ modifications ???

" nnoremap <leader>gmr :G revert<Space>
" nnoremap <leader>gmn :G reset<Space>
" nnoremap <leader>gmh :G reset --hard<Space>

"}}}

"{{{ advanced ???

" nnoremap <leader>gaa :G add .<CR>

" nnoremap <leader>gar :G rebase --continue<CR>
" nnoremap <leader>gam :G merge --continue<CR>

" nnoremap <leader>ga<Space>r :G rebase --abort<CR>
" nnoremap <leader>ga<Space>m :G merge --abort<CR>

"}}}

"{{{ commit (c) ???

nnoremap <leader>gca :G commit --amend<CR>
nnoremap <leader>gcp :G commit --patch<CR>
nnoremap <leader>gcd :G commit --dry-run<CR>
nnoremap <leader>gcf :G commit --fixup<CR>
nnoremap <leader>gcr :G commit --fixup=reword<CR>

nnoremap <leader>gc<Space>a :G commit --amend<Space>
nnoremap <leader>gc<Space>p :G commit --patch<Space>
nnoremap <leader>gc<Space>d :G commit --dry-run<Space>
nnoremap <leader>gc<Space>f :G commit --fixup<Space>
nnoremap <leader>gc<Space>r :G commit --fixup=reword<Space>

"}}}

"{{{ push (h) ???

nnoremap <leader>ghf :G push --force<CR>
nnoremap <leader>gha :G push --all<CR>
nnoremap <leader>ghu :G push --set-upstream<CR>
nnoremap <leader>ght :G push --all --force<CR>

nnoremap <leader>gh<Space>f :G push --force<Space>
nnoremap <leader>gh<Space>a :G push --all<Space>
nnoremap <leader>gh<Space>u :G push --set-upstream<Space>
nnoremap <leader>gh<Space>t :G push --all --force<Space>

"}}}

"{{{ pull (l) ???

nnoremap <leader>glf :G pull --force<CR>
nnoremap <leader>glr :G pull --rebase<CR>
nnoremap <leader>gli :G pull --rebase=interactive<CR>
nnoremap <leader>gla :G pull --all<CR>
nnoremap <leader>gld :G pull --dry-run<CR>
nnoremap <leader>glu :G pull --set-upstream<CR>

nnoremap <leader>gl<Space>f :G pull --force<Space>
nnoremap <leader>gl<Space>r :G pull --rebase<Space>
nnoremap <leader>gl<Space>i :G pull --rebase=interactive<Space>
nnoremap <leader>gl<Space>a :G pull --all<Space>
nnoremap <leader>gl<Space>d :G pull --dry-run<Space>
nnoremap <leader>gl<Space>u :G pull --set-upstream<Space>

"}}}

"{{{ branches (b)

" TODO
nnoremap <leader>goc :G checkout<CR>
nnoremap <leader>go<Space>c :G checkout<Space>

nnoremap <leader>gbt :G tag  HEAD<left><left><left><left><left>
nnoremap <leader>gbf :G checkout --force<CR>
nnoremap <leader>gbb :G branch<CR>
nnoremap <leader>gbo :G checkout --ours<CR>
nnoremap <leader>gbe :G checkout --theirs<CR>
nnoremap <leader>gbm :G checkout --merge<CR>

nnoremap <leader>gb<Space>t :G tag<Space>
nnoremap <leader>gb<Space>f :G checkout --force<Space>
nnoremap <leader>gb<Space>b :G branch<Space>
nnoremap <leader>gb<Space>o :G checkout --ours<Space>
nnoremap <leader>gb<Space>e :G checkout --theirs<Space>
nnoremap <leader>gb<Space>m :G checkout --merge<Space>

"}}}

"}}}

"}}}

"{{{ signify (s,j,k)

nnoremap <silent> <leader>gst :SignifyToggle<CR>
nnoremap <silent> <leader>gsh :SignifyToggleHighlight<CR>
nnoremap <silent> <leader>gs<Space>d :SignifyDisableAll<CR>
nnoremap <silent> <leader>gs<Space>e :SignifyEnableAll<CR>
nnoremap <silent> <leader>gsr :SignifyRefresh<CR>

nnoremap <silent> <leader>gsd :SignifyHunkDiff<CR>
nnoremap <silent> <leader>gsu :SignifyHunkUndo<CR>
nnoremap <leader>gj <plug>(signify-next-hunk)
nnoremap <leader>gk <plug>(signify-prev-hunk)
nnoremap <leader>gJ 9999<leader>gj
nnoremap <leader>gK 9999<leader>gk

nnoremap <silent> <leader>gsl :SignifyList<CR>
nnoremap <silent> <leader>gsi :echo sy#repo#get_stats_decorated(Expand('%'))<CR>
nnoremap <silent> <leader>gsf :SignifyDiff<CR>
nnoremap <silent> <leader>gsF :SignifyDiff!<CR>

function! s:show_current_hunk() abort
  let h = sy#util#get_hunk_stats()
  if !empty(h)
    echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
  endif
endfunction

autocmd User SignifyHunk call s:show_current_hunk()

"}}}

"{{{ gv (v,?)

nnoremap <silent> <leader>gv :GV<CR>
nnoremap <silent> <leader>gV :GV!<CR>
nnoremap <silent> <leader>g? :GV?<CR>
nnoremap <silent> <leader>g<Space>v :GV<Space>
nnoremap <silent> <leader>g<Space>V :GV!<Space>
nnoremap <silent> <leader>g<Space>? :GV?<Space>

" maps
" - `o` or `<cr>` on a commit to display the content of it
" - `o` or `<cr>` on commits to display the diff in the range
" - `O` opens a new tab instead
" - `gb` for `:GBrowse`
" - `]]` and `[[` to move between commits
" - `.` to start command-line with `:Git [CURSOR] SHA` à la fugitive
" - `q` or `gq` to close

"}}}
