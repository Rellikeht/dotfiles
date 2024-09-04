" {{{ settings and helpers

autocmd FileType gitcommit,gitsendmail
      \ setlocal textwidth=72

map ,g <Nop>
map ,gs <Nop>

" }}}

" {{{ fugitive

let g:ftype_hooks['fugitive'] = g:ftype_hooks['git']

" {{{ TODO
" gmove
" sourceforge
" }}}

" {{{ G* (g)

nnoremap <silent> <leader>G :Git<CR>
nnoremap <silent> <leader>ggc :Git<CR>
nnoremap <silent> <leader>ggC :Git<CR><C-w>T
nnoremap <silent> <C-w><leader>ggc :tab Git<CR>
nnoremap <silent> <C-w><leader>G :tab Git<CR>

nnoremap <leader>ggr :Gread<CR>
nnoremap <leader>gg<Space>r :Gread<Space>
nnoremap <leader>ggw :Gwrite<CR>
nnoremap <leader>gg<Space>w :Gwrite<Space>
nnoremap <silent> <leader>ggq :Gwq<CR>
nnoremap <leader>gg<Space>q :Gwq<Space>
nnoremap <silent> <leader>gg! :Gwq!<CR>
nnoremap <leader>gg<Space>Q :Gwq!<Space>

nnoremap <silent> <leader>ggb :GBrowse<CR>
nnoremap <leader>gg<Space>b :GBrowse<Space>
nnoremap <leader>gg<Space>e :Gedit<Space>
nnoremap <leader>gg<Space>p :Gpedit<Space>
nnoremap <leader>gg<Space>t :Gtabedit<Space>

nnoremap <silent> <leader>ggs :Gvdiffsplit<CR>
nnoremap <silent> <leader>ggS :Gvdiffsplit!<CR>
nnoremap <silent> <leader>ggh :Gdiffsplit<CR>
nnoremap <silent> <leader>ggH :Gdiffsplit!<CR>

nnoremap <leader>gg<Space>s :Gvdiffsplit<Space>
nnoremap <leader>gg<Space>S :Gvdiffsplit!<Space>
nnoremap <leader>gg<Space>h :Gdiffsplit<Space>
nnoremap <leader>gg<Space>H :Gdiffsplit!<Space>

nnoremap <silent> <C-w><leader>ggs :tab Gvdiffsplit<CR>
nnoremap <silent> <C-w><leader>ggS :tab Gvdiffsplit!<CR>
nnoremap <silent> <C-w><leader>ggh :tab Gdiffsplit<CR>
nnoremap <silent> <C-w><leader>ggS :tab Gdiffsplit!<CR>

nnoremap <silent> <expr> <leader>ggl g:qfloc ?
      \ ':<C-u>Gllog<CR>' : ':<C-u>Gclog<CR>'
nnoremap <expr> <leader>gg<Space>l g:qfloc ?
      \ ':<C-u>Gllog<Space>' : ':<C-u>Gclog<Space>'

" }}}

" {{{ info (i)

nnoremap <silent> <leader>gis :G status<CR>
nnoremap <silent> <leader>gil :G log<CR>
nnoremap <silent> <leader>gig :G log --graph<CR>
nnoremap <silent> <leader>gib :G blame<CR>
nnoremap <silent> <leader>gir :G reflog<CR>
nnoremap <silent> <leader>gio :G remote<CR>
nnoremap <silent> <leader>gi- :G remote show<CR>
nnoremap <silent> <leader>gii :G show<CR>

nnoremap <leader>gi<space>s :G status<Space>
nnoremap <leader>gi<space>l :G log<Space>
nnoremap <leader>gi<space>g :G log --graph<Space>
nnoremap <leader>gi<space>b :G blame<Space>
nnoremap <leader>gi<space>r :G reflog<Space>
nnoremap <leader>gi<space>o :G remote<Space>
nnoremap <leader>gi<space>- :G remote show<Space>
nnoremap <leader>gi<space>i :G show<Space>

nnoremap <C-w><leader>gis :tab G status<CR>
nnoremap <silent> <C-w><leader>gil :tab G log<CR>
nnoremap <silent> <C-w><leader>gig :tab G log --graph<CR>
nnoremap <silent> <C-w><leader>gib :tab G blame<CR>
nnoremap <silent> <C-w><leader>gir :tab G reflog<CR>
nnoremap <C-w><leader>gio :tab G remote<CR>
nnoremap <C-w><leader>gi- :tab G remote show<CR>
nnoremap <C-w><leader>gii :tab G show<CR>

nnoremap <C-w><leader>gi<Space>s :tab G status<Space>
nnoremap <C-w><leader>gi<Space>l :tab G log<Space>
nnoremap <C-w><leader>gi<Space>g :tab G log --graph<Space>
nnoremap <C-w><leader>gi<Space>b :tab G blame<Space>
nnoremap <C-w><leader>gi<Space>r :tab G reflog<Space>
nnoremap <C-w><leader>gi<Space>o :tab G remote<Space>
nnoremap <C-w><leader>gi<Space>- :tab G remote show<Space>
nnoremap <C-w><leader>gi<Space>i :tab G show<Space>

" }}}

" {{{ files (f)

noremap <leader>gf<Space>l :G ls-files<Space>
noremap <leader>gfc :G ls-files<CR>
noremap <leader>gfm :G ls-files --modified<CR>
noremap <leader>gfd :G ls-files --deleted<CR>
noremap <leader>gfo :G ls-files --others<CR>
noremap <leader>gfi :G ls-files --ignored<CR>
noremap <leader>gfu :G ls-files --unmerged<CR>

noremap <leader>gfC :<C-u>exe 'G ls-files "'.Expand('%:p:h').'"'<CR>
noremap <leader>gfM :<C-u>exe 'G ls-files --modified "'.Expand('%:p:h').'"'<CR>
noremap <leader>gfD :<C-u>exe 'G ls-files --deleted "'.Expand('%:p:h').'"'<CR>
noremap <leader>gfO :<C-u>exe 'G ls-files --others "'.Expand('%:p:h').'"'<CR>
noremap <leader>gfI :<C-u>exe 'G ls-files --ignored "'.Expand('%:p:h').'"'<CR>
noremap <leader>gfU :<C-u>exe 'G ls-files --unmerged "'.Expand('%:p:h').'"'<CR>

noremap <leader>gf;c :<C-u>exe 'G ls-files '.GitRoot()<CR>
noremap <leader>gf;m :<C-u>exe 'G ls-files --modified '.GitRoot()<CR>
noremap <leader>gf;d :<C-u>exe 'G ls-files --deleted '.GitRoot()<CR>
noremap <leader>gf;o :<C-u>exe 'G ls-files --others '.GitRoot()<CR>
noremap <leader>gf;i :<C-u>exe 'G ls-files --ignored '.GitRoot()<CR>
noremap <leader>gf;u :<C-u>exe 'G ls-files --unmerged '.GitRoot()<CR>

noremap <leader>gft :G ls-tree<Space>
noremap <leader>gfr :G ls-tree -r<Space>
noremap <leader>gfn :G ls-tree --name-only<Space>
noremap <leader>gfl :G ls-tree -r --name-only<Space>

noremap <leader>gfT :G ls-tree HEAD<CR>
noremap <leader>gfR :G ls-tree -r HEAD<CR>
noremap <leader>gfN :G ls-tree --name-only HEAD<CR>
noremap <leader>gfL :G ls-tree -r --name-only HEAD<CR>

" }}}

" {{{ diff and merge tools (i)

nnoremap <silent> <leader>gih :G diff HEAD<CR>
nnoremap <C-w><leader>gi<Space>h :tab G diff HEAD
nnoremap <silent> <leader>gih :G diff HEAD<CR>
nnoremap <C-w><leader>gi<Space>h :tab G diff HEAD

nnoremap <silent> <leader>gid :G diff<CR>
nnoremap <silent> <leader>giD :G diff --staged<CR>
nnoremap <silent> <leader>gi;d :G diff --cached<CR>
nnoremap <leader>gi<Space>d :G diff<Space>
nnoremap <silent> <leader>gim :G mergetool<CR>
nnoremap <leader>gim :G mergetool<Space>
nnoremap <silent> <leader>giD :G difftool<CR>
nnoremap <leader>giD :G difftool<Space>

nnoremap <silent> <C-w><leader>gid :tab G diff<CR>
nnoremap <silent> <C-w><leader>giw :tab G diff --word-diff<CR>
nnoremap <silent> <C-w><leader>gim :tab G mergetool<CR>
nnoremap <silent> <C-w><leader>giD :tab G difftool<CR>
nnoremap <C-w><leader>gi<Space>d :tab G diff<Space>
nnoremap <C-w><leader>gi<Space>w :tab G diff --word-diff<Space>
nnoremap <C-w><leader>gim :tab G mergetool<Space>
nnoremap <C-w><leader>giD :tab G difftool<Space>
" TODO D qfloc versions of diff and mergetools
" (make loclist out of quickfix list)

nnoremap <expr> <leader>gif g:qfloc ?
      \ ':<C-u>Glgrep<Space>' : ':<C-u>Ggrep<Space>'
nnoremap <expr> <leader>giF g:qfloc ?
      \ ':<C-u>Glgrep!<Space>' : ':<C-u>Ggrep!<Space>'

" }}}

" {{{ paths (p)

nnoremap <Leader>gpc :<C-u>Glcd<Space>
nnoremap <Leader>gpC :<C-u>Gcd<Space>

" }}}

" {{{ stash (t)

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

" }}}

" {{{ TODO B (too little probably) basic commands (o)

nnoremap <silent> <leader>goa :G add %<CR>
nnoremap <leader>go<Space>a :G add<Space>
nnoremap <leader>goA :G add .<CR>
nnoremap <leader>go;a :G add ##<CR>

nnoremap <leader>gor :G rm<Space>
nnoremap <leader>god :G rm --cached %<CR>
nnoremap <leader>goD :G rm --cached -r .<CR>
nnoremap <leader>go;d :G rm --cached -r ##<CR>
nnoremap <leader>go<Space>d :G rm --cached<Space>
nnoremap <leader>go<Space>D :G rm --cached -r<Space>

nnoremap <leader>gom :G submodule<Space>
nnoremap <leader>gof :G fetch<Space>
nnoremap <silent> <leader>goc :G gc<CR>
nnoremap <silent> <leader>goC :G gc --aggressive<CR>

" }}}

" {{{ TODO C (is enough) merge and rebase (m)

nnoremap <leader>gmr :G rebase<Space>
nnoremap <leader>gmR :G rebase<CR>
nnoremap <leader>gmi :G rebase --interactive<Space>
nnoremap <leader>gmI :G rebase --interactive<CR>
nnoremap <leader>gmm :G merge<Space>
nnoremap <leader>gmM :G merge<CR>
nnoremap <leader>gms :G merge --squash<Space>
nnoremap <leader>gmS :G merge --squash<CR>

nnoremap <leader>gmA :G rebase --abort<CR>
nnoremap <leader>gmC :G rebase --continue<CR>
nnoremap <leader>gmQ :G rebase --quit<CR>
nnoremap <leader>gmJ :G rebase --skip<CR>

nnoremap <leader>gma :G merge --abort<CR>
nnoremap <leader>gmc :G merge --continue<CR>
nnoremap <leader>gmq :G merge --quit<CR>

" }}}

" {{{ TODO C (is enough) reset, revert, restore (r)

nnoremap <leader>grf :G reset HEAD<CR>
nnoremap <leader>grF :G reset --hard HEAD<CR>
nnoremap <leader>gr<Space>f :G reset<Space>
nnoremap <leader>gr<Space>F :G reset --hard<Space>

nnoremap <leader>grr :G restore<Space>
nnoremap <leader>grR :G restore --staged<Space>

nnoremap <leader>grv :G revert<Space>
nnoremap <leader>gra :G revert --abort<CR>
nnoremap <leader>grc :G revert --continue<CR>
nnoremap <leader>grs :G revert --skip<CR>
nnoremap <leader>grq :G revert --quit<CR>

" }}}

" {{{ TODO C (is enough) commit (c)


nnoremap <leader>gcc :G commit<CR>
nnoremap <leader>gca :G commit --amend<CR>
nnoremap <leader>gcp :G commit --patch<CR>
nnoremap <leader>gcd :G commit --dry-run<CR>
nnoremap <leader>gcf :G commit --fixup<CR>
nnoremap <leader>gcr :G commit --fixup=reword<CR>

nnoremap <leader>gc<Space>c :G commit<Space>
nnoremap <leader>gc<Space>a :G commit --amend<Space>
nnoremap <leader>gc<Space>p :G commit --patch<Space>
nnoremap <leader>gc<Space>d :G commit --dry-run<Space>
nnoremap <leader>gc<Space>f :G commit --fixup<Space>
nnoremap <leader>gc<Space>r :G commit --fixup=reword<Space>

" }}}

" {{{ TODO C (is enough) push (h)

nnoremap <leader>ghc :G push<CR>
nnoremap <leader>ghf :G push --force<CR>
nnoremap <leader>gha :G push --all<CR>
nnoremap <leader>ghu :G push --set-upstream<CR>
nnoremap <leader>ght :G push --all --force<CR>

nnoremap <leader>gh<Space>c :G push<Space>
nnoremap <leader>gh<Space>f :G push --force<Space>
nnoremap <leader>gh<Space>a :G push --all<Space>
nnoremap <leader>gh<Space>u :G push --set-upstream<Space>
nnoremap <leader>gh<Space>t :G push --all --force<Space>

" }}}

" {{{ TODO C (is enough) pull (l)

nnoremap <leader>glc :G pull<CR>
nnoremap <leader>glf :G pull --force<CR>
nnoremap <leader>glr :G pull --rebase<CR>
nnoremap <leader>gli :G pull --rebase=interactive<CR>
nnoremap <leader>gla :G pull --all<CR>
nnoremap <leader>gld :G pull --dry-run<CR>
nnoremap <leader>glu :G pull --set-upstream<CR>

nnoremap <leader>gl<Space>c :G pull<Space>
nnoremap <leader>gl<Space>f :G pull --force<Space>
nnoremap <leader>gl<Space>r :G pull --rebase<Space>
nnoremap <leader>gl<Space>i :G pull --rebase=interactive<Space>
nnoremap <leader>gl<Space>a :G pull --all<Space>
nnoremap <leader>gl<Space>d :G pull --dry-run<Space>
nnoremap <leader>gl<Space>u :G pull --set-upstream<Space>

" }}}

" {{{ TODO B (is enough) branches (b)

nnoremap <leader>gbc :G checkout<CR>
nnoremap <leader>gb<Space>c :G checkout<Space>

nnoremap <leader>gbt :G tag  HEAD<left><left><left><left><left>
nnoremap <leader>gbb :G branch<CR>
nnoremap <leader>gbf :G checkout --force<CR>
nnoremap <leader>gbm :G checkout --merge<CR>

nnoremap <leader>gb<Space>t :G tag<Space>
nnoremap <leader>gb<Space>b :G branch<Space>
nnoremap <leader>gb<Space>f :G checkout --force<Space>
nnoremap <leader>gb<Space>o :G checkout --ours<Space>
nnoremap <leader>gb<Space>e :G checkout --theirs<Space>
nnoremap <leader>gb<Space>m :G checkout --merge<Space>

" }}}

" }}}

" {{{ signify (s,j,k)

nnoremap <silent> <leader>gst :SignifyToggle<CR>
nnoremap <silent> <leader>gsh :SignifyToggleHighlight<CR>
nnoremap <silent> <leader>gs<Space>d :SignifyDisableAll<CR>
nnoremap <silent> <leader>gs<Space>e :SignifyEnableAll<CR>
nnoremap <silent> <leader>gsr :SignifyRefresh<CR>

nnoremap <silent> <leader>gsd :SignifyHunkDiff<CR>
nnoremap <silent> <leader>gsu :SignifyHunkUndo<CR>
nnoremap <leader>gJ 99999<plug>(signify-next-hunk)
nnoremap <leader>gK 99999<plug>(signify-prev-hunk)

nnoremap + <plug>(signify-next-hunk)
nnoremap - <plug>(signify-prev-hunk)

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

" }}}

" {{{ gv (v,?)

let g:ftype_hooks['GV'] =
      \ 'o: open split / O: open tab / gb: GBrowse / q: quit'

nnoremap <silent> <leader>gv :GV<CR>
nnoremap <silent> <leader>gV :GV!<CR>
nnoremap <silent> <leader>g? :GV?<CR>
nnoremap <leader>g<Space>v :GV<Space>
nnoremap <leader>g<Space>V :GV!<Space>
nnoremap <leader>g<Space>? :GV?<Space>

" maps
" - `o` or `<cr>` on a commit to display the content of it
" - `o` or `<cr>` on commits to display the diff in the range
" - `O` opens a new tab instead
" - `gb` for `:GBrowse`
" - `]]` and `[[` to move between commits
" - `.` to start command-line with `:Git [CURSOR] SHA` à la fugitive
" - `q` or `gq` to close

" }}}
