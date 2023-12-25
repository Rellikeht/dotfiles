function Xcopy(name)
    call system('echo -n '.shellescape(@").' | xclip -i -selection '.a:name)
endfunction

" TODO make this paste using command, not norm
" Or better: get clip to work
function Xpaste(name)
    execute 'normal a'.system('xclip -o -selection '.a:name)
endfunction

command! -nargs=+ Silent
            \	execute 'silent <args>'
            \	| redraw!

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

" TODO C do that better

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1

    if !exists('b:editHex') || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        silent :e " this will reload the file without trickeries 
        "(DOS line endings will be shown entirely )
        let &ft='xxd'
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd

    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif

    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction

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

function ToggleManProg()
    if &keywordprg == ':help'
        set keywordprg=man
    else
        set keywordprg=:help
    endif
    echo &keywordprg
endfunction

function NixFmt()
    " Everything hardcoded, because vim goes crazy when using
    " variables and can't be or is very hard to get synchronous
    if executable('alejandra') && b:buffmt
        let pos = getpos('.')
        0,$!alejandra -qq
        call setpos('.', pos)
    endif
endfunction

let g:groff_pdf = 'groff -ktep -T pdf '
function CompileGroffMs()
    if b:bufcomp
        " TODO maybe another function or parameter, for expand('%:t:r') ↓
        call system(g:groff_pdf.' -ms '.expand('%').' > '.expand('%:r').'.pdf')
    endif
endfunction

function GeneralUpgrade()
    PlugUpgrade
    PlugUpdate --sync
endfunction
