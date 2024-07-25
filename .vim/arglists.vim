"{{{ helpers

function Fpath(file)
    return fnamemodify(resolve(a:file), ':p')
endfunction

function ArglistFiles(alist)
    return map(a:alist, {i, e -> Fpath(e)})
endfunction

"}}}

"{{{ operations

"{{{ create

function MakeArglist(alist, index = 0)
    return [a:index] + ArglistFiles(a:alist)
endfunction

function NewArglist(files, index = 0)
    if type(a:files) == v:t_string
        return MakeArglist(Fpath(a:files), a:index)
    endif
    return MakeArglist(a:files, a:index)
endfunction

"}}}

"{{{ modify state

function ApplyArglist(list)
    let idx = a:list[0]
    let list = a:list[1:]
    exe 'arglocal! '.join(ArglistFiles(list), ' ')
    exe 'argument '.(idx+1)
endfunction

function UpdateArglist()
    let fname = Fpath(expand('%'))
    if index(w:arglists[w:cur_arglist][1:], fname) >= 0
        let w:arglists[w:cur_arglist] = NewArglist(argv(), argidx())
    endif
    let w:arglists[w:cur_arglist] = 
                \ NewArglist(argv(), w:arglists[w:cur_arglist][0])
endfunction

function NextArglist()
    call UpdateArglist()
    let w:cur_arglist = w:cur_arglist + 1
    if w:cur_arglist >= len(w:arglists)
        let w:cur_arglist = 0
    endif
    call ApplyArglist(w:arglists[w:cur_arglist])
endfunction

"}}}

"{{{ add

function AddList(list)
    let w:arglists = add(w:arglists, a:list)
endfunction

function AddArglist(alist, index)
    call AddList(MakeArglist(a:alist, a:index))
endfunction

function AddArgs(...)
    let list = []
    for arg in a:000
        let list = add(list, Fpath(fnameescape(arg)))
    endfor
    call AddArglist(list, 0)
    let w:cur_arglist = len(w:arglists)-1
    call ApplyArglist(w:arglists[w:cur_arglist])
endfunction

"}}}

"{{{ info

function ArglistShort(list)
    return '['.a:list[0].']: '.
                \ pathshorten(a:list[1], g:pathshorten).
                \ (len(a:list) > 2 ? ', ...' : '')
endfunction

function ListArglists()
    call UpdateArglist()
    let lst = ""
    for l in w:arglists
        let lst = lst.ArglistShort(l)."\n"
    endfor
    return lst[:len(lst)-2]
endfunction

function ArglistInfo()
    call UpdateArglist()
    let lst = ArglistShort(w:arglists[w:cur_arglist]).":\n\n"
    let i = 0
    for f in w:arglists[w:cur_arglist][1:]
        if i == argidx()
            let lst = lst."[".pathshorten(f, g:pathshorten)."]\n"
        else
            let lst = lst.pathshorten(f, g:pathshorten)."\n"
        endif
        let i = i+1
    endfor
    return lst[:len(lst)-2]
endfunction

" TODO
function CompleteArglist()
    call UpdateArglist()
endfunction

"}}}

"{{{ delete

function DeleteArglist(index)
    call remove(w:arglists, a:index)
endfunction

function DeleteCurArglist()
    let idx = w:cur_arglist
    call NextArglist()
    call remove(w:arglists, idx)
endfunction

" TODO is this doable at all
function PurgeArglist(index)
    for f in w:arglists[index][1:]
        exe 'bdelete '.f
    endfor
    call DeleteArglist(index)
endfunction

" }}}

"}}}

"{{{ setup

autocmd WinNew,VimEnter *
            \ let w:arglists = []
            \ | call AddArglist(argv(), argidx())
            \ | let w:cur_arglist = 0

"}}}

"{{{ commands

command -nargs=+ -complete=file AddList
            \ call AddArgs(<f-args>)

command -nargs=0 ListArglists echo ListArglists()
command -nargs=0 ArglistInfo echo ArglistInfo()

" TODO
command -nargs=1 -complete=customlist,CompleteArglist()
            \ OpenArglist

" TODO something more
command -nargs=0 DelArglist
            \ call DelArglist()

" TODO D will be painfully tough
" command ArglistsDo

"}}}

"{{{ maps

" ???
map <Leader><Space>o :<C-u>AddList<Space>
map <Leader><Space>e :<C-u>OpenArglist<Space>
map <Leader><Space>l :<C-u>ListArglists<CR>
map <Leader><Space>i :<C-u>ArglistInfo<CR>

" TODO
map <silent> <Leader><Space>a :<C-u>call AddArglist()<CR>
map <Leader><Space>d :<C-u>DelArglist<CR>
map <silent> Leader><Space>+ :<C-u>call AddList(NewArglist(''))<CR>

map <Leader><Space>n :<C-u>call NextArglist(v:count1)<CR>
map <Leader><Space>p :<C-u>call NextArglist(-v:count1)<CR>

" TODO D
" map <Leader><Space>: :<C-u>ArglistsDo<Space>

"}}}
