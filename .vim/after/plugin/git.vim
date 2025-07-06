" settings and helpers {{{ 

autocmd FileType gitcommit,gitsendmail
      \ setlocal textwidth=72

let g:ftype_hooks['GV'] =
      \ 'o: open split / O: open tab / gb: GBrowse / q: quit'

let g:ftype_hooks['fugitive'] = g:ftype_hooks['git']

nnoremap <silent> <leader>G :Git<CR>

" }}} 

" signify {{{

nnoremap + <plug>(signify-next-hunk)
nnoremap - <plug>(signify-prev-hunk)

function! s:show_current_hunk() abort
  let h = sy#util#get_hunk_stats()
  if !empty(h)
    echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
  endif
endfunction

autocmd User SignifyHunk call s:show_current_hunk()

" }}}

function s:SetupGit() " {{{

" signify (s,j,k) {{{ 

nnoremap <silent> <leader>gst :SignifyToggle<CR>
nnoremap <silent> <leader>gsh :SignifyToggleHighlight<CR>
nnoremap <silent> <leader>gsD :SignifyDisableAll<CR>
nnoremap <silent> <leader>gsE :SignifyEnableAll<CR>
nnoremap <silent> <leader>gsr :SignifyRefresh<CR>

nnoremap <silent> <leader>gsd :SignifyHunkDiff<CR>
nnoremap <silent> <leader>gsu :SignifyHunkUndo<CR>
nnoremap <leader>gJ 99999<plug>(signify-next-hunk)
nnoremap <leader>gK 99999<plug>(signify-prev-hunk)

nnoremap <silent> <leader>gsl :SignifyList<CR>
nnoremap <silent> <leader>gsi :echo sy#repo#get_stats_decorated(Expand('%'))<CR>
nnoremap <silent> <leader>gss :SignifyDiff<CR>
nnoremap <silent> <leader>gsS :SignifyDiff!<CR>

" }}} 

" gv (v,?) {{{ 

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

" fugitive {{{

" TODO {{{ 
" gmove
" sourceforge
" }}} 

" G* (g) {{{ 

nnoremap <silent> <C-w><leader>gC :Git<CR><C-w>T
nnoremap <silent> <C-w><leader>G :tab Git<CR>

nnoremap <leader>ggr :Gread<CR>
nnoremap <leader>ggR :Gread<Space>
nnoremap <leader>ggw :Gwrite<Space>
nnoremap <leader>ggW :Gwrite<CR>
nnoremap <leader>ggq :Gwq<Space>
nnoremap <silent> <leader>ggQ :Gwq<CR>
nnoremap <leader>ggz :Gwq!<Space>
nnoremap <silent> <leader>ggZ :Gwq!<CR>

nnoremap <leader>ggb :GBrowse<Space>
nnoremap <silent> <leader>ggB :GBrowse<CR>
nnoremap <leader>gge :Gedit<Space>
nnoremap <leader>ggp :Gpedit<Space>
nnoremap <leader>ggt :Gtabedit<Space>

nnoremap <silent> <leader>ggS :Gvdiffsplit<CR>
nnoremap <silent> <leader>gGS :Gvdiffsplit!<CR>
nnoremap <silent> <leader>ggH :Gdiffsplit<CR>
nnoremap <silent> <leader>gGH :Gdiffsplit!<CR>

nnoremap <leader>ggs :Gvdiffsplit<Space>
nnoremap <leader>gGS :Gvdiffsplit!<Space>
nnoremap <leader>ggh :Gdiffsplit<Space>
nnoremap <leader>gGH :Gdiffsplit!<Space>

nnoremap <silent> <C-w><leader>ggS :tab Gvdiffsplit<CR>
nnoremap <silent> <C-w><leader>gGS :tab Gvdiffsplit!<CR>
nnoremap <silent> <C-w><leader>ggH :tab Gdiffsplit<CR>
nnoremap <silent> <C-w><leader>gGS :tab Gdiffsplit!<CR>

nnoremap <expr> <leader>ggl g:qfloc ?
      \ ':<C-u>Gllog<Space>' : ':<C-u>Gclog<Space>'
nnoremap <silent> <expr> <leader>ggL g:qfloc ?
      \ ':<C-u>Gllog<CR>' : ':<C-u>Gclog<CR>'

" }}} 

" info (i) {{{ 

nnoremap <leader>gis :G status<Space>
nnoremap <leader>gil :G log<Space>
nnoremap <leader>gig :G log --graph<Space>
nnoremap <leader>gib :G blame<Space>
nnoremap <leader>gir :G reflog<Space>
nnoremap <leader>gio :G remote<Space>
nnoremap <leader>gii :G show<Space>
nnoremap <leader>gi- :G remote show<Space>
nnoremap <leader>gif :G log --all --graph --oneline --decorate<Space>

nnoremap <silent> <leader>giS :G status<CR>
nnoremap <silent> <leader>giL :G log<CR>
nnoremap <silent> <leader>giG :G log --graph<CR>
nnoremap <silent> <leader>giB :G blame<CR>
nnoremap <silent> <leader>giR :G reflog<CR>
nnoremap <silent> <leader>giO :G remote<CR>
nnoremap <silent> <leader>giI :G show<CR>
nnoremap <silent> <leader>gi_ :G remote show<CR>
nnoremap <leader>giF :G log --all --graph --oneline --decorate<CR>

nnoremap <C-w><leader>gis :tab G status<Space>
nnoremap <C-w><leader>gil :tab G log<Space>
nnoremap <C-w><leader>gig :tab G log --graph<Space>
nnoremap <C-w><leader>gib :tab G blame<Space>
nnoremap <C-w><leader>gir :tab G reflog<Space>
nnoremap <C-w><leader>gio :tab G remote<Space>
nnoremap <C-w><leader>gii :tab G show<Space>
nnoremap <C-w><leader>gi- :tab G remote show<Space>
nnoremap <leader>gif :G log --all --graph --oneline --decorate<Space>

nnoremap <C-w><leader>giS :tab G status<CR>
nnoremap <silent> <C-w><leader>giL :tab G log<CR>
nnoremap <silent> <C-w><leader>giG :tab G log --graph<CR>
nnoremap <silent> <C-w><leader>giB :tab G blame<CR>
nnoremap <silent> <C-w><leader>giR :tab G reflog<CR>
nnoremap <C-w><leader>giO :tab G remote<CR>
nnoremap <C-w><leader>giI :tab G show<CR>
nnoremap <C-w><leader>gi_ :tab G remote show<CR>
nnoremap <C-w><leader>giF :G log --all --graph --oneline --decorate<CR>

" }}} 

" files (f) {{{ 

noremap <leader>gfc :G ls-files<Space>
noremap <leader>gfC :G ls-files<CR>
noremap <leader>gfM :G ls-files --modified<CR>
noremap <leader>gfD :G ls-files --deleted<CR>
noremap <leader>gfO :G ls-files --others<CR>
noremap <leader>gfI :G ls-files --ignored<CR>
noremap <leader>gfU :G ls-files --unmerged<CR>

noremap <leader>gfdC :<C-u>exe 'G ls-files "'.Expand('%:p:h').'"'<CR>
noremap <leader>gfdM :<C-u>exe 'G ls-files --modified "'.Expand('%:p:h').'"'<CR>
noremap <leader>gfdD :<C-u>exe 'G ls-files --deleted "'.Expand('%:p:h').'"'<CR>
noremap <leader>gfdO :<C-u>exe 'G ls-files --others "'.Expand('%:p:h').'"'<CR>
noremap <leader>gfdI :<C-u>exe 'G ls-files --ignored "'.Expand('%:p:h').'"'<CR>
noremap <leader>gfdU :<C-u>exe 'G ls-files --unmerged "'.Expand('%:p:h').'"'<CR>

noremap <leader>gfgc :<C-u>exe 'G ls-files '.GitRoot()<CR>
noremap <leader>gfgm :<C-u>exe 'G ls-files --modified '.GitRoot()<CR>
noremap <leader>gfgd :<C-u>exe 'G ls-files --deleted '.GitRoot()<CR>
noremap <leader>gfgo :<C-u>exe 'G ls-files --others '.GitRoot()<CR>
noremap <leader>gfgi :<C-u>exe 'G ls-files --ignored '.GitRoot()<CR>
noremap <leader>gfgu :<C-u>exe 'G ls-files --unmerged '.GitRoot()<CR>

noremap <leader>gft :G ls-tree<Space>
noremap <leader>gfr :G ls-tree -r<Space>
noremap <leader>gfn :G ls-tree --name-only<Space>
noremap <leader>gfl :G ls-tree -r --name-only<Space>

noremap <leader>gfT :G ls-tree HEAD<CR>
noremap <leader>gfR :G ls-tree -r HEAD<CR>
noremap <leader>gfN :G ls-tree --name-only HEAD<CR>
noremap <leader>gfL :G ls-tree -r --name-only HEAD<CR>

" }}} 

" diff and merge tools (i) {{{ 

nnoremap <silent> <leader>gih :G diff HEAD<Space>
nnoremap <silent> <leader>giH :G diff HEAD<CR>
nnoremap <C-w><leader>gih :tab G diff HEAD
nnoremap <C-w><leader>giH :tab G diff HEAD<CR>

nnoremap <leader>gid :G diff<Space>
nnoremap <leader>gia :G diff --staged<Space>
nnoremap <leader>gim :G mergetool<Space>
nnoremap <leader>git :G difftool<Space>
nnoremap <silent> <leader>giD :G diff<CR>
nnoremap <silent> <leader>giA :G diff --staged<CR>
nnoremap <silent> <leader>giM :G mergetool<CR>
nnoremap <silent> <leader>giT :G difftool<CR>

nnoremap <C-w><leader>gid :tab G diff<Space>
nnoremap <C-w><leader>gim :tab G mergetool<Space>
nnoremap <C-w><leader>git :tab G difftool<Space>
nnoremap <silent> <C-w><leader>giD :tab G diff<CR>
nnoremap <silent> <C-w><leader>giM :tab G mergetool<CR>
nnoremap <silent> <C-w><leader>giT :tab G difftool<CR>
" TODO D qfloc versions of diff and mergetools
" (make loclist out of quickfix list)

nnoremap <expr> <leader>gif g:qfloc ?
      \ ':<C-u>Glgrep<Space>' : ':<C-u>Ggrep<Space>'
nnoremap <expr> <leader>gIf g:qfloc ?
      \ ':<C-u>Glgrep!<Space>' : ':<C-u>Ggrep!<Space>'

" }}} 

" stash (t) {{{ 

nnoremap <leader>gts :G stash push<Space>
nnoremap <leader>gtm :G stash push -m<Space>
nnoremap <leader>gtp :G stash pop<Space>
nnoremap <leader>gta :G stash apply<Space>
nnoremap <leader>gtd :G stash drop<Space>
nnoremap <leader>gtb :G stash branch<Space>

nnoremap <leader>gtS :G stash push<CR>
nnoremap <leader>gtP :G stash pop<CR>
nnoremap <leader>gtA :G stash apply<CR>
nnoremap <leader>gtD :G stash drop<CR>
nnoremap <leader>gtB :G stash branch<CR>
nnoremap <leader>gt! :G stash clear<CR>

nnoremap <leader>gtl :G stash list<Space>
nnoremap <leader>gtv :G stash show<Space>
nnoremap <leader>gtL :G stash list<CR>
nnoremap <leader>gtV :G stash show<CR>

nnoremap <C-w><leader>gtl :tab G stash list<Space>
nnoremap <C-w><leader>gtv :tab G stash show<Space>
nnoremap <C-w><leader>gtL :tab G stash list<CR>
nnoremap <C-w><leader>gtV :tab G stash show<CR>

" }}} 

" TODO C (is enough) merge and rebase (m) {{{ 

nnoremap <leader>gwc :G rebase<Space>
nnoremap <leader>gwi :G rebase --interactive<Space>
nnoremap <leader>gwC :G rebase<CR>
nnoremap <leader>gwI :G rebase --interactive<CR>

nnoremap <leader>gmc :G merge<Space>
nnoremap <leader>gms :G merge --squash<Space>
nnoremap <leader>gmC :G merge<CR>
nnoremap <leader>gmS :G merge --squash<CR>

nnoremap <leader>gwa :G rebase --abort<Space>
nnoremap <leader>gwn :G rebase --continue<Space>
nnoremap <leader>gwq :G rebase --quit<Space>
nnoremap <leader>gws :G rebase --skip<Space>
nnoremap <leader>gwA :G rebase --abort<CR>
nnoremap <leader>gwN :G rebase --continue<CR>
nnoremap <leader>gwQ :G rebase --quit<CR>
nnoremap <leader>gwS :G rebase --skip<CR>

nnoremap <leader>gma :G merge --abort<Space>
nnoremap <leader>gmn :G merge --continue<Space>
nnoremap <leader>gmq :G merge --quit<Space>
nnoremap <leader>gmA :G merge --abort<CR>
nnoremap <leader>gmN :G merge --continue<CR>
nnoremap <leader>gmQ :G merge --quit<CR>

" }}} 

" TODO C (is enough) reset, revert, restore (r) {{{ 

nnoremap <leader>grf :G reset<Space>
nnoremap <leader>grh :G reset --hard<Space>
nnoremap <leader>grF :G reset HEAD<CR>
nnoremap <leader>grH :G reset --hard HEAD<CR>

nnoremap <leader>grr :G restore<Space>
nnoremap <leader>gru :G restore --staged<Space>

nnoremap <leader>grv :G revert<Space>
nnoremap <leader>grA :G revert --abort<CR>
nnoremap <leader>grC :G revert --continue<CR>
nnoremap <leader>grS :G revert --skip<CR>
nnoremap <leader>grQ :G revert --quit<CR>

" }}} 

" TODO C (is enough) commit (c) {{{ 

nnoremap <leader>gcc :G commit<Space>
nnoremap <leader>gca :G commit --amend<Space>
nnoremap <leader>gcn :G commit --amend --no-edit<Space>
nnoremap <leader>gcp :G commit --patch<Space>
nnoremap <leader>gcd :G commit --dry-run<Space>
nnoremap <leader>gcf :G commit --fixup<Space>
nnoremap <leader>gcr :G commit --fixup=reword<Space>

nnoremap <leader>gcC :G commit<CR>
nnoremap <leader>gcA :G commit --amend<CR>
nnoremap <leader>gcN :G commit --amend --no-edit<CR>
nnoremap <leader>gcP :G commit --patch<CR>
nnoremap <leader>gcD :G commit --dry-run<CR>
nnoremap <leader>gcF :G commit --fixup<CR>
nnoremap <leader>gcR :G commit --fixup=reword<CR>

" }}} 

" TODO C (is enough) push (h) {{{ 

nnoremap <leader>ghc :G push<Space>
nnoremap <leader>ghf :G push --force<Space>
nnoremap <leader>gha :G push --all<Space>
nnoremap <leader>ghu :G push --set-upstream<Space>
nnoremap <leader>ght :G push --all --force<Space>

nnoremap <leader>ghC :G push<CR>
nnoremap <leader>ghF :G push --force<CR>
nnoremap <leader>ghA :G push --all<CR>
nnoremap <leader>ghU :G push --set-upstream<CR>
nnoremap <leader>ghT :G push --all --force<CR>

" }}} 

" TODO C (is enough) pull (l) {{{ 

nnoremap <leader>glc :G pull<Space>
nnoremap <leader>glf :G pull --force<Space>
nnoremap <leader>glr :G pull --rebase<Space>
nnoremap <leader>gli :G pull --rebase=interactive<Space>
nnoremap <leader>gla :G pull --all<Space>
nnoremap <leader>gld :G pull --dry-run<Space>
nnoremap <leader>glu :G pull --set-upstream<Space>

nnoremap <leader>glC :G pull<CR>
nnoremap <leader>glC :G pull --force<CR>
nnoremap <leader>glC :G pull --rebase<CR>
nnoremap <leader>glC :G pull --rebase=interactive<CR>
nnoremap <leader>glC :G pull --all<CR>
nnoremap <leader>glC :G pull --dry-run<CR>
nnoremap <leader>glC :G pull --set-upstream<CR>

" }}} 

" TODO B (is enough) branches (b) {{{ 

nnoremap <leader>gbc :G checkout<Space>
nnoremap <leader>gbC :G checkout<CR>

nnoremap <leader>gbh :G tag  HEAD<left><left><left><left><left>
nnoremap <leader>gbA :G branch -a<CR>
nnoremap <leader>gbB :G branch<CR>
nnoremap <leader>gbF :G checkout --force<CR>
nnoremap <leader>gbM :G checkout --merge<CR>

nnoremap <leader>gbt :G tag<Space>
nnoremap <leader>gbb :G branch<Space>
nnoremap <leader>gbf :G checkout --force<Space>
nnoremap <leader>gbo :G checkout --ours<Space>
nnoremap <leader>gbe :G checkout --theirs<Space>
nnoremap <leader>gbm :G checkout --merge<Space>

" }}} 

" TODO B (too little probably) other commands (o, a, r) {{{ 

nnoremap <leader>gac :G add<Space>
nnoremap <leader>gaD :G add .<CR>
nnoremap <silent> <leader>gaF :G add %<CR>
nnoremap <leader>gaL :G add ##<CR>

nnoremap <leader>grc :G rm<Space>
nnoremap <leader>grc :G rm --cached<Space>
nnoremap <leader>grr :G rm --cached -r<Space>
nnoremap <leader>grF :G rm --cached %<CR>
nnoremap <leader>grD :G rm --cached -r .<CR>
nnoremap <leader>grL :G rm --cached -r ##<CR>

nnoremap <leader>gom :G submodule<Space>
nnoremap <leader>gof :G fetch<Space>
nnoremap <silent> <leader>gog :G gc<CR>
nnoremap <silent> <leader>goG :G gc --aggressive<CR>
nnoremap <Leader>gol :<C-u>Glcd<Space>
nnoremap <Leader>gcc :<C-u>Gcd<Space>

" }}} 

" }}}

endfunction
call lazy_utils#LoadOnKeys("<Leader>g", expand("<SID>").."SetupGit")

" }}}
