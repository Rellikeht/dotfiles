"{{{ undo tree / undo branches
" TODO
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

noremap <silent> ,xex :Explore<CR>
noremap ,xeX :Explore<Space>
noremap <silent> ,xet :Texplore<CR>
noremap ,xeT :Texplore<Space>
noremap <silent> ,xeh :Sexplore<CR>
noremap ,xeH :Sexplore<Space>
noremap <silent> ,xev :Vexplore<CR>
noremap ,xeV :Vexplore<Space>
noremap <silent> ,xen :Nexplore<CR>
noremap ,xeN :Nexplore<Space>
noremap <silent> ,xep :Pexplore<CR>
noremap ,xeP :Pexplore<Space>
noremap <silent> ,xer :Rexplore<CR>
noremap ,xeR :Rexplore<Space>
noremap <silent> ,xel :Lexplore<CR>
noremap ,xeL :Lexplore<Space>
noremap <silent> ,xeh :Hexplore<CR>
noremap ,xeH :Hexplore<Space>

"}}}

"{{{ netrw network

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

"{{{ diff

function DiffGet(pane)
    execute 'diffget' a:pane
    diffupdate
endfunction

function DiffPut(pane)
    execute 'diffget' a:pane
    diffupdate
endfunction

nnoremap <silent> <leader>fdp :diffput<CR>
nnoremap <silent> <leader>fdg :diffget<CR>
nnoremap <silent> <leader>fdu :diffupdate<CR>

" TODO more of that
nnoremap <silent> <leader>fg0 :call DiffGet('//0')<CR>
nnoremap <silent> <leader>fg1 :call DiffGet('//1')<CR>
nnoremap <silent> <leader>fg2 :call DiffGet('//2')<CR>
nnoremap <silent> <leader>fg3 :call DiffGet('//3')<CR>

nnoremap <silent> <leader>fp0 :call DiffPut('//0')<CR>
nnoremap <silent> <leader>fp1 :call DiffPut('//1')<CR>
nnoremap <silent> <leader>fp2 :call DiffPut('//2')<CR>
nnoremap <silent> <leader>fp3 :call DiffPut('//3')<CR>

nnoremap <silent> <leader>fpf :call DiffPut(expand('%:p'))<CR>
nnoremap <silent> <leader>fpF :call DiffPut(expand('%:t'))<CR>
nnoremap <silent> <leader>fgf :call DiffGet(expand('%:p'))<CR>
nnoremap <silent> <leader>fgF :call DiffGet(expand('%:t'))<CR>

"}}}
