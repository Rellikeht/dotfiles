"{{{ helpers

function VNmap(map, key, cmd, end = "")
    if a:end == ""
        exe 'n'.a:map.' '.a:key.' '.a:cmd.'<CR>'
        exe 'v'.a:map.' '.a:key.' '.a:cmd.' \| normal gv<CR>'
    else
        exe 'n'.a:map.' '.a:key.' '.a:cmd.a:end
        exe 'v'.a:map.' '.a:key.' '.a:cmd.
                    \ ' \| normal gv'
                    \ '<C-Left><C-Left><C-left><Left>'.a:end
    endif
endfunction

"}}}

"{{{ clipboard

function Xcopy(name)
    call system('echo -n '.shellescape(@").' | xclip -i -selection '.a:name)
endfunction

" TODO make this paste using command, not norm
" Or better: get clip to work
function Xpaste(name)
    execute 'normal a'.system('xclip -o -selection '.a:name)
endfunction

"}}}

"{{{ commands

command! We write | sleep 500 m | edit

"}}}

"{{{ completion

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

"{{{ quickfix

function! QFtype()
    " Get dictionary of properties of the current window
    let wininfo = filter(getwininfo(), {i,v -> v.winnr == winnr()})[0]
    return wininfo.loclist
endfunction

function! WQFsel(ccmd, lcmd, before = '', after = '')
    execute a:before . (QFtype() ? a:lcmd : a:ccmd) . a:after
endfunction

function! WQFcmd(cmd, before = '')
    call WQFsel('c', 'l', a:before, a:cmd)
endfunction

function! QFsel(ccmd, lcmd, before = '', after = '')
    execute a:before . (g:qfloc ? a:lcmd : a:ccmd) . a:after
endfunction

function! QFcmd(cmd, before = '')
    call QFsel('c', 'l', a:before, a:cmd)
endfunction

function! NToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        call QFcmd("open '.g:qfheight", "exe '")
        wincmd p
    else
        call QFcmd('close')
    endif
endfunction

function! VToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        call QFcmd("open '.g:qfheight", "exe '")
        wincmd p
    else
        call QFcmd('close')
    endif
    normal gv
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
" TODO confirmation / information 
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

"{{{ proper tabp

" Simple wrapper because vim has working tabp, but
" tabn is retarded and tabp won't work with negative counts
function SwitchTab(count)
    if a:count < 0
        execute 'tabp '.-a:count
    elseif a:count > 0
        execute 'tabn '.((a:count+tabpagenr()-1)%tabpagenr('$')+1)
    endif
endfunction

"}}}

"{{{ https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript

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

"{{{ Because :next, :prev and similar don't wrap around

" Simplest implementation, hopefully
" won't be too slow
function! WithoutCommonSubstring(first, second)
    for i in range(strlen(a:first))
        if i >= strlen(a:second) || a:first[i] != a:second[i]
            return a:first[i:]
        endif
    endfor
    return ''
endfun

" Path cur relative to path rel
function RelPath(cur, rel)
    let pardirs = WithoutCommonSubstring(
                \ a:rel,
                \ a:cur.'/'
                \ )
    let parpat = '\([^/]\+\)'
    let subst = substitute(pardirs, parpat , '..', 'g')
    let relpath = WithoutCommonSubstring(a:cur, a:rel.'/')
    if subst =~ '[^/]$' && parpat[0] != '/'
        let subst = subst.'/'
    endif
    return (pardirs == '' ? '' : subst).
                \ pathshorten(relpath, g:pathshorten)
endfunction

" Path of current file relative to previously visited dir
" (set by autocmd on bufenter)
function RelCurFile()
    let relpath = RelPath(expand('%:p:h'), w:prev_dir)
    if relpath != '' && relpath =~ '[^/]$'
        let relpath = relpath.'/'
    endif
    let relpath = relpath.expand('%:t')
    if filereadable(expand('%:p'))
        return relpath
    endif
    return '{{{ '.relpath.' }}}'
endfunction

function NextArg(pos, cmd, before = '', after = '')
    if a:pos
        let ind = ((argidx()+v:count1)%argc()+1)
    else
        let ind = ((argc()+argidx()-v:count1)%argc()+1)
    endif
    if a:before != ''
        exe 'silent! '.a:before
    endif
    exe 'silent! '.a:cmd.' '.ind
    if a:after != ''
        exe 'silent! '.a:after
    endif
    echo RelCurFile()
endfunction

"}}}

"{{{ Delete buffer while keeping window layout (don't close buffer's windows).

"here is a more exotic version of my original Kwbd script
"delete the buffer; keep windows; create a scratch buffer if no buffers left
function s:Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(&modified)
      let answer = confirm("This buffer has been modified.  Are you sure you want to delete it?", "&Yes\n&No", 2)
      if(answer != 1)
        return
      endif
    endif
    if(!buflisted(winbufnr(0)))
      bd!
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call s:Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction

command! Kwbd call s:Kwbd(1)
nnoremap <silent> <Plug>Kwbd :<C-u>Kwbd<CR>

"}}}

"}}}

"{{{ toggling

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
    let g:autochdir = !g:autochdir
    if g:autochdir
        augroup AutoChdir
            autocmd BufLeave *
                        \ if &buftype == '' && isdirectory(expand('%:p:h'))
                        \ | let w:prev_dir = expand('%:p:h')
                        \ | endif
            autocmd BufEnter *
                        \ if &buftype == '' && isdirectory(expand('%:p:h'))
                        \ | exe 'lcd %:p:h'
                        \ | endif
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
