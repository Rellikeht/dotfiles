"{{{ helpers

function Xcopy(name)
    call system('echo -n '.shellescape(@").' | xclip -i -selection '.a:name)
endfunction

" TODO make this paste using command, not norm
" Or better: get clip to work
function Xpaste(name)
    execute 'normal a'.system('xclip -o -selection '.a:name)
endfunction

command! -nargs=+ Silent
            \   execute 'silent! <args>'
            \   | redraw!

command! We write | sleep 500 m | edit

function GetCompl(name)
    for n in getcompletion('', a:name)
        echo n
    endfor
endfunction

function InsCompl(name)
    for n in getcompletion('', a:name)
        execute 'norm i' . n . ''
    endfor
endfunction

function GetAvailFtypes()
    call GetCompl('filetype')
endfunction

function InsAvailFtypes()
    call InsCompl('filetype')
endfunction

"}}}

"{{{ workman

" Attempt to make vim easier to use
" in workman layout, with preserving
" logic (eg. d for delete, e for end...)

" Mapping motion in workman layout to be more
" 'normal' and cleaning keys messed in the process
" y n e o are h j k l
" and second time
" and h j k l are e y n o

let s:lay='qwe'
function! Wmt()
    if s:lay =~? 'wkm'
        source ~/.vim/qwerty.vim
        let s:lay='qwe'
    else
        source ~/.vim/workman.vim
        let s:lay='wkm'
    endif
endfunction

"}}}

"{{{ hex editing
" TODO C do that better

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&modified
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1

    if !exists('b:editHex') || !b:editHex
        " save old options
        let b:oldft=&filetype
        let b:oldbin=&binary
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        silent :e " this will reload the file without trickeries 
        "(DOS line endings will be shown entirely )
        let &filetype='xxd'
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd

    else
        " restore old options
        let &filetype=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif

    " restore values for modified and read only state
    let &modified=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction

"}}}

"{{{ programming stuff

let g:groff_pdf = 'groff -ktep -T pdf '
function CompileGroffMs()
    if get(b:, "bufcomp", 0)
        " TODO maybe another function or parameter, for expand('%:t:r') ↓
        call system(g:groff_pdf.' -ms '.expand('%').' > '.expand('%:r').'.pdf')
    endif
endfunction

"}}}

"{{{ because vim got some things wrong

" Simple wrapper because vim has working tabp, but
" tabn is retarded and tabp won't work with negative counts
function SwitchTab(count)
    if a:count < 0
        execute 'tabp '.-a:count
    elseif a:count > 0
        execute 'tabn '.((a:count+tabpagenr()-1)%tabpagenr('$')+1)
    endif
endfunction

" from https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

"}}}

"{{{ some automatic stuff

function ToggleBuffer(name)
    execute 'let b:v'.a:name.' = !b:v'.a:name
    if get(b:, 'v'.a:name)
        execute 'setlocal '.a:name
        echo a:name.' enabled'
    else
        execute 'setlocal no'.a:name
        echo a:name.' disabled'
    endif
endfunction

function ToggleAutochdir()
    " let b:autochdir = !b:autochdir
    let g:autochdir = !g:autochdir
    if g:autochdir
        augroup AutoChdir
            autocmd BufEnter * exe "lcd %:p:h"
                        " \ exe "lcd %:p:h" | exe "pwd"
        augroup END
        echo 'AutoChdir enabled'
    else
        augroup! AutoChdir
        echo 'AutoChdir disabled'
    endif
endfunction

" TODO
function ToggleAutoupdate()
    let g:autoupdate = !g:autoupdate
    if g:autoupdate
        set autoread
        augroup FileAutoUpdate
            autocmd CursorHold,CursorHoldI * checktime
            autocmd FocusGained,BufEnter * checktime
        augroup END
        echo 'Autoupdate enabled'
    else
        set noautoread
        augroup! FileAutoUpdate
        echo 'Autoupdate disabled'
    endif
endfunction

"}}}

"{{{ random stuff

function ToggleManProg()
    if &keywordprg == ':help'
        set keywordprg=man
    else
        set keywordprg=:help
    endif
    echo &keywordprg
endfunction

"}}}
