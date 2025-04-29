" helpers {{{ 

function! s:with_dir(dir='')
  if len(a:dir) == 0
    return {}
  endif
  if type(a:dir) == v:t_list
    let l:dir = a:dir[0]
  else
    let l:dir = a:dir
  endif
  return {'dir': l:dir}
endfunction

function! s:W0(...)
  return join(a:000[1:], '')
endfunction

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines, action = 'r')
  let lns = map(deepcopy(a:lines),
        \ '{ "filename": v:val'.
        \ ', "lnum": 1'.
        \ ' }'
        \ )
  if g:qfloc
    call setloclist(0, lns)
  else
    call setqflist(lns)
  endif
  call QFcmd('open')
endfunction

func s:fnameescape(key, val)
  return fnameescape(a:val)
endfunc

function! s:populate_arg_list(lines)
  execute 'args ' . join(map(a:lines, function('s:fnameescape')), ' ')
endfunction

function! s:add_arg_list(lines)
  execute 'argadd ' . join(map(a:lines, function('s:fnameescape')), ' ')
endfunction

function! s:tab_args(lines)
  Tabe
  execute 'args ' . join(map(a:lines, function('s:fnameescape')), ' ')
endfunction

" }}} 

" settings {{{ 

" basic {{{ 

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_vim = {}

autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_vim.listproc = { list -> fzf#vim#listproc#location(list) }

let g:fzf_vim.tags_command = 'ctags -R'

" }}} 

" layout {{{ 

" let g:fzf_percent = '55%'
let g:fzf_percent = '100%'

let g:fzf_layout = { 'down': g:fzf_percent }
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" if exists('$TMUX')
"     " let g:fzf_layout = { 'tmux': '-p90%,60%' }
"     let g:fzf_layout = { 'tmux': '-d'.g:fzf_percent }
" else
"     " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
"     let g:fzf_layout = { 'down': g:fzf_percent }
" endif

" ~~Preview window is hidden by default.~~ You can toggle it with ctrl-/.
" It will show on the right with 50% width, but if the width is smaller
" than 70 columns, it will show above the candidate list
" let fzf_preview_default = 'right,64%,<70(up,40%)'
" let fzf_preview_default = 'right,64%'

" let fzf_preview_default = 'right,55%'
let fzf_preview_default = 'up,50%'
let g:fzf_vim.preview_window = [fzf_preview_default, 'ctrl-/']

" " - Window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }

" }}} 

" colors {{{ 

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
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
      \ 'header':  ['fg', 'Comment']
      \ }

" }}} 

" }}} 

" custom grep {{{ 

let s:ggrep_args = '--line-number --color=always -EI'
let s:grep = g:grep.' '.s:ggrep_args
" let s:ggrep_args = s:ggrep_args.' -EI'

" simple grep
command! -bang -nargs=* Fgrep
      \ call fzf#vim#grep(
      \ s:grep." -- ".fzf#shellescape(<q-args>),
      \ fzf#vim#with_preview(),
      \ <bang>0
      \ )

" grep on given directory
command! -bang -nargs=* -complete=dir Dgrep
      \ call fzf#vim#grep(
      \ s:grep." -- ".fzf#shellescape(s:W0(<f-args>)),
      \ extend(
      \ fzf#vim#with_preview(),
      \ s:with_dir([<f-args>]),
      \ ),
      \ <bang>0
      \ )

" case insensitive grep on given directory
command! -bang -nargs=* -complete=dir Digrep
      \ call fzf#vim#grep(
      \ s:grep." -i -- ".fzf#shellescape(s:W0(<f-args>)),
      \ extend(
      \ fzf#vim#with_preview(),
      \ s:with_dir([<f-args>]),
      \ ),
      \ <bang>0
      \ )

" }}} 

" custom ag {{{ 

let s:ahflags = '--ignore .git --ignore .hg --smart-case --hidden'
let s:auflags = '--ignore .git --ignore .hg --smart-case --unrestricted'

command! -bang -nargs=* Ah 
      \ call fzf#vim#ag(<q-args>,
      \ s:ahflags,
      \ fzf#vim#with_preview(),
      \ <bang>0)

command! -bang -nargs=* Au 
      \ call fzf#vim#ag(<q-args>,
      \ s:auflags,
      \ fzf#vim#with_preview(),
      \ <bang>0)

" Ag from given directory
command! -bang -nargs=* -complete=dir Dah
      \ call fzf#vim#ag(s:W0(<f-args>),
      \ s:ahflags,
      \ extend(
      \ s:with_dir([<f-args>]),
      \ extend(deepcopy(g:fzf_layout), fzf#vim#with_preview())
      \ ), <bang>0)

command! -bang -nargs=* -complete=dir Dau
      \ call fzf#vim#ag(s:W0(<f-args>),
      \ s:auflags,
      \ extend(
      \ s:with_dir([<f-args>]),
      \ extend(deepcopy(g:fzf_layout), fzf#vim#with_preview())
      \ ), <bang>0)

" }}} 

" custom rg {{{ 

let s:rgcmd = "rg --column --line-number --no-heading --hidden ".
      \ "--color=always --smart-case "
command! -bang -nargs=* -complete=dir Drg
      \ call fzf#vim#grep(
      \ s:rgcmd.' --glob="!.git" --glob="!.hg" -- '.
      \ fzf#shellescape(s:W0(<f-args>)),
      \ extend(
      \ s:with_dir(<f-args>),
      \ extend(deepcopy(g:fzf_layout), fzf#vim#with_preview())
      \ ), <bang>0)

command! -bang -nargs=* -complete=dir Dru
      \ call fzf#vim#grep(
      \ s:rgcmd.' --unrestricted -- '.fzf#shellescape(s:W0(<f-args>)),
      \ extend(
      \ s:with_dir(<f-args>),
      \ extend(deepcopy(g:fzf_layout), fzf#vim#with_preview())
      \ ), <bang>0)

" }}} 

" custom diff {{{ 

" TODO C preview like in other commands (probably impossible)
command! -bang -nargs=? -complete=dir Fdiffs
      \ call fzf#run(fzf#wrap({
      \ 'sink': 'diffs',
      \ 'dir': <q-args>,
      \ 'options': [
      \ '--preview',
      \ 'delta '.Expand("%:p").' {}',
      \ '--preview-window',
      \ fzf_preview_default,
      \ ],
      \ },
      \ <bang>0))

command! -bang -nargs=? -complete=dir Fdiffv
      \ call fzf#run(fzf#wrap({
      \ 'sink': 'vert diffs',
      \ 'dir': <q-args>,
      \ 'options': [
      \ '--preview',
      \ 'delta '.Expand("%:p").' {}',
      \ '--preview-window',
      \ fzf_preview_default,
      \ ],
      \ },
      \ <bang>0)
      \ )

" }}} 

" insert mode mappings {{{ 

" Insert mode completion
imap <c-X><C-w> <Plug>(fzf-complete-word)
imap <c-X>w <C-x><C-w>
imap <c-X>l <Plug>(fzf-complete-line)

imap <C-X><C-p> <Plug>(fzf-complete-path)
imap <C-X>p <C-x><C-p>

" }}} 

" builtin mappings {{{ 

nnoremap <leader>slf :<C-u>History<CR>
nnoremap <leader>sl/ :<C-u>History/<CR>
nnoremap <leader>sl: :<C-u>History:<CR>
nnoremap <leader>slp :<C-u>Marks<CR>
nnoremap <leader>slm :<C-u>Changes<CR>

" lists
nnoremap <leader>slo :<C-u>Buffers<CR>
nnoremap <leader>slk :<C-u>Maps<CR>
nnoremap <leader>slh :<C-u>Helptags<CR>
nnoremap <leader>slw :<C-u>Windows<CR>
nnoremap <leader>slj :<C-u>Jumps<CR>
nnoremap <leader>slt :<C-u>Tags<CR>
nnoremap <leader>slb :<C-u>BTags<CR>

" noremap <leader>slf :<C-u>Files<CR>
" noremap <leader>sl<Space>f :<C-u>Files<Space>

" other
noremap <leader>sls :<C-u>Locate<Space>
nnoremap <leader>slc :<C-u>Commands<CR>

" Not needed really
noremap <leader>slr :<C-u>FZF<CR>
noremap <leader>sl<Space>r :<C-u>FZF<Space>

" }}} 

" file mappings {{{ 

nnoremap <leader>sfb :<C-u>BLines<CR>
nnoremap <leader>sf<Space>b :<C-u>BLines<Space>
nnoremap <leader>sfl :<C-u>Lines<CR>
nnoremap <leader>sf<Space>l :<C-u>Lines<Space>

" }}} 

" git mappings {{{ 

" From official instructions
" git grep
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep '.s:ggrep_args.' -r -- '.fzf#shellescape(<q-args>),
      \   fzf#vim#with_preview(
      \      {'dir': GitRoot()}
      \   ), <bang>0)

nnoremap <leader>gs/ :<C-u>GFiles<CR>
nnoremap <leader>gs? :<C-u>GFiles?<CR>
nnoremap <leader>gsg :GGrep<CR>
nnoremap <leader>gs<Space>g :GGrep<Space>

" history and marks
nnoremap <leader>gsc :<C-u>Commits<CR>
nnoremap <leader>gsb :<C-u>BCommits<CR>

" }}} 

" custom command mappings {{{ 

" grep
nnoremap <leader>sfg :Fgrep<CR>
nnoremap <leader>sfg :Fgrep<Space>

" ag
nnoremap <leader>sfh :Ah<CR>
nnoremap <leader>sf<Space>h :Ah<Space>
nnoremap <leader>sfu :Au<CR>
nnoremap <leader>sf<Space>u :Au<Space>

" diff
nnoremap <leader>sfd :Fdiffs<CR>
nnoremap <leader>sf<Space>d :Fdiffs<Space>
nnoremap <leader>sfv :Fdiffv<CR>
nnoremap <leader>sf<Space>v :Fdiffv<Space>

" }}} 

" actions {{{ 

" let g:fzf_action = {
"       \ 'ctrl-q': function('s:build_quickfix_list'),
"       \ 'ctrl-o': function('s:tab_args'),
"       \ 'ctrl-t': 'Tabe',
"       \ 'ctrl-s': 'split',
"       \ 'ctrl-v': 'vsplit',
"       \ 'ctrl-r': 'view',
"       \ 'ctrl-w': 'TabV',
"       \ 'ctrl-l': function('s:populate_arg_list'),
"       \ 'ctrl-a': function('s:add_arg_list'),
"       \ }

let g:fzf_action = {
      \ 'alt-q': function('s:build_quickfix_list'),
      \ 'alt-t': 'Tabe',
      \ 'alt-T': 'TabV',
      \ 'alt-L': function('s:populate_arg_list'),
      \ 'alt-l': function('s:add_arg_list'),
      \ }
      " \ 'alt-o': function('s:tab_args'),
      " \ 'alt-r': 'view',
      " \ 'alt-s': 'split',
      " \ 'alt-v': 'vsplit',

" }}} 


" path maps {{{

" empty cmds
nnoremap <Leader>sp<Space> :<C-u>Files<Space>
nnoremap <Leader>sp<CR> :<C-u>Files<CR>
nnoremap <Leader>ss<Space> :<C-u>Dah<Space>
nnoremap <Leader>ss<CR> :<C-u>Dah<CR>
nnoremap <Leader>sS<Space> :<C-u>Dau<Space>
nnoremap <Leader>sS<CR> :<C-u>Dau<CR>
nnoremap <Leader>sd<Space> :<C-u>Dgrep<Space>
nnoremap <Leader>sd<CR> :<C-u>Dgrep<CR>
nnoremap <Leader>sD<Space> :<C-u>Digrep<Space>
nnoremap <Leader>sD<CR> :<C-u>Digrep<CR>
nnoremap <Leader>sr<Space> :<C-u>Drg<Space>
nnoremap <Leader>sr<CR> :<C-u>Drg<CR>
nnoremap <Leader>sR<Space> :<C-u>Dru<Space>
nnoremap <Leader>sR<CR> :<C-u>Dru<CR>

nnoremap <Leader>sph :<C-u>Files ~<CR>
nnoremap <Leader>ssh :<C-u>Dah ~<CR>
nnoremap <Leader>sSh :<C-u>Dau ~<CR>
nnoremap <Leader>sdh :<C-u>Dgrep ~<CR>
nnoremap <Leader>sDh :<C-u>Digrep ~<CR>
nnoremap <Leader>srh :<C-u>Drg ~<CR>
nnoremap <Leader>sRh :<C-u>Dru ~<CR>

nnoremap <Leader>spt :<C-u>Files ~/Templates<CR>
nnoremap <Leader>sst :<C-u>Dah ~/Templates<CR>
nnoremap <Leader>sSt :<C-u>Dau ~/Templates<CR>
nnoremap <Leader>sdt :<C-u>Dgrep ~/Templates<CR>
nnoremap <Leader>sDt :<C-u>Digrep ~/Templates<CR>
nnoremap <Leader>srt :<C-u>Drg ~/Templates<CR>
nnoremap <Leader>sRt :<C-u>Dru ~/Templates<CR>

nnoremap <Leader>spd :<C-u>Files ~/Dbackup<CR>
nnoremap <Leader>ssd :<C-u>Dah ~/Dbackup<CR>
nnoremap <Leader>sSd :<C-u>Dau ~/Dbackup<CR>
nnoremap <Leader>sdd :<C-u>Dgrep ~/Dbackup<CR>
nnoremap <Leader>sDd :<C-u>Digrep ~/Dbackup<CR>
nnoremap <Leader>srd :<C-u>Drg ~/Dbackup<CR>
nnoremap <Leader>sRd :<C-u>Dru ~/Dbackup<CR>

nnoremap <Leader>spD :<C-u>Files ~/Downloads<CR>
nnoremap <Leader>ssD :<C-u>Dah ~/Downloads<CR>
nnoremap <Leader>sSD :<C-u>Dau ~/Downloads<CR>
nnoremap <Leader>sdD :<C-u>Dgrep ~/Downloads<CR>
nnoremap <Leader>sDD :<C-u>Digrep ~/Downloads<CR>
nnoremap <Leader>srD :<C-u>Drg ~/Downloads<CR>
nnoremap <Leader>sRD :<C-u>Dru ~/Downloads<CR>

nnoremap <Leader>spf :<C-u>Files ~/Documents<CR>
nnoremap <Leader>ssf :<C-u>Dah ~/Documents<CR>
nnoremap <Leader>sSf :<C-u>Dau ~/Documents<CR>
nnoremap <Leader>sdf :<C-u>Dgrep ~/Documents<CR>
nnoremap <Leader>sDf :<C-u>Digrep ~/Documents<CR>
nnoremap <Leader>srf :<C-u>Drg ~/Documents<CR>
nnoremap <Leader>sRf :<C-u>Dru ~/Documents<CR>

nnoremap <Leader>spp :<C-u>Files ~/gits<CR>
nnoremap <Leader>ssp :<C-u>Dah ~/gits<CR>
nnoremap <Leader>sSp :<C-u>Dau ~/gits<CR>
nnoremap <Leader>sdp :<C-u>Dgrep ~/gits<CR>
nnoremap <Leader>sDp :<C-u>Digrep ~/gits<CR>
nnoremap <Leader>srp :<C-u>Drg ~/gits<CR>
nnoremap <Leader>sRp :<C-u>Dru ~/gits<CR>

nnoremap <Leader>spc :<C-u>Files ~/.config/<CR>
nnoremap <Leader>ssc :<C-u>Dah ~/.config/<CR>
nnoremap <Leader>sSc :<C-u>Dau ~/.config/<CR>
nnoremap <Leader>sdc :<C-u>Dgrep ~/.config/<CR>
nnoremap <Leader>sDc :<C-u>Digrep ~/.config/<CR>
nnoremap <Leader>src :<C-u>Drg ~/.config/<CR>
nnoremap <Leader>sRc :<C-u>Dru ~/.config/<CR>

nnoremap <Leader>sp. :<C-u>Files .<CR>
nnoremap <Leader>ss. :<C-u>Dah .<CR>
nnoremap <Leader>sS. :<C-u>Dau .<CR>
nnoremap <Leader>sd. :<C-u>Dgrep .<CR>
nnoremap <Leader>sD. :<C-u>Digrep .<CR>
nnoremap <Leader>sr. :<C-u>Drg .<CR>
nnoremap <Leader>sR. :<C-u>Dru .<CR>

nnoremap <Leader>sp1 :<C-u>Files ..<CR>
nnoremap <Leader>ss1 :<C-u>Dah ..<CR>
nnoremap <Leader>sS1 :<C-u>Dau ..<CR>
nnoremap <Leader>sd1 :<C-u>Dgrep ..<CR>
nnoremap <Leader>sD1 :<C-u>Digrep ..<CR>
nnoremap <Leader>sr1 :<C-u>Drg ..<CR>
nnoremap <Leader>sR1 :<C-u>Dru ..<CR>

nnoremap <Leader>sp2 :<C-u>Files ../..<CR>
nnoremap <Leader>ss2 :<C-u>Dah ../..<CR>
nnoremap <Leader>sS2 :<C-u>Dau ../..<CR>
nnoremap <Leader>sd2 :<C-u>Dgrep ../..<CR>
nnoremap <Leader>sD2 :<C-u>Digrep ../..<CR>
nnoremap <Leader>sr2 :<C-u>Drg ../..<CR>
nnoremap <Leader>sR2 :<C-u>Dru ../..<CR>

nnoremap <Leader>sp3 :<C-u>Files ../../..<CR>
nnoremap <Leader>ss3 :<C-u>Dah ../../..<CR>
nnoremap <Leader>sS3 :<C-u>Dau ../../..<CR>
nnoremap <Leader>sd3 :<C-u>Dgrep ../../..<CR>
nnoremap <Leader>sD3 :<C-u>Digrep ../../..<CR>
nnoremap <Leader>sr3 :<C-u>Drg ../../..<CR>
nnoremap <Leader>sR3 :<C-u>Dru ../../..<CR>

nnoremap <Leader>sp4 :<C-u>Files ../../../..<CR>
nnoremap <Leader>ss4 :<C-u>Dah ../../../..<CR>
nnoremap <Leader>sS4 :<C-u>Dau ../../../..<CR>
nnoremap <Leader>sd4 :<C-u>Dgrep ../../../..<CR>
nnoremap <Leader>sD4 :<C-u>Digrep ../../../..<CR>
nnoremap <Leader>sr4 :<C-u>Drg ../../../..<CR>
nnoremap <Leader>sR4 :<C-u>Dru ../../../..<CR>

nnoremap <Leader>sp5 :<C-u>Files ../../../../..<CR>
nnoremap <Leader>ss5 :<C-u>Dah ../../../../..<CR>
nnoremap <Leader>sS5 :<C-u>Dau ../../../../..<CR>
nnoremap <Leader>sd5 :<C-u>Dgrep ../../../../..<CR>
nnoremap <Leader>sD5 :<C-u>Digrep ../../../../..<CR>
nnoremap <Leader>sr5 :<C-u>Drg ../../../../..<CR>
nnoremap <Leader>sR5 :<C-u>Dru ../../../../..<CR>

nnoremap <Leader>sp6 :<C-u>Files ../../../../../..<CR>
nnoremap <Leader>ss6 :<C-u>Dah ../../../../../..<CR>
nnoremap <Leader>sS6 :<C-u>Dau ../../../../../..<CR>
nnoremap <Leader>sd6 :<C-u>Dgrep ../../../../../..<CR>
nnoremap <Leader>sD6 :<C-u>Digrep ../../../../../..<CR>
nnoremap <Leader>sr6 :<C-u>Drg ../../../../../..<CR>
nnoremap <Leader>sR6 :<C-u>Dru ../../../../../..<CR>

nnoremap <Leader>sp7 :<C-u>Files ../../../../../../..<CR>
nnoremap <Leader>ss7 :<C-u>Dah ../../../../../../..<CR>
nnoremap <Leader>sS7 :<C-u>Dau ../../../../../../..<CR>
nnoremap <Leader>sd7 :<C-u>Dgrep ../../../../../../..<CR>
nnoremap <Leader>sD7 :<C-u>Digrep ../../../../../../..<CR>
nnoremap <Leader>sr7 :<C-u>Drg ../../../../../../..<CR>
nnoremap <Leader>sR7 :<C-u>Dru ../../../../../../..<CR>

nnoremap <Leader>sp8 :<C-u>Files ../../../../../../../..<CR>
nnoremap <Leader>ss8 :<C-u>Dah ../../../../../../../..<CR>
nnoremap <Leader>sS8 :<C-u>Dau ../../../../../../../..<CR>
nnoremap <Leader>sd8 :<C-u>Dgrep ../../../../../../../..<CR>
nnoremap <Leader>sD8 :<C-u>Digrep ../../../../../../../..<CR>
nnoremap <Leader>sr8 :<C-u>Drg ../../../../../../../..<CR>
nnoremap <Leader>sR8 :<C-u>Dru ../../../../../../../..<CR>

nnoremap <Leader>sp9 :<C-u>Files ../../../../../../../../..<CR>
nnoremap <Leader>ss9 :<C-u>Dah ../../../../../../../../..<CR>
nnoremap <Leader>sS9 :<C-u>Dau ../../../../../../../../..<CR>
nnoremap <Leader>sd9 :<C-u>Dgrep ../../../../../../../../..<CR>
nnoremap <Leader>sD9 :<C-u>Digrep ../../../../../../../../..<CR>
nnoremap <Leader>sr9 :<C-u>Drg ../../../../../../../../..<CR>
nnoremap <Leader>sR9 :<C-u>Dru ../../../../../../../../..<CR>


nnoremap <Leader>spg :<C-u> exe 'Files '.GitRoot()<CR>
nnoremap <Leader>ssg :<C-u> exe 'Dah '.GitRoot()<CR>
nnoremap <Leader>sSg :<C-u> exe 'Dau '.GitRoot()<CR>
nnoremap <Leader>sdg :<C-u> exe 'Dgrep '.GitRoot()<CR>
nnoremap <Leader>sDg :<C-u> exe 'Digrep '.GitRoot()<CR>
nnoremap <Leader>srg :<C-u> exe 'Drg '.GitRoot()<CR>
nnoremap <Leader>sRg :<C-u> exe 'Dru '.GitRoot()<CR>

nnoremap <Leader>spG :<C-u> exe 'Files '.GitRoot(GitRoot().'/..')<CR>
nnoremap <Leader>ssG :<C-u> exe 'Dah '.GitRoot(GitRoot().'/..')<CR>
nnoremap <Leader>sSG :<C-u> exe 'Dau '.GitRoot(GitRoot().'/..')<CR>
nnoremap <Leader>sdG :<C-u> exe 'Dgrep '.GitRoot(GitRoot().'/..')<CR>
nnoremap <Leader>sDG :<C-u> exe 'Digrep '.GitRoot(GitRoot().'/..')<CR>
nnoremap <Leader>srG :<C-u> exe 'Drg '.GitRoot(GitRoot().'/..')<CR>
nnoremap <Leader>sRG :<C-u> exe 'Dru '.GitRoot(GitRoot().'/..')<CR>

nnoremap <Leader>spm :<C-u> exe 'Files '.HgRoot()<CR>
nnoremap <Leader>ssm :<C-u> exe 'Dah '.HgRoot()<CR>
nnoremap <Leader>sSm :<C-u> exe 'Dau '.HgRoot()<CR>
nnoremap <Leader>sdm :<C-u> exe 'Dgrep '.HgRoot()<CR>
nnoremap <Leader>sDm :<C-u> exe 'Digrep '.HgRoot()<CR>
nnoremap <Leader>srm :<C-u> exe 'Drg '.HgRoot()<CR>
nnoremap <Leader>sRm :<C-u> exe 'Dru '.HgRoot()<CR>

nnoremap <Leader>spM :<C-u> exe 'Files '.HgRoot(HgRoot().'/..')<CR>
nnoremap <Leader>ssM :<C-u> exe 'Dah '.HgRoot(HgRoot().'/..')<CR>
nnoremap <Leader>sSM :<C-u> exe 'Dau '.HgRoot(HgRoot().'/..')<CR>
nnoremap <Leader>sdM :<C-u> exe 'Dgrep '.HgRoot(HgRoot().'/..')<CR>
nnoremap <Leader>sDM :<C-u> exe 'Digrep '.HgRoot(HgRoot().'/..')<CR>
nnoremap <Leader>srM :<C-u> exe 'Drg '.HgRoot(HgRoot().'/..')<CR>
nnoremap <Leader>sRM :<C-u> exe 'Dru '.HgRoot(HgRoot().'/..')<CR>

nnoremap <Leader>spr :<C-u> exe 'Files '.PartRoot()<CR>
nnoremap <Leader>ssr :<C-u> exe 'Dah '.PartRoot()<CR>
nnoremap <Leader>sSr :<C-u> exe 'Dau '.PartRoot()<CR>
nnoremap <Leader>sdr :<C-u> exe 'Dgrep '.PartRoot()<CR>
nnoremap <Leader>sDr :<C-u> exe 'Digrep '.PartRoot()<CR>
nnoremap <Leader>srr :<C-u> exe 'Drg '.PartRoot()<CR>
nnoremap <Leader>sRr :<C-u> exe 'Dru '.PartRoot()<CR>

nnoremap <Leader>spb :<C-u> exe 'Files '.g:starting_path<CR>
nnoremap <Leader>ssb :<C-u> exe 'Dah '.g:starting_path<CR>
nnoremap <Leader>sSb :<C-u> exe 'Dau '.g:starting_path<CR>
nnoremap <Leader>sdb :<C-u> exe 'Dgrep '.g:starting_path<CR>
nnoremap <Leader>sDb :<C-u> exe 'Digrep '.g:starting_path<CR>
nnoremap <Leader>srb :<C-u> exe 'Drg '.g:starting_path<CR>
nnoremap <Leader>sRb :<C-u> exe 'Dru '.g:starting_path<CR>

nnoremap <Leader>spe :<C-u> exe 'Files '.EnvrcRoot()<CR>
nnoremap <Leader>sse :<C-u> exe 'Dah '.EnvrcRoot()<CR>
nnoremap <Leader>sSe :<C-u> exe 'Dau '.EnvrcRoot()<CR>
nnoremap <Leader>sde :<C-u> exe 'Dgrep '.EnvrcRoot()<CR>
nnoremap <Leader>sDe :<C-u> exe 'Digrep '.EnvrcRoot()<CR>
nnoremap <Leader>sre :<C-u> exe 'Drg '.EnvrcRoot()<CR>
nnoremap <Leader>sRe :<C-u> exe 'Dru '.EnvrcRoot()<CR>

nnoremap <Leader>spE :<C-u> exe 'Files '.EnvrcRoot(EnvrcRoot().'/..')<CR>
nnoremap <Leader>ssE :<C-u> exe 'Dah '.EnvrcRoot(EnvrcRoot().'/..')<CR>
nnoremap <Leader>sSE :<C-u> exe 'Dau '.EnvrcRoot(EnvrcRoot().'/..')<CR>
nnoremap <Leader>sdE :<C-u> exe 'Dgrep '.EnvrcRoot(EnvrcRoot().'/..')<CR>
nnoremap <Leader>sDE :<C-u> exe 'Digrep '.EnvrcRoot(EnvrcRoot().'/..')<CR>
nnoremap <Leader>srE :<C-u> exe 'Drg '.EnvrcRoot(EnvrcRoot().'/..')<CR>
nnoremap <Leader>sRE :<C-u> exe 'Dru '.EnvrcRoot(EnvrcRoot().'/..')<CR>

nnoremap <Leader>sp<C-e> :<C-u> exe 'Files '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>
nnoremap <Leader>ss<C-e> :<C-u> exe 'Dah '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>
nnoremap <Leader>sS<C-e> :<C-u> exe 'Dau '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>
nnoremap <Leader>sd<C-e> :<C-u> exe 'Dgrep '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>
nnoremap <Leader>sD<C-e> :<C-u> exe 'Digrep '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>
nnoremap <Leader>sr<C-e> :<C-u> exe 'Drg '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>
nnoremap <Leader>sR<C-e> :<C-u> exe 'Dru '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>

" }}}
