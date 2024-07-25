"{{{ helpers

function Fpath(file)
    return fnameescape(fnamemodify(resolve(a:file), ':p'))
endfunction

function ArglistFiles(alist)
    return map(a:alist, {i, e -> Fpath(e)})
endfunction

"}}}

"{{{ operations

function ApplyArglist(list)
    let idx = a:list[0]
    let list = a:list[1:]
    exe 'arglocal! '.join(ArglistFiles(list) ' ')
    exe 'argument '.(argidx()+1)
endfunction

function AddList(list)
    let w:arglists = add(w:arglists, a:list)
endfunction

function MakeArglist(alist, index)
    return [a:index] + ArglistFiles(a:alist)
endfunction

function AddArglist(alist, index)
    call AddList(MakeArglist(a:alist, a:index))
endfunction

function NextArglist()
    let w:cur_arglist = w:cur_arglist + 1
    if w:cur_arglist >= len(w:arglists)
        let w:cur_arglist = 0
    endif
    call ApplyArglist(w:arglists[w:cur_arglist])
endfunction

function ListArglists()
    echo join(map(w:arglists, {i, e ->
                \ '['.e[0].']: '.pathshorten(e[1], g:pathshorten).
                \ (len(e) > 2 ? ', ...' : '')
                \ }), "\n")
endfunction

function NewArglist(files)
    if type(a:files) == v:t_list
        return [0, Fpath(a:files)]
    endif
    return [0] + map(a:files, {i, e -> Fpath(e)})]
endfunction

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

" TODO
function CompleteArglist()
endfunction

"}}}

"{{{ setup

autocmd WinNew,VimEnter *
            \ let w:arglists = []
            \ | call AddArglist(argv(), argidx())
            \ | let w:cur_arglist = 0

"}}}

"{{{ commands

" TODO
command -nargs=1 -complete=customlist,CompleteArglist()
            \ OpenArglist

" TODO something more
command -nargs=0 DelArglist
            \ call DelArglist()

command -nargs=0 ListArglists call ListArglists()

" TODO D will be painfully tough
" command ArglistsDo

"}}}

"{{{ maps

" ???
" map <Leader><Space>o :<C-u><CR>
map <silent> <Leader><Space>o :<C-u>call AddList(NewArglist(expand('%')))<CR>
" map <Leader><Space>o :<C-u>call NewArglist()<CR>
map <Leader><Space>e :<C-u>OpenArglist<Space>
map <Leader><Space>l :<C-u>ListArglists<CR>

map <silent> <Leader><Space>a :<C-u>call AddArglist()<CR>
map <Leader><Space>d :<C-u>DelArglist<CR>
map <silent> Leader><Space>+ :<C-u>call AddList(NewArglist(''))<CR>

map <Leader><Space>n :<C-u>call NextArglist(v:count1)<CR>
map <Leader><Space>p :<C-u>call NextArglist(-v:count1)<CR>

" TODO D
" map <Leader><Space>: :<C-u>ArglistsDo<Space>

"}}}
