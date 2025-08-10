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

function g:fzf_vim.listproc(list)
  if g:qfloc
    fzf#vim#listproc#location(list)
  else
    fzf#vim#listproc#quickfix(list)
  endif
endfunction

let g:fzf_vim.tags_command = 'ctags -R'

let g:fzf_layout = {'down': '100%'}
" border is useful here
let g:fzf_preview_default = 'up,50%'
let g:fzf_vim.preview_window = [g:fzf_preview_default, 'ctrl-s']

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
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }

" }}} 

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

nnoremap <leader>gsf :<C-u>GFiles<CR>
nnoremap <leader>gsm :<C-u>GFiles?<CR>
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

let g:fzf_action = {
      \ 'alt-q': function('s:build_quickfix_list'),
      \ 'alt-t': function('s:tab_args'),
      \ 'alt-T': 'Tabe',
      \ 'alt-v': 'view',
      \ 'alt-V': 'TabV',
      \ 'alt-L': function('s:populate_arg_list'),
      \ 'alt-l': function('s:add_arg_list'),
      \ }
      " TODO C

" }}} 


function s:SetupFzf()

" path maps {{{

" empty cmds
nnoremap <Leader>sp<Space> :<C-u>Files<Space>
nnoremap <Leader>sp<CR> :<C-u>Files<CR>
nnoremap <Leader>ss<Space> :<C-u>Dah<Space>
nnoremap <Leader>ss<CR> :<C-u>Dah<CR>
nnoremap <Leader>sS<Space> :<C-u>Dau<Space>
nnoremap <Leader>sS<CR> :<C-u>Dau<CR>
nnoremap <Leader>sg<Space> :<C-u>Dgrep<Space>
nnoremap <Leader>sg<CR> :<C-u>Dgrep<CR>
nnoremap <Leader>sG<Space> :<C-u>Digrep<Space>
nnoremap <Leader>sG<CR> :<C-u>Digrep<CR>
nnoremap <Leader>sr<Space> :<C-u>Drg<Space>
nnoremap <Leader>sr<CR> :<C-u>Drg<CR>
nnoremap <Leader>sR<Space> :<C-u>Dru<Space>
nnoremap <Leader>sR<CR> :<C-u>Dru<CR>

nnoremap <Leader>sph :<C-u>Files ~<CR>
nnoremap <Leader>ssh :<C-u>Dah ~<CR>
nnoremap <Leader>sSh :<C-u>Dau ~<CR>
nnoremap <Leader>sgh :<C-u>Dgrep ~<CR>
nnoremap <Leader>sGh :<C-u>Digrep ~<CR>
nnoremap <Leader>srh :<C-u>Drg ~<CR>
nnoremap <Leader>sRh :<C-u>Dru ~<CR>

nnoremap <Leader>spt :<C-u>Files ~/Templates<CR>
nnoremap <Leader>sst :<C-u>Dah ~/Templates<CR>
nnoremap <Leader>sSt :<C-u>Dau ~/Templates<CR>
nnoremap <Leader>sgt :<C-u>Dgrep ~/Templates<CR>
nnoremap <Leader>sGt :<C-u>Digrep ~/Templates<CR>
nnoremap <Leader>srt :<C-u>Drg ~/Templates<CR>
nnoremap <Leader>sRt :<C-u>Dru ~/Templates<CR>

nnoremap <Leader>spd :<C-u>Files ~/Dbackup<CR>
nnoremap <Leader>ssd :<C-u>Dah ~/Dbackup<CR>
nnoremap <Leader>sSd :<C-u>Dau ~/Dbackup<CR>
nnoremap <Leader>sgd :<C-u>Dgrep ~/Dbackup<CR>
nnoremap <Leader>sGd :<C-u>Digrep ~/Dbackup<CR>
nnoremap <Leader>srd :<C-u>Drg ~/Dbackup<CR>
nnoremap <Leader>sRd :<C-u>Dru ~/Dbackup<CR>

nnoremap <Leader>spD :<C-u>Files ~/Downloads<CR>
nnoremap <Leader>ssD :<C-u>Dah ~/Downloads<CR>
nnoremap <Leader>sSD :<C-u>Dau ~/Downloads<CR>
nnoremap <Leader>sgD :<C-u>Dgrep ~/Downloads<CR>
nnoremap <Leader>sGD :<C-u>Digrep ~/Downloads<CR>
nnoremap <Leader>srD :<C-u>Drg ~/Downloads<CR>
nnoremap <Leader>sRD :<C-u>Dru ~/Downloads<CR>

nnoremap <Leader>spf :<C-u>Files ~/Documents<CR>
nnoremap <Leader>ssf :<C-u>Dah ~/Documents<CR>
nnoremap <Leader>sSf :<C-u>Dau ~/Documents<CR>
nnoremap <Leader>sgf :<C-u>Dgrep ~/Documents<CR>
nnoremap <Leader>sGf :<C-u>Digrep ~/Documents<CR>
nnoremap <Leader>srf :<C-u>Drg ~/Documents<CR>
nnoremap <Leader>sRf :<C-u>Dru ~/Documents<CR>

nnoremap <Leader>spp :<C-u>Files ~/gits<CR>
nnoremap <Leader>ssp :<C-u>Dah ~/gits<CR>
nnoremap <Leader>sSp :<C-u>Dau ~/gits<CR>
nnoremap <Leader>sgp :<C-u>Dgrep ~/gits<CR>
nnoremap <Leader>sGp :<C-u>Digrep ~/gits<CR>
nnoremap <Leader>srp :<C-u>Drg ~/gits<CR>
nnoremap <Leader>sRp :<C-u>Dru ~/gits<CR>

nnoremap <Leader>spcc :<C-u>Files ~/.config<CR>
nnoremap <Leader>sscc :<C-u>Dah ~/.config<CR>
nnoremap <Leader>sScc :<C-u>Dau ~/.config<CR>
nnoremap <Leader>sgcc :<C-u>Dgrep ~/.config<CR>
nnoremap <Leader>sGcc :<C-u>Digrep ~/.config<CR>
nnoremap <Leader>srcc :<C-u>Drg ~/.config<CR>
nnoremap <Leader>sRcc :<C-u>Dru ~/.config<CR>

nnoremap <Leader>spcv :<C-u>Files ~/.vim<CR>
nnoremap <Leader>sscv :<C-u>Dah ~/.vim<CR>
nnoremap <Leader>sScv :<C-u>Dau ~/.vim<CR>
nnoremap <Leader>sgcv :<C-u>Dgrep ~/.vim<CR>
nnoremap <Leader>sGcv :<C-u>Digrep ~/.vim<CR>
nnoremap <Leader>srcv :<C-u>Drg ~/.vim<CR>
nnoremap <Leader>sRcv :<C-u>Dru ~/.vim<CR>

nnoremap <Leader>spcn :<C-u>Files ~/.config/nvim<CR>
nnoremap <Leader>sscn :<C-u>Dah ~/.config/nvim<CR>
nnoremap <Leader>sScn :<C-u>Dau ~/.config/nvim<CR>
nnoremap <Leader>sgcn :<C-u>Dgrep ~/.config/nvim<CR>
nnoremap <Leader>sGcn :<C-u>Digrep ~/.config/nvim<CR>
nnoremap <Leader>srcn :<C-u>Drg ~/.config/nvim<CR>
nnoremap <Leader>sRcn :<C-u>Dru ~/.config/nvim<CR>

nnoremap <Leader>sp. :<C-u>Files .<CR>
nnoremap <Leader>ss. :<C-u>Dah .<CR>
nnoremap <Leader>sS. :<C-u>Dau .<CR>
nnoremap <Leader>sg. :<C-u>Dgrep .<CR>
nnoremap <Leader>sG. :<C-u>Digrep .<CR>
nnoremap <Leader>sr. :<C-u>Drg .<CR>
nnoremap <Leader>sR. :<C-u>Dru .<CR>


nnoremap <Leader>spg :<C-u> exe 'Files '.GitRoot()<CR>
nnoremap <Leader>ssg :<C-u> exe 'Dah '.GitRoot()<CR>
nnoremap <Leader>sSg :<C-u> exe 'Dau '.GitRoot()<CR>
nnoremap <Leader>sgg :<C-u> exe 'Dgrep '.GitRoot()<CR>
nnoremap <Leader>sGg :<C-u> exe 'Digrep '.GitRoot()<CR>
nnoremap <Leader>srg :<C-u> exe 'Drg '.GitRoot()<CR>
nnoremap <Leader>sRg :<C-u> exe 'Dru '.GitRoot()<CR>

nnoremap <Leader>spG :<C-u> exe 'Files '.GitRoot(GitRoot().'/..')<CR>
nnoremap <Leader>ssG :<C-u> exe 'Dah '.GitRoot(GitRoot().'/..')<CR>
nnoremap <Leader>sSG :<C-u> exe 'Dau '.GitRoot(GitRoot().'/..')<CR>
nnoremap <Leader>sgG :<C-u> exe 'Dgrep '.GitRoot(GitRoot().'/..')<CR>
nnoremap <Leader>sGG :<C-u> exe 'Digrep '.GitRoot(GitRoot().'/..')<CR>
nnoremap <Leader>srG :<C-u> exe 'Drg '.GitRoot(GitRoot().'/..')<CR>
nnoremap <Leader>sRG :<C-u> exe 'Dru '.GitRoot(GitRoot().'/..')<CR>

nnoremap <Leader>spm :<C-u> exe 'Files '.HgRoot()<CR>
nnoremap <Leader>ssm :<C-u> exe 'Dah '.HgRoot()<CR>
nnoremap <Leader>sSm :<C-u> exe 'Dau '.HgRoot()<CR>
nnoremap <Leader>sgm :<C-u> exe 'Dgrep '.HgRoot()<CR>
nnoremap <Leader>sGm :<C-u> exe 'Digrep '.HgRoot()<CR>
nnoremap <Leader>srm :<C-u> exe 'Drg '.HgRoot()<CR>
nnoremap <Leader>sRm :<C-u> exe 'Dru '.HgRoot()<CR>

nnoremap <Leader>spM :<C-u> exe 'Files '.HgRoot(HgRoot().'/..')<CR>
nnoremap <Leader>ssM :<C-u> exe 'Dah '.HgRoot(HgRoot().'/..')<CR>
nnoremap <Leader>sSM :<C-u> exe 'Dau '.HgRoot(HgRoot().'/..')<CR>
nnoremap <Leader>sgM :<C-u> exe 'Dgrep '.HgRoot(HgRoot().'/..')<CR>
nnoremap <Leader>sGM :<C-u> exe 'Digrep '.HgRoot(HgRoot().'/..')<CR>
nnoremap <Leader>srM :<C-u> exe 'Drg '.HgRoot(HgRoot().'/..')<CR>
nnoremap <Leader>sRM :<C-u> exe 'Dru '.HgRoot(HgRoot().'/..')<CR>

nnoremap <Leader>spr :<C-u> exe 'Files '.PartRoot()<CR>
nnoremap <Leader>ssr :<C-u> exe 'Dah '.PartRoot()<CR>
nnoremap <Leader>sSr :<C-u> exe 'Dau '.PartRoot()<CR>
nnoremap <Leader>sgr :<C-u> exe 'Dgrep '.PartRoot()<CR>
nnoremap <Leader>sGr :<C-u> exe 'Digrep '.PartRoot()<CR>
nnoremap <Leader>srr :<C-u> exe 'Drg '.PartRoot()<CR>
nnoremap <Leader>sRr :<C-u> exe 'Dru '.PartRoot()<CR>

nnoremap <Leader>spb :<C-u> exe 'Files '.g:starting_path<CR>
nnoremap <Leader>ssb :<C-u> exe 'Dah '.g:starting_path<CR>
nnoremap <Leader>sSb :<C-u> exe 'Dau '.g:starting_path<CR>
nnoremap <Leader>sgb :<C-u> exe 'Dgrep '.g:starting_path<CR>
nnoremap <Leader>sGb :<C-u> exe 'Digrep '.g:starting_path<CR>
nnoremap <Leader>srb :<C-u> exe 'Drg '.g:starting_path<CR>
nnoremap <Leader>sRb :<C-u> exe 'Dru '.g:starting_path<CR>

nnoremap <Leader>spe :<C-u> exe 'Files '.EnvrcRoot()<CR>
nnoremap <Leader>sse :<C-u> exe 'Dah '.EnvrcRoot()<CR>
nnoremap <Leader>sSe :<C-u> exe 'Dau '.EnvrcRoot()<CR>
nnoremap <Leader>sge :<C-u> exe 'Dgrep '.EnvrcRoot()<CR>
nnoremap <Leader>sGe :<C-u> exe 'Digrep '.EnvrcRoot()<CR>
nnoremap <Leader>sre :<C-u> exe 'Drg '.EnvrcRoot()<CR>
nnoremap <Leader>sRe :<C-u> exe 'Dru '.EnvrcRoot()<CR>

nnoremap <Leader>spE :<C-u> exe 'Files '.EnvrcRoot(EnvrcRoot().'/..')<CR>
nnoremap <Leader>ssE :<C-u> exe 'Dah '.EnvrcRoot(EnvrcRoot().'/..')<CR>
nnoremap <Leader>sSE :<C-u> exe 'Dau '.EnvrcRoot(EnvrcRoot().'/..')<CR>
nnoremap <Leader>sgE :<C-u> exe 'Dgrep '.EnvrcRoot(EnvrcRoot().'/..')<CR>
nnoremap <Leader>sGE :<C-u> exe 'Digrep '.EnvrcRoot(EnvrcRoot().'/..')<CR>
nnoremap <Leader>srE :<C-u> exe 'Drg '.EnvrcRoot(EnvrcRoot().'/..')<CR>
nnoremap <Leader>sRE :<C-u> exe 'Dru '.EnvrcRoot(EnvrcRoot().'/..')<CR>

nnoremap <Leader>sp<C-e> :<C-u> exe 'Files '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>
nnoremap <Leader>ss<C-e> :<C-u> exe 'Dah '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>
nnoremap <Leader>sS<C-e> :<C-u> exe 'Dau '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>
nnoremap <Leader>sg<C-e> :<C-u> exe 'Dgrep '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>
nnoremap <Leader>sG<C-e> :<C-u> exe 'Digrep '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>
nnoremap <Leader>sr<C-e> :<C-u> exe 'Drg '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>
nnoremap <Leader>sR<C-e> :<C-u> exe 'Dru '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')<CR>

nnoremap <Leader>sp1 :<C-u> exe 'Files '.B(1)<CR>
nnoremap <Leader>ss1 :<C-u> exe 'Dah '.B(1)<CR>
nnoremap <Leader>sS1 :<C-u> exe 'Dau '.B(1)<CR>
nnoremap <Leader>sg1 :<C-u> exe 'Dgrep '.B(1)<CR>
nnoremap <Leader>sG1 :<C-u> exe 'Digrep '.B(1)<CR>
nnoremap <Leader>sr1 :<C-u> exe 'Drg '.B(1)<CR>
nnoremap <Leader>sR1 :<C-u> exe 'Dru '.B(1)<CR>

nnoremap <Leader>sp2 :<C-u> exe 'Files '.B(2)<CR>
nnoremap <Leader>ss2 :<C-u> exe 'Dah '.B(2)<CR>
nnoremap <Leader>sS2 :<C-u> exe 'Dau '.B(2)<CR>
nnoremap <Leader>sg2 :<C-u> exe 'Dgrep '.B(2)<CR>
nnoremap <Leader>sG2 :<C-u> exe 'Digrep '.B(2)<CR>
nnoremap <Leader>sr2 :<C-u> exe 'Drg '.B(2)<CR>
nnoremap <Leader>sR2 :<C-u> exe 'Dru '.B(2)<CR>

nnoremap <Leader>sp3 :<C-u> exe 'Files '.B(3)<CR>
nnoremap <Leader>ss3 :<C-u> exe 'Dah '.B(3)<CR>
nnoremap <Leader>sS3 :<C-u> exe 'Dau '.B(3)<CR>
nnoremap <Leader>sg3 :<C-u> exe 'Dgrep '.B(3)<CR>
nnoremap <Leader>sG3 :<C-u> exe 'Digrep '.B(3)<CR>
nnoremap <Leader>sr3 :<C-u> exe 'Drg '.B(3)<CR>
nnoremap <Leader>sR3 :<C-u> exe 'Dru '.B(3)<CR>

nnoremap <Leader>sp4 :<C-u> exe 'Files '.B(4)<CR>
nnoremap <Leader>ss4 :<C-u> exe 'Dah '.B(4)<CR>
nnoremap <Leader>sS4 :<C-u> exe 'Dau '.B(4)<CR>
nnoremap <Leader>sg4 :<C-u> exe 'Dgrep '.B(4)<CR>
nnoremap <Leader>sG4 :<C-u> exe 'Digrep '.B(4)<CR>
nnoremap <Leader>sr4 :<C-u> exe 'Drg '.B(4)<CR>
nnoremap <Leader>sR4 :<C-u> exe 'Dru '.B(4)<CR>

nnoremap <Leader>sp5 :<C-u> exe 'Files '.B(5)<CR>
nnoremap <Leader>ss5 :<C-u> exe 'Dah '.B(5)<CR>
nnoremap <Leader>sS5 :<C-u> exe 'Dau '.B(5)<CR>
nnoremap <Leader>sg5 :<C-u> exe 'Dgrep '.B(5)<CR>
nnoremap <Leader>sG5 :<C-u> exe 'Digrep '.B(5)<CR>
nnoremap <Leader>sr5 :<C-u> exe 'Drg '.B(5)<CR>
nnoremap <Leader>sR5 :<C-u> exe 'Dru '.B(5)<CR>

nnoremap <Leader>sp6 :<C-u> exe 'Files '.B(6)<CR>
nnoremap <Leader>ss6 :<C-u> exe 'Dah '.B(6)<CR>
nnoremap <Leader>sS6 :<C-u> exe 'Dau '.B(6)<CR>
nnoremap <Leader>sg6 :<C-u> exe 'Dgrep '.B(6)<CR>
nnoremap <Leader>sG6 :<C-u> exe 'Digrep '.B(6)<CR>
nnoremap <Leader>sr6 :<C-u> exe 'Drg '.B(6)<CR>
nnoremap <Leader>sR6 :<C-u> exe 'Dru '.B(6)<CR>

nnoremap <Leader>sp7 :<C-u> exe 'Files '.B(7)<CR>
nnoremap <Leader>ss7 :<C-u> exe 'Dah '.B(7)<CR>
nnoremap <Leader>sS7 :<C-u> exe 'Dau '.B(7)<CR>
nnoremap <Leader>sg7 :<C-u> exe 'Dgrep '.B(7)<CR>
nnoremap <Leader>sG7 :<C-u> exe 'Digrep '.B(7)<CR>
nnoremap <Leader>sr7 :<C-u> exe 'Drg '.B(7)<CR>
nnoremap <Leader>sR7 :<C-u> exe 'Dru '.B(7)<CR>

nnoremap <Leader>sp8 :<C-u> exe 'Files '.B(8)<CR>
nnoremap <Leader>ss8 :<C-u> exe 'Dah '.B(8)<CR>
nnoremap <Leader>sS8 :<C-u> exe 'Dau '.B(8)<CR>
nnoremap <Leader>sg8 :<C-u> exe 'Dgrep '.B(8)<CR>
nnoremap <Leader>sG8 :<C-u> exe 'Digrep '.B(8)<CR>
nnoremap <Leader>sr8 :<C-u> exe 'Drg '.B(8)<CR>
nnoremap <Leader>sR8 :<C-u> exe 'Dru '.B(8)<CR>

nnoremap <Leader>sp9 :<C-u> exe 'Files '.B(9)<CR>
nnoremap <Leader>ss9 :<C-u> exe 'Dah '.B(9)<CR>
nnoremap <Leader>sS9 :<C-u> exe 'Dau '.B(9)<CR>
nnoremap <Leader>sg9 :<C-u> exe 'Dgrep '.B(9)<CR>
nnoremap <Leader>sG9 :<C-u> exe 'Digrep '.B(9)<CR>
nnoremap <Leader>sr9 :<C-u> exe 'Drg '.B(9)<CR>
nnoremap <Leader>sR9 :<C-u> exe 'Dru '.B(9)<CR>

" }}}
endfunction
call lazy_utils#LoadOnKeys("<Leader>s", expand("<SID>").."SetupFzf")
