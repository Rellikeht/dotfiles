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

noremap <silent> <leader>fpf :<C-u>call DiffPut(expand('%:p'))<CR>
noremap <silent> <leader>fp;f :<C-u>call DiffPut(expand('%:t'))<CR>
noremap <silent> <leader>fgf :<C-u>call DiffGet(expand('%:p'))<CR>
noremap <silent> <leader>fg;f :<C-u>call DiffGet(expand('%:t'))<CR>

"}}}

"{{{ drag and drop

" TODO C more ?

" Pushing to dragon
nnoremap <silent> <Leader>xy
            \ :<C-u>exe '!dragon --on-top --and-exit '.
            \ expand("%").' 2>/dev/null &'<CR>
            \ :redraw!<CR>
vnoremap <silent> <Leader>xy
            \ :<C-u>exe '!dragon --on-top --and-exit '.
            \ expand("%").' 2>/dev/null &'<CR>
            \ :redraw!<CR>
            \ :norm gv<CR>

nnoremap <silent> <Leader>xY
            \ :<C-u>exe '!dragon --on-top --and-exit '.
            \ expand("<cfile>").' 2>/dev/null &'<CR>
            \ :redraw!<CR>
vnoremap <silent> <Leader>xY
            \ :<C-u>exe '!dragon --on-top --and-exit '.
            \ expand("<cfile>").' 2>/dev/null &'<CR>
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
" TODO more programs and settings
" TODO maybe even quickfix list to select

let g:ripgrep = 0
set grepprg=grep\ -EIn\ $*\ /dev/null

function ToggleRG()
    let g:ripgrep = !g:ripgrep
    if g:ripgrep
        set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
        set grepformat=%f:%l:%c:%m
        echo "Ripgrep on"
    else
        set grepprg=grep\ -EIn\ $*\ /dev/null
        set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
        echo "Ripgrep off"
    endif
endfunction

nnoremap <Leader>xlt :<C-u>call ToggleRG()<CR>
vnoremap <Leader>xlt :<C-u>call ToggleRG()\|norm gv<CR>

"}}}

" TODO C more visual mappings

"{{{ external

noremap <expr> <Leader>xl<Space> g:qfloc ?
            \ ':<C-u>lgrep<Space>'
            \ : ':<C-u>grep<Space>'
nnoremap <expr> <Leader>xlw g:qfloc ? 
            \ ':<C-u>lgrep <cword> . <CR>'
            \ : ':<C-u>grep <cword> . <CR>'
vnoremap <expr> <Leader>xlw g:qfloc ? 
            \ ":<C-u>exe 'lgrep '.GetVisualSelection().' .'<CR>\|norm gv"
            \ : ":<C-u>exe 'grep '.GetVisualSelection().' .'<CR>\|norm gv"

nnoremap <expr> <Leader>xl. g:qfloc ?
            \ ':<C-u>'.v:count1.'lgrep<Space>'
            \ : ':<C-u>'.v:count1.'grep<Space>'
noremap <expr> <Leader>xl<Space> g:qfloc ?
            \ ':<C-u>lgrep<Space>'
            \ : ':<C-u>grep<Space>'

noremap <expr> <Leader>xlf g:qfloc ?
            \ ':<C-u>'.v:count1.
            \ 'lgrep  %<Left><Left>'
            \ : ':<C-u>'.v:count1.
            \ 'lgrep  %<Left><Left>'

nnoremap <expr> <Leader>xll g:qfloc ? 
            \ ':<C-u>lgrep '.expand('<cword>').' ## <CR>'
            \ : ':<C-u>grep '.expand('<cword>').' ## <CR>'
vnoremap <expr> <Leader>xll g:qfloc ? 
            \ ':<C-u>lgrep '.GetVisualSelection().' ## \| norm gv<CR>'
            \ : ':<C-u>grep '.GetVisualSelection().' ## \| norm gv<CR>'
nnoremap <expr> <Leader>xlL g:qfloc ? 
            \ ':<C-u>lgrep '.expand('<cword>').' ## <CR>'
            \ : ':<C-u>grep '.expand('<cword>').' ## <CR>'
vnoremap <expr> <Leader>xlL g:qfloc ? 
            \ ':<C-u>lgrep '.GetVisualSelection().' ## \| norm gv<CR>'
            \ : ':<C-u>grep '.GetVisualSelection().' ## \| norm gv<CR>'

nnoremap <expr> <Leader>xla g:qfloc ? 
            \ ':<C-u>lgrep '.expand('<cword>').' * <CR>'
            \ : ':<C-u>grep '.expand('<cword>').' * <CR>'
vnoremap <expr> <Leader>xla g:qfloc ? 
            \ ':<C-u>lgrep '.GetVisualSelection().' * \| norm gv<CR>'
            \ : ':<C-u>grep '.GetVisualSelection().' * \| norm gv<CR>'
nnoremap <expr> <Leader>xlA g:qfloc ? 
            \ ':<C-u>lgrep '.expand('<cword>').' * <CR>'
            \ : ':<C-u>grep '.expand('<cword>').' * <CR>'
vnoremap <expr> <Leader>xlA g:qfloc ? 
            \ ':<C-u>lgrep '.GetVisualSelection().' * \| norm gv<CR>'
            \ : ':<C-u>grep '.GetVisualSelection().' * \| norm gv<CR>'

nnoremap <expr> <Leader>xlr g:qfloc ? 
            \ ':<C-u>lgrep '.expand('<cword>').' **/* <CR>'
            \ : ':<C-u>grep '.expand('<cword>').' **/* <CR>'
vnoremap <expr> <Leader>xlr g:qfloc ? 
            \ ':<C-u>lgrep '.GetVisualSelection().' **/* \| norm gv<CR>'
            \ : ':<C-u>grep '.GetVisualSelection().' **/* \| norm gv<CR>'
nnoremap <expr> <Leader>xlR g:qfloc ? 
            \ ':<C-u>lgrep '.expand('<cword>').' **/* <CR>'
            \ : ':<C-u>grep '.expand('<cword>').' **/* <CR>'
vnoremap <expr> <Leader>xlR g:qfloc ? 
            \ ':<C-u>lgrep '.GetVisualSelection().' **/* \| norm gv<CR>'
            \ : ':<C-u>grep '.GetVisualSelection().' **/* \| norm gv<CR>'

nnoremap <expr> <Leader>xl<Space>a g:qfloc ? 
            \ ':<C-u>lgrep  *<C-Left><Left>'
            \ : ':<C-u>grep  *<C-Left><Left>'
nnoremap <expr> <Leader>xl<Space>r g:qfloc ? 
            \ ':<C-u>lgrep  **/*<C-Left><Left>'
            \ : ':<C-u>grep  **/*<C-Left><Left>'
nnoremap <expr> <Leader>xl<Space>l g:qfloc ? 
            \ ':<C-u>lgrep  ##<C-Left><Left>'
            \ : ':<C-u>grep  ##<C-Left><Left>'

"}}}

"{{{ vimgrep

nnoremap <expr> <Leader>x/. g:qfloc ?
            \ ':<C-u>'.v:count1.'lvimgrep<Space>'
            \ : ':<C-u>'.v:count1.'vimgrep<Space>'

nnoremap <expr> <Leader>x/r g:qfloc ? 
            \ ':<C-u>lvimgrep /'.expand('<cword>').'/gj **/* <CR>'
            \ : ':<C-u>vimgrep /'.expand('<cword>').'/gj **/* <CR>'
vnoremap <expr> <Leader>x/r g:qfloc ? 
            \ ':<C-u>lvimgrep /'.GetVisualSelection().'/gj **/* \| norm gv<CR>'
            \ : ':<C-u>vimgrep /'.GetVisualSelection().'/gj **/* \| norm gv<CR>'
nnoremap <expr> <Leader>x/R g:qfloc ? 
            \ ':<C-u>lvimgrep /'.expand('<cword>').'/fgj **/* <CR>'
            \ : ':<C-u>vimgrep /'.expand('<cword>').'/fgj **/* <CR>'
vnoremap <expr> <Leader>x/R g:qfloc ? 
            \ ':<C-u>lvimgrep /'.GetVisualSelection().'/fgj **/* \| norm gv<CR>'
            \ : ':<C-u>vimgrep /'.GetVisualSelection().'/fgj **/* \| norm gv<CR>'

nnoremap <expr> <Leader>x/a g:qfloc ? 
            \ ':<C-u>lvimgrep /'.expand('<cword>').'/gj * <CR>'
            \ : ':<C-u>vimgrep /'.expand('<cword>').'/gj * <CR>'
vnoremap <expr> <Leader>x/a g:qfloc ? 
            \ ':<C-u>lvimgrep /'.GetVisualSelection().'/gj * \| norm gv<CR>'
            \ : ':<C-u>vimgrep /'.GetVisualSelection().'/gj * \| norm gv<CR>'
nnoremap <expr> <Leader>x/A g:qfloc ? 
            \ ':<C-u>lvimgrep /'.expand('<cword>').'/fgj * <CR>'
            \ : ':<C-u>vimgrep /'.expand('<cword>').'/fgj * <CR>'
vnoremap <expr> <Leader>x/A g:qfloc ? 
            \ ':<C-u>lvimgrep /'.GetVisualSelection().'/fgj * \| norm gv<CR>'
            \ : ':<C-u>vimgrep /'.GetVisualSelection().'/fgj * \| norm gv<CR>'

nnoremap <expr> <Leader>x/l g:qfloc ? 
            \ ':<C-u>lvimgrep /'.expand('<cword>').'/gj ## <CR>'
            \ : ':<C-u>vimgrep /'.expand('<cword>').'/gj ## <CR>'
vnoremap <expr> <Leader>x/l g:qfloc ? 
            \ ':<C-u>lvimgrep /'.GetVisualSelection().'/gj ## \| norm gv<CR>'
            \ : ':<C-u>vimgrep /'.GetVisualSelection().'/gj ## \| norm gv<CR>'
nnoremap <expr> <Leader>x/L g:qfloc ? 
            \ ':<C-u>lvimgrep /'.expand('<cword>').'/fgj ## <CR>'
            \ : ':<C-u>vimgrep /'.expand('<cword>').'/fgj ## <CR>'
vnoremap <expr> <Leader>x/L g:qfloc ? 
            \ ':<C-u>lvimgrep /'.GetVisualSelection().'/fgj ## \| norm gv<CR>'
            \ : ':<C-u>vimgrep /'.GetVisualSelection().'/fgj ## \| norm gv<CR>'

nnoremap <expr> <Leader>x/<Space>a g:qfloc ? 
            \ ':<C-u>lvimgrep //gj *<C-Left><C-Left><Right>'
            \ : ':<C-u>vimgrep //gj *<C-Left><C-Left><Right>'
nnoremap <expr> <Leader>x/<Space>r g:qfloc ? 
            \ ':<C-u>lvimgrep //gj **/*<C-Left><C-Left><Right>'
            \ : ':<C-u>vimgrep //gj **/*<C-Left><C-Left><Right>'
nnoremap <expr> <Leader>x/<Space>l g:qfloc ? 
            \ ':<C-u>lvimgrep //gj ##<C-Left><C-Left><Right>'
            \ : ':<C-u>vimgrep //gj ##<C-Left><C-Left><Right>'

nnoremap <expr> <Leader>x/<Space>A g:qfloc ? 
            \ ':<C-u>lvimgrep //fgj *<C-Left><C-Left><Right>'
            \ : ':<C-u>vimgrep //fgj *<C-Left><C-Left><Right>'
nnoremap <expr> <Leader>x/<Space>R g:qfloc ? 
            \ ':<C-u>lvimgrep //fgj **/*<C-Left><C-Left><Right>'
            \ : ':<C-u>vimgrep //fgj **/*<C-Left><C-Left><Right>'
nnoremap <expr> <Leader>x/<Space>L g:qfloc ? 
            \ ':<C-u>lvimgrep //fgj ##<C-Left><C-Left><Right>'
            \ : ':<C-u>vimgrep //fgj ##<C-Left><C-Left><Right>'

nnoremap <expr> <Leader>x/c g:qfloc ?
            \ ':<C-u>lvimgrep //jg<C-left><Right>'
            \ : ':<C-u>vimgrep //jg<C-left><Right>'
nnoremap <expr> <Leader>x/C g:qfloc ?
            \ ':<C-u>lvimgrep //fjg<C-left><Right>'
            \ : ':<C-u>vimgrep //fjg<C-left><Right>'

noremap <expr> <Leader>x/f g:qfloc ?
            \ ':<C-u>'.v:count1.
            \ 'lvimgrep //g %<C-Left><C-Left><Right>'
            \ : ':<C-u>'.v:count1.
            \ 'vimgrep //g %<C-Left><C-Left><Right>'
noremap <expr> <Leader>x/F g:qfloc ?
            \ ':<C-u>lvimgrep //g %<C-Left><C-Left><Right>'
            \ : ':<C-u>vimgrep //g %<C-Left><C-Left><Right>'

"}}}

"{{{ TODO A

" greps from
" https://codeinthehole.com/tips/vim-lists/#tip-use-mappings-for-faster-browsing

"}}}

"}}}

"{{{ netrw settings
" TODO C

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

"{{{ netrw network things

" TODO D ftp

" TODO D
 " *g:netrw_preview*    =0 (default) preview window shown in a horizontally
               " split window
            " =1 preview window shown in a vertically split window.
               " Also affects the "previous window" (see |netrw-P|)
               " in the same way.
            " The |g:netrw_alto| variable may be used to provide
            " additional splitting control:
                " g:netrw_preview g:netrw_alto result
                         " 0             0     |:aboveleft|
                         " 0             1     |:belowright|
                         " 1             0     |:topleft|
                         " 1             1     |:botright|
            " To control sizing, see |g:netrw_winsize|

"  *g:netrw_scpport*    = "-P" : option to use to set port for scp
"  *g:netrw_sshport*    = "-p" : option to use to set port for ssh

"   *g:netrw_silent*    =0 : transfers done normally
"           =1 : transfers done silently

"  *g:netrw_use_errorwindow* =2: messages from netrw will use a popup window
"                Move the mouse and pause to remove the popup window.
"                (default value if popup windows are available)
"            =1 : messages from netrw will use a separate one
"                 line window.  This window provides reliable
"                 delivery of messages.
"                (default value if popup windows are not available)
"            =0 : messages from netrw will use echoerr ;
"                 messages don't always seem to show up this
"                 way, but one doesn't have to quit the window.

"}}}
