"{{{ diff

function DiffGet(pane)
  execute 'diffget' a:pane
  diffupdate
endfunction

function DiffPut(pane)
  execute 'diffget' a:pane
  diffupdate
endfunction

noremap <silent> <leader>fdp :<C-u>diffput<CR>
noremap <silent> <leader>fdg :<C-u>diffget<CR>
nnoremap <silent> <leader>fdu :<C-u>diffupdate<CR>
vnoremap <silent> <leader>fdu :<C-u>diffupdate\|norm gv<CR>

" TODO more of that
noremap <silent> <leader>fg0 :<C-u>call DiffGet('//0')<CR>
noremap <silent> <leader>fg1 :<C-u>call DiffGet('//1')<CR>
noremap <silent> <leader>fg2 :<C-u>call DiffGet('//2')<CR>
noremap <silent> <leader>fg3 :<C-u>call DiffGet('//3')<CR>

noremap <silent> <leader>fp0 :<C-u>call DiffPut('//0')<CR>
noremap <silent> <leader>fp1 :<C-u>call DiffPut('//1')<CR>
noremap <silent> <leader>fp2 :<C-u>call DiffPut('//2')<CR>
noremap <silent> <leader>fp3 :<C-u>call DiffPut('//3')<CR>

noremap <silent> <leader>fpf :<C-u>call DiffPut(Expand('%:p'))<CR>
noremap <silent> <leader>fp;f :<C-u>call DiffPut(Expand('%:t'))<CR>
noremap <silent> <leader>fgf :<C-u>call DiffGet(Expand('%:p'))<CR>
noremap <silent> <leader>fg;f :<C-u>call DiffGet(Expand('%:t'))<CR>

"}}}

"{{{ drag and drop

" TODO C more ?

" Pushing to dragon
nnoremap <silent> <Leader>xy
      \ :<C-u>exe '!dragon --on-top --and-exit '.
      \ Expand("%").' 2>/dev/null &'<CR>
      \ :redraw!<CR>
vnoremap <silent> <Leader>xy
      \ :<C-u>exe '!dragon --on-top --and-exit '.
      \ Expand("%").' 2>/dev/null &'<CR>
      \ :redraw!<CR>
      \ :norm gv<CR>

nnoremap <silent> <Leader>xY
      \ :<C-u>exe '!dragon --on-top --and-exit '.
      \ Expand("<cfile>").' 2>/dev/null &'<CR>
      \ :redraw!<CR>
vnoremap <silent> <Leader>xY
      \ :<C-u>exe '!dragon --on-top --and-exit '.
      \ Expand("<cfile>").' 2>/dev/null &'<CR>
      \ :redraw!<CR>
      \ :norm gv<CR>

" Editing from dragon
noremap <Leader>x<space>o
      \ :<C-u>exe 'argedit '.
      \ system('dragon --on-top --target --and-exit '.
      \ '2>/dev/null')<CR>
      \ :redraw<CR>
noremap <C-w><Leader>xo
      \ :<C-u>exe 'tabedit '.
      \ system('dragon --on-top --target --and-exit '.
      \ '2>/dev/null')<CR>
      \ :redraw<CR>
noremap <Leader>xo
      \ :<C-u>exe 'edit '.
      \ system('dragon --on-top --target --and-exit '.
      \ '2>/dev/null')<CR>
      \ :redraw<CR>

"}}}

"{{{ find

nnoremap <Space><Space>f<Space> :find<Space>
nnoremap <Space><Space>fa :find *
nnoremap <Space><Space>fr :find **
nnoremap <Space><Space>f;a :find *<Tab>
nnoremap <Space><Space>f;r :find **<Tab>

nnoremap <Space><Space>f;<Space> :find!<Space>
nnoremap <Space><Space>fA :find! *
nnoremap <Space><Space>fR :find! **
nnoremap <Space><Space>f;A :find! *<Tab>
nnoremap <Space><Space>f;R :find! **<Tab>

nnoremap <C-w><Space><Space>f<Space> :tabfind<Space>
nnoremap <C-w><Space><Space>fa :tabfind *
nnoremap <C-w><Space><Space>fr :tabfind **
nnoremap <C-w><Space><Space>f;a :tabfind *<Tab>
nnoremap <C-w><Space><Space>f;r :tabfind **<Tab>

nnoremap <C-w><Space><Space>f;<Space> :tabfind!<Space>
nnoremap <C-w><Space><Space>fA :tabfind! *
nnoremap <C-w><Space><Space>fR :tabfind! **
nnoremap <C-w><Space><Space>f;A :tabfind! *<Tab>
nnoremap <C-w><Space><Space>f;R :tabfind! **<Tab>

"}}}

"{{{ grep

"{{{ helpers

function! Grep(...)
  let cmd = join([&grepprg] + [join(a:000, ' ')], ' ')
  return system(cmd)
endfunction

command! -nargs=+ -complete=file_in_path Grep cexpr Grep(<f-args>)

"}}}

"{{{ external providers

" TODO A more
let g:grepprgs = 
      \ [
      \ 'grep\ -EIn\ $*\ /dev/null',
      \ 'rg\ --vimgrep\ --smart-case\ --hidden',
      \ ]

" https://vi.stackexchange.com/questions/35139/custom-arguments-to-user-command
function Grepprgs(current_arg, command_line, cursor_position)
  let l = len(a:current_arg) - 1
  if l >= 0
    let filtered_args = copy(g:grepprgs)
    call filter(
          \ filtered_args,
          \ {_, v -> v[:l] ==# a:current_arg})
    if !empty(filtered_args)
      return filtered_args
    endif
  endif
  return g:grepprgs
endfunction

set grepprg=grep\ -EIn\ $*\ /dev/null

command! -nargs=1 -complete=customlist,Grepprgs ExtGrep 
      \ set grepprg=<args>

nnoremap <Space>s: :<C-u>ExtGrep<Space>
vnoremap <Space>s: :<C-u>ExtGrep  \|norm gv
      \ <C-Left><C-Left><Left>

"}}}

"{{{ external

noremap <expr> <Space>s- g:qfloc ?
      \ ':<C-u>Lfilter /^[^\|][^\|] /<CR>'
      \ : ':<C-u>Cfilter /^[^\|][^\|] /<CR>'

noremap <expr> <Space>s;r g:qfloc ?
      \ ':<C-u>lgrep<Space>'
      \ : ':<C-u>grep<Space>'
noremap <expr> <Space>s;R g:qfloc ?
      \ ':<C-u>lgrep!<Space>'
      \ : ':<C-u>grep!<Space>'

noremap <expr> <Space>sr g:qfloc ?
      \ ':<C-u>'.v:count1.'lgrep<Space>'
      \ : ':<C-u>'.v:count1.'grep<Space>'
noremap <expr> <Space>sR g:qfloc ?
      \ ':<C-u>'.v:count1.'lgrep!<Space>'
      \ : ':<C-u>'.v:count1.'grep!<Space>'

"}}}

"{{{ vimgrep

noremap <expr> <Space>fr g:qfloc ?
      \ ':<C-u>'.v:count1.'lvimgrep<Space>'
      \ : ':<C-u>'.v:count1.'vimgrep<Space>'
noremap <expr> <Space>fR g:qfloc ?
      \ ':<C-u>'.v:count1.'lvimgrep!<Space>'
      \ : ':<C-u>'.v:count1.'vimgrep!<Space>'

noremap <expr> <Space>f;r g:qfloc ?
      \ ':<C-u>lgrep<Space>'
      \ : ':<C-u>grep<Space>'
noremap <expr> <Space>f;R g:qfloc ?
      \ ':<C-u>lvimgrep!<Space>'
      \ : ':<C-u>vimgrep!<Space>'

"}}}

"{{{ old grep

nnoremap <expr> <Space>sc g:qfloc ? 
      \ ':<C-u>lgrep <cword> . <CR>'
      \ : ':<C-u>grep <cword> . <CR>'
vnoremap <expr> <Space>sc g:qfloc ? 
      \ ":<C-u>exe 'lgrep '.GetVisualSelection().' .'<CR>\|norm gv"
      \ : ":<C-u>exe 'grep '.GetVisualSelection().' .'<CR>\|norm gv"

noremap <expr> <Space>sf g:qfloc ?
      \ ':<C-u>'.v:count1.
      \ 'lgrep  %<Left><Left>'
      \ : ':<C-u>'.v:count1.
      \ 'grep  %<Left><Left>'

" arglist doesn't work with external commands
" nnoremap <expr> <Space>sll g:qfloc ? 
"             \ ':<C-u>lgrep '.shellescape(Expand('<cword>')).' ## <CR>'
"             \ : ':<C-u>grep '.shellescape(Expand('<cword>')).' ## <CR>'
" vnoremap <expr> <Space>sll g:qfloc ? 
"             \ ':<C-u>lgrep '.GetVisualSelection().' ## \| norm gv<CR>'
"             \ : ':<C-u>grep '.GetVisualSelection().' ## \| norm gv<CR>'
" nnoremap <expr> <Space>slL g:qfloc ? 
"             \ ':<C-u>lgrep '.shellescape(Expand('<cword>')).' ## <CR>'
"             \ : ':<C-u>grep '.shellescape(Expand('<cword>')).' ## <CR>'
" vnoremap <expr> <Space>slL g:qfloc ? 
"             \ ':<C-u>lgrep '.GetVisualSelection().' ## \| norm gv<CR>'
"             \ : ':<C-u>grep '.GetVisualSelection().' ## \| norm gv<CR>'

nnoremap <expr> <Space>sla g:qfloc ? 
      \ ':<C-u>lgrep '.Expand('<cword>').' * <CR>'
      \ : ':<C-u>grep '.Expand('<cword>').' * <CR>'
vnoremap <expr> <Space>sla g:qfloc ? 
      \ ':<C-u>lgrep '.GetVisualSelection().' * \| norm gv<CR>'
      \ : ':<C-u>grep '.GetVisualSelection().' * \| norm gv<CR>'
nnoremap <expr> <Space>slA g:qfloc ? 
      \ ':<C-u>lgrep '.Expand('<cword>').' * <CR>'
      \ : ':<C-u>grep '.Expand('<cword>').' * <CR>'
vnoremap <expr> <Space>slA g:qfloc ? 
      \ ':<C-u>lgrep '.GetVisualSelection().' * \| norm gv<CR>'
      \ : ':<C-u>grep '.GetVisualSelection().' * \| norm gv<CR>'

nnoremap <expr> <Space>slr g:qfloc ? 
      \ ':<C-u>lgrep '.Expand('<cword>').' **/* <CR>'
      \ : ':<C-u>grep '.Expand('<cword>').' **/* <CR>'
vnoremap <expr> <Space>slr g:qfloc ? 
      \ ':<C-u>lgrep '.GetVisualSelection().' **/* \| norm gv<CR>'
      \ : ':<C-u>grep '.GetVisualSelection().' **/* \| norm gv<CR>'
nnoremap <expr> <Space>slR g:qfloc ? 
      \ ':<C-u>lgrep '.Expand('<cword>').' **/* <CR>'
      \ : ':<C-u>grep '.Expand('<cword>').' **/* <CR>'
vnoremap <expr> <Space>slR g:qfloc ? 
      \ ':<C-u>lgrep '.GetVisualSelection().' **/* \| norm gv<CR>'
      \ : ':<C-u>grep '.GetVisualSelection().' **/* \| norm gv<CR>'

nnoremap <expr> <Space>sl<Space>a g:qfloc ? 
      \ ':<C-u>lgrep  *<C-Left><Left>'
      \ : ':<C-u>grep  *<C-Left><Left>'
nnoremap <expr> <Space>sl<Space>r g:qfloc ? 
      \ ':<C-u>lgrep  **/*<C-Left><Left>'
      \ : ':<C-u>grep  **/*<C-Left><Left>'

" nnoremap <expr> <Space>sl<Space>l g:qfloc ? 
"             \ ':<C-u>lgrep  ##<C-Left><Left>'
"             \ : ':<C-u>grep  ##<C-Left><Left>'


"}}}

"{{{ old vimgrep

nnoremap <expr> <Space>s/r g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Expand('<cword>').'/gj **/* <CR>'
      \ : ':<C-u>vimgrep /'.Expand('<cword>').'/gj **/* <CR>'
vnoremap <expr> <Space>s/r g:qfloc ? 
      \ ':<C-u>lvimgrep /'.GetVisualSelection().'/gj **/* \| norm gv<CR>'
      \ : ':<C-u>vimgrep /'.GetVisualSelection().'/gj **/* \| norm gv<CR>'
nnoremap <expr> <Space>s/R g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Expand('<cword>').'/fgj **/* <CR>'
      \ : ':<C-u>vimgrep /'.Expand('<cword>').'/fgj **/* <CR>'
vnoremap <expr> <Space>s/R g:qfloc ? 
      \ ':<C-u>lvimgrep /'.GetVisualSelection().'/fgj **/* \| norm gv<CR>'
      \ : ':<C-u>vimgrep /'.GetVisualSelection().'/fgj **/* \| norm gv<CR>'

nnoremap <expr> <Space>s/a g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Expand('<cword>').'/gj * <CR>'
      \ : ':<C-u>vimgrep /'.Expand('<cword>').'/gj * <CR>'
vnoremap <expr> <Space>s/a g:qfloc ? 
      \ ':<C-u>lvimgrep /'.GetVisualSelection().'/gj * \| norm gv<CR>'
      \ : ':<C-u>vimgrep /'.GetVisualSelection().'/gj * \| norm gv<CR>'
nnoremap <expr> <Space>s/A g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Expand('<cword>').'/fgj * <CR>'
      \ : ':<C-u>vimgrep /'.Expand('<cword>').'/fgj * <CR>'
vnoremap <expr> <Space>s/A g:qfloc ? 
      \ ':<C-u>lvimgrep /'.GetVisualSelection().'/fgj * \| norm gv<CR>'
      \ : ':<C-u>vimgrep /'.GetVisualSelection().'/fgj * \| norm gv<CR>'

nnoremap <expr> <Space>s/l g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Expand('<cword>').'/gj ## <CR>'
      \ : ':<C-u>vimgrep /'.Expand('<cword>').'/gj ## <CR>'
vnoremap <expr> <Space>s/l g:qfloc ? 
      \ ':<C-u>lvimgrep /'.GetVisualSelection().'/gj ## \| norm gv<CR>'
      \ : ':<C-u>vimgrep /'.GetVisualSelection().'/gj ## \| norm gv<CR>'
nnoremap <expr> <Space>s/L g:qfloc ? 
      \ ':<C-u>lvimgrep /'.Expand('<cword>').'/fgj ## <CR>'
      \ : ':<C-u>vimgrep /'.Expand('<cword>').'/fgj ## <CR>'
vnoremap <expr> <Space>s/L g:qfloc ? 
      \ ':<C-u>lvimgrep /'.GetVisualSelection().'/fgj ## \| norm gv<CR>'
      \ : ':<C-u>vimgrep /'.GetVisualSelection().'/fgj ## \| norm gv<CR>'

nnoremap <expr> <Space>s/<Space>a g:qfloc ? 
      \ ':<C-u>lvimgrep //gj *<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //gj *<C-Left><C-Left><Right>'
nnoremap <expr> <Space>s/<Space>r g:qfloc ? 
      \ ':<C-u>lvimgrep //gj **/*<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //gj **/*<C-Left><C-Left><Right>'
nnoremap <expr> <Space>s/<Space>l g:qfloc ? 
      \ ':<C-u>lvimgrep //gj ##<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //gj ##<C-Left><C-Left><Right>'

nnoremap <expr> <Space>s/<Space>A g:qfloc ? 
      \ ':<C-u>lvimgrep //fgj *<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //fgj *<C-Left><C-Left><Right>'
nnoremap <expr> <Space>s/<Space>R g:qfloc ? 
      \ ':<C-u>lvimgrep //fgj **/*<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //fgj **/*<C-Left><C-Left><Right>'
nnoremap <expr> <Space>s/<Space>L g:qfloc ? 
      \ ':<C-u>lvimgrep //fgj ##<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //fgj ##<C-Left><C-Left><Right>'

nnoremap <expr> <Space>s/c g:qfloc ?
      \ ':<C-u>lvimgrep //jg<C-left><Right>'
      \ : ':<C-u>vimgrep //jg<C-left><Right>'
nnoremap <expr> <Space>s/C g:qfloc ?
      \ ':<C-u>lvimgrep //fjg<C-left><Right>'
      \ : ':<C-u>vimgrep //fjg<C-left><Right>'

noremap <expr> <Space>s/f g:qfloc ?
      \ ':<C-u>'.v:count1.
      \ 'lvimgrep //g %<C-Left><C-Left><Right>'
      \ : ':<C-u>'.v:count1.
      \ 'vimgrep //g %<C-Left><C-Left><Right>'
noremap <expr> <Space>s/F g:qfloc ?
      \ ':<C-u>lvimgrep //g %<C-Left><C-Left><Right>'
      \ : ':<C-u>vimgrep //g %<C-Left><C-Left><Right>'

"}}}

"{{{ procedural

" function PathMap(key, path, cr=1)
"   exe 'noremap <leader>sp'.a:key.
"         \ ' :<C-u>Files '.a:path.
"         \ (a:cr ? '<CR>' : '')
"   exe 'noremap <leader>sa'.a:key.
"         \ ' :<C-u>Args '.a:path.
"         \ (a:cr ? '<CR>' : '')
"   exe 'noremap <leader>sm'.a:key.
"         \ ' :<C-u>MArgs '.a:path.
"         \ (a:cr ? '<CR>' : '')
"   exe 'noremap <leader>sg'.a:key.
"         \ ' :<C-u>Dag '.a:path.
"         \ (a:cr ? '<CR>' : '')
"   exe 'noremap <leader>su'.a:key.
"         \ ' :<C-u>Dau '.a:path.
"         \ (a:cr ? '<CR>' : '')
"   exe 'noremap <leader>sd'.a:key.
"         \ ' :<C-u>Dgrep '.a:path.
"         \ (a:cr ? '<CR>' : '')
" endfunction

" let paths = {
"       \ '1':'..',
"       \ '2':'../..',
"       \ '3':'../../..',
"       \ '4':'../../../..',
"       \ '5':'../../../../..',
"       \ '6':'../../../../../..',
"       \ '7':'../../../../../../..',
"       \ '8':'../../../../../../../..',
"       \ '9':'../../../../../../../../..',
"       \ 't':'~/Templates',
"       \ 'c':'%',
"       \ 's':['*', './*'],
"       \ 'h':'* .*',
"       \ }

" let expands = {
"       \ 'a':'##',
"       \ }

" for key in keys(paths)
"   call PathMap(key, paths[key])
" endfor
" call PathMap('<Space>', '', 0)

"}}}

" TODO grepadd

"{{{ TODO A

" greps from
" https://codeinthehole.com/tips/vim-lists/#tip-use-mappings-for-faster-browsing

"}}}

"}}}

"{{{ netrw settings
" TODO D

let g:netrw_banner = 0
let g:netrw_menu = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_hide = 0
let g:netrw_keepdir = 1

" ???
let g:netrw_silent = 0
let g:netrw_fastbrowse = 0

" TODO D steering
let g:netrw_winsize = 30
" let g:netrw_winsize = "40%"

let g:netrw_ignorenetrc = 0 " (default for linux, cygwin)
" =1 If you have a <.netrc> file but it doesn't work and
"    you want it ignored, then set this variable as
"    shown. (default for Windows + cmd.exe)

" if this variable exists, then the "gx"
" map will not be available (see |netrw-gx|)
" let g:netrw_nogx = 1

" }}}

"{{{ netrw keymaps

" TODO B file openinng

noremap <silent> <Leader>x;x :Explore<CR>
noremap <Leader>x;X :Explore<Space>
noremap <silent> <Leader>x;t :Texplore<CR>
noremap <Leader>x;T :Texplore<Space>
noremap <silent> <Leader>x;h :Sexplore<CR>
noremap <Leader>x;H :Sexplore<Space>
noremap <silent> <Leader>x;v :Vexplore<CR>
noremap <Leader>x;V :Vexplore<Space>
noremap <silent> <Leader>x;n :Nexplore<CR>
noremap <Leader>x;N :Nexplore<Space>
noremap <silent> <Leader>x;p :Pexplore<CR>
noremap <Leader>x;P :Pexplore<Space>
noremap <silent> <Leader>x;r :Rexplore<CR>
noremap <Leader>x;R :Rexplore<Space>
noremap <silent> <Leader>x;l :Lexplore<CR>
noremap <Leader>x;L :Lexplore<Space>
noremap <silent> <Leader>x;h :Hexplore<CR>
noremap <Leader>x;H :Hexplore<Space>

"}}}
