" {{{ operations

" {{{ helpers

function Fpath(file)
  if FileOrDir(a:file) 
    return fnamemodify(resolve(a:file), ':p')
  endif
  return a:file
endfunction

function s:ArglistFiles(alist)
  return map(a:alist, {_, e -> Fpath(e)})
endfunction

function s:ListNumFromRepr(repr)
  let npart = split(a:repr, ':')[0]
  if a:repr =~ '^[0-9]\+$'
    let num = str2nr(a:repr)
  elseif npart =~ '^[0-9]\+$'
    let num = str2nr(npart)
  else
    throw 'Given index of arglist list is not a number'
  endif
  if num < 0 || num >= len(w:arglists)
    throw 'Invalid index of arglist list'
  endif
  return num
endfunction

" }}}

" {{{ create

function s:MakeArglist(alist, index = 0)
  return [a:index] + s:ArglistFiles(a:alist)
endfunction

function s:NewArglist(files, index = 0)
  if type(a:files) == v:t_string
    return s:MakeArglist([Fpath(a:files)], a:index)
  endif
  return s:MakeArglist(a:files, a:index)
endfunction

" }}}

" {{{ modify state

function s:ApplyArglist(list)
  let idx = a:list[0]
  let list = a:list[1:]
  if len(list) == 0
    let g:no_file_msg = 1
    exe 'arglocal! %'
    let g:no_file_msg = 0
    exe 'argdelete'
    enew
    return ''
  endif
  exe 'arglocal! '.join(map(
        \ s:ArglistFiles(list),
        \ {_, e -> fnameescape(e)}),
        \ ' ')
  exe 'argument '.(idx+1)
  return ''
endfunction

function s:UpdateArglist()
  let fpath = Fpath(expand('%'))
  if index(w:arglists[w:cur_arglist][1:], fpath) >= 0
    let w:arglists[w:cur_arglist] =
          \ s:NewArglist(argv(), argidx())
  else
    let w:arglists[w:cur_arglist] = 
          \ s:NewArglist(argv(), w:arglists[w:cur_arglist][0])
  endif
endfunction

function s:NextArglist(amount = 1)
  call s:UpdateArglist()
  let w:cur_arglist = w:cur_arglist + a:amount
  if w:cur_arglist >= len(w:arglists)
    let w:cur_arglist = 0
  endif
  call s:ApplyArglist(w:arglists[w:cur_arglist])
endfunction

function s:SelectArglist(repr)
  let w:cur_arglist = s:ListNumFromRepr(a:repr)
  call s:ApplyArglist(w:arglists[w:cur_arglist])
endfunction

" }}}

" {{{ add

function s:AddList(list)
  let w:arglists = add(w:arglists, a:list)
endfunction

function s:AddArglist(alist, index)
  call s:AddList(s:MakeArglist(a:alist, a:index))
endfunction

function s:AddArgs(...)
  let list = []
  for arg in a:000
    let list = add(list, Fpath(arg))
  endfor
  call s:AddArglist(list, 0)
  let w:cur_arglist = len(w:arglists)-1
  call s:ApplyArglist(w:arglists[w:cur_arglist])
endfunction

" }}}

" {{{ completion

function s:ArglistComp(list, idx)
  if len(a:list) <= 1
    return "[]"
  endif
  return a:idx.': ('.(a:list[0]+1).'/'.(len(a:list)-1).') - '.
        \ pathshorten(RelFile(a:list[1],
        \ fnamemodify(Dexpand('%'), ':h')), 2).
        \ (len(a:list) > 2 ? ', ...' : ' -')
endfunction

function s:CompleteArglist(lead, cmdline, curpos)
  call s:UpdateArglist()
  if a:lead == '...' || a:lead == '-'
    return []
  endif
  let arglists = []
  let i = 0
  for e in w:arglists
    let argrep = s:ArglistComp(e, i)
    if argrep =~ '^'.a:lead
      let arglists = add(arglists, argrep)
    endif
    let i = i+1
  endfor
  return arglists
endfunction

" }}}

" {{{ info

function s:ArglistShort(list)
  if len(a:list) <= 1
    return "[]"
  endif
  return '['.(a:list[0]+1).'/'.(len(a:list)-1).']: '.
        \ pathshorten(RelFile(a:list[1], w:prev_dir), g:pathshorten).
        \ (len(a:list) > 2 ? ', ...' : '')
        " \ pathshorten(a:list[1], g:pathshorten).
endfunction

function s:ListArglists()
  call s:UpdateArglist()
  let lst = ""
  let i = 1
  for l in w:arglists
    let lst = lst.i
    if i == w:cur_arglist
      let lst = lst.'*'
    else
      let lst = lst.' '
    endif
    let lst = lst.' '.s:ArglistShort(l)."\n"
    let i = i+1
  endfor
  return lst[:len(lst)-2]
endfunction

function s:ArglistInfo()
  call s:UpdateArglist()
  let lst = s:ArglistComp(w:arglists[w:cur_arglist], w:cur_arglist).":\n\n"
  let i = 0
  let cpath = expand('%:p:h')
  for f in w:arglists[w:cur_arglist][1:]
    if i == argidx()
      let lst = lst."[".pathshorten(
            \ RelFile(f, cpath),
            \ g:pathshorten)."]\n"
    else
      let lst = lst.pathshorten(
            \ RelFile(f, cpath),
            \ g:pathshorten)."\n"
    endif
    let i = i+1
  endfor
  return lst[:len(lst)-2]
endfunction

" }}}

" {{{ delete

function s:DeleteArglist(index)
  call remove(w:arglists, a:index)
endfunction

function s:DeleteCurArglist()
  let idx = w:cur_arglist
  call s:NextArglist()
  call remove(w:arglists, idx)
endfunction

function s:DelArglist(repr)
  let arg = s:ListNumFromRepr(a:repr)
  if arg == w:cur_arglist
    if len(w:arglists) == 1
      arglocal!
    else
      call s:NextArglist()
      if w:cur_arglist >= arg
        let w:cur_arglist = w:cur_arglist - 1
      endif
    endif
  endif
  call remove(w:arglists, arg)
endfunction

" TODO C is this doable at all
function s:PurgeArglist(index)
  for f in w:arglists[index][1:]
    exe 'bdelete '.f
  endfor
  call s:DeleteArglist(index)
endfunction

" }}}

" }}}

" {{{ setup

autocmd WinNew,VimEnter *
      \ let w:arglists = []
      \ | call <SID>AddArglist(argv(), argidx())
      \ | let w:cur_arglist = 0

" }}}

" {{{ commands

command -nargs=0 ListArglists echo <SID>ListArglists()
command -nargs=0 ArglistInfo echo <SID>ArglistInfo()
command -nargs=+ -complete=file OpenArglist
      \ call <SID>AddArgs(<f-args>)
command -nargs=1 -complete=customlist,<SID>CompleteArglist
      \ SelectArglist
      \ call <SID>SelectArglist(<f-args>)

command -nargs=* -complete=file AddArglist
      \ call <SID>AddArgs(<f-args>)
command -nargs=1 -complete=customlist,<SID>CompleteArglist
      \ DelArglist
      \ call <SID>DelArglist(<f-args>)

" TODO D will be painfully tough
" command ArglistsDo

" }}}

" {{{ maps

map <Leader><Space>o :<C-u>OpenArglist<Space>
map <Leader><Space>e :<C-u>SelectArglist<Space>
map <Leader><Space>l :<C-u>ListArglists<CR>
map <Leader><Space>i :<C-u>ArglistInfo<CR>

map <Leader><Space>a :<C-u>AddArglist<Space>
map <silent> <Leader><Space>A :<C-u>call <SID>AddList(<SID>NewArglist([]))<CR>
map <Leader><Space>d :<C-u>DelArglist<Space>
map <silent> <Leader><Space>D :<C-u>exe 'DelArglist '.w:cur_arglist.':'<CR>

map <Leader><Space>n :<C-u>call <SID>NextArglist(v:count1)<CR>
map <Leader><Space>p :<C-u>call <SID>NextArglist(-v:count1)<CR>

" TODO
noremap <silent> <Space>D :<C-u>if argc() == 1 
      \ \| q
      \ \| elseif argc() == 2
      \ \| argdelete
      \ \| first
      \ \| else
      \ \| argdelete
      \ \| if argidx() == argc() - 1
      \ \| argument 1
      \ \| else
      \ \| next
      \ \| endif
      \ \| endif<CR>

" map <Leader><Space>: :<C-u>ArglistsDo<Space>

" }}}
