"{{{ functions

"{{{ helpers

function QSidx()
  return get(getqflist({idx: 0}), 'idx', 0)
endfunction

function s:QstackPosMove(amount = 1)
  if len(g:qstack) < 1
    throw "There aren't any items on the stack"
  endif
  call s:QstackSet()
  let g:qsind = (g:qsind + a:amount)%len(g:qstack)
  if g:qsind < 0
    let g:qsind = g:qsind + len(g:qstack)
  endif
  return 0
endfunction

"}}}

"{{{ state

function s:QstackSet()
  exe 'cexpr []'
  for e in g:qstack
    exe 'caddexpr "'.escape(
          \ bufname(e[0]).':'.e[1].':'.e[2].':'.getbufline(e[0], e[1])[0],
          \ "\\".'"').'"'
  endfor
endfunction

function s:QstackPosSet()
  let pos = g:qstack[g:qsind]
  exe 'buf '.pos[0]
  call setpos(".", pos)
endfunction

"}}}

"{{{ movement

function s:QstackNext(amount = 1)
  call s:QstackPosMove(a:amount)
  call s:QstackPosSet()
endfunction

function s:QstackNth(nth = 0)
  call s:QstackSet()
  if a:nth < 0
    throw "Invalid position in the stack"
  elseif a:nth >= len(g:qstack)
    throw "Too big position in stack"
  endif
  let g:qsind = a:nth
  call s:QstackPosSet()
endfunction

"}}}

"{{{ adding and deleting

" TODO B proper refreshing
function s:QstackCurAdd()
  let g:qstack = add(g:qstack, getpos('.'))
  let g:qstack[len(g:qstack)-1][0] = bufnr()
  " let g:qstack = add(g:qstack, [bufnr(), line('.'), col('.'), 0])
endfunction

function s:QstackCurDel()
  if len(g:qstack) < 1
    let g:qsind = 0
    return ''
  endif
  let ind = g:qsind
  call s:QstackPosMove()
  call remove(g:qstack, ind)
endfunction

function s:QstackDel(num)
  if a:num >= len(g:qstack) || a:num < 0 
    throw "Invalid element to delete from the stack"
  endif
  if a:num == g:qsind
    call s:QstackPosMove()
  endif
  call remove(g:qstack, a:num)
endfunction

"}}}

"{{{ commands

function s:QstackCmd(cmd)
  call s:QstackSet()
  exe a:cmd
endfunction

function s:QstackOpen(force = 0)
  call s:QstackSet()
  if a:force
    copen
  else
    cwindow
  endif
  nnoremap <buffer> <silent> dd :<C-u>call
        \ <SID>QstackDD(line('.')-1, v:count1)<CR>
endfunction

function s:QstackDD(num, amount)
  let amount = a:amount
  if a:amount < 1
    throw "Invalid amount of items to remove"
  elseif a:num+a:amount >= len(g:qstack) 
    let amount = len(g:qstack) - a:num
  endif
  norm m`
  for i in range(amount)
    call s:QstackDel(a:num+i)
  endfor
  call s:QstackOpen(1)
  norm '`
endfunction

"}}}

"{{{ operations

function s:QstackTop()
  return g:qstack[len(g:qstack)-1]
endfunction

function s:QstackSwap()
  let top = s:QstackTop()
  let second = g:qstack[len(g:qstack)-2]
  call remove(g:qstack, len(g:qstack)-2, len(g:qstack)-1)
  let g:qstack = add(add(g:qstack, top), second)
endfunction

function s:QstackRot1(amount = 2)
  if a:amount > len(g:qstack)
    throw "Amount of elements to rotate is greater than length of stack"
  elseif a:amount == 2 || a:amount == -2
    call QstackSwap()
  elseif amount > 1
    let keep = g:qstack[:len(g:qstack)-a:amount-1]
    let rot = g:qstack[len(g:qstack)-a:amount:len(g:qstack)-2]
    let top = s:QstackTop()
    let g:qstack = keep + [top] + rot
  elseif a:amount < -1
    let keep = g:qstack[:len(g:qstack)-a:amount-1]
    let rot = g:qstack[len(g:qstack)-a:amount+1:len(g:qstack)-1]
    let moved = g:qstack(len(g:qstack)-a:amount)
    let g:qstack = keep + [moved] + rot
  endif
  return 0
endfunction

function s:QstackRot(amount = 2, times = 1)
  if a:times < 0
    throw ""
  endif
  let times = a:times % a:amount
  if times == 0
    return 0
  endif
  for i in range(times)
    call s:QstackRot1(amount)
  endfor
endfunction

"}}}

"}}}

"{{{ setup

let g:qstack = []
let g:qsind = 0

"}}}

"{{{ basic commands

noremap <silent> <Space>jw :<C-u>call <SID>QstackOpen(0)<CR>
noremap <silent> <Space>jl :<C-u>call <SID>QstackOpen(1)<CR>

"}}}

"{{{ movement

noremap <silent> <Space>jn :<C-u>call <SID>QstackNext(v:count1)<CR>
noremap <silent> <Space>jp :<C-u>call <SID>QstackNext(-v:count1)<CR>

" TODO C file commands
" noremap <silent> <Space>jn :<C-u>exe v:count1.'cnf'<CR>
" noremap <silent> <Space>jp :<C-u>exe v:count1.'cpf'<CR>

noremap <silent> <Space>j0 :<C-u>call <SID>QstackNth(0)<CR>
noremap <silent> <Space>j1 :<C-u>call <SID>QstackNth(1)<CR>
noremap <silent> <Space>j2 :<C-u>call <SID>QstackNth(2)<CR>
noremap <silent> <Space>j3 :<C-u>call <SID>QstackNth(3)<CR>
noremap <silent> <Space>j4 :<C-u>call <SID>QstackNth(4)<CR>
noremap <silent> <Space>j5 :<C-u>call <SID>QstackNth(5)<CR>
noremap <silent> <Space>j6 :<C-u>call <SID>QstackNth(6)<CR>
noremap <silent> <Space>j7 :<C-u>call <SID>QstackNth(7)<CR>
noremap <silent> <Space>j8 :<C-u>call <SID>QstackNth(8)<CR>
noremap <silent> <Space>j9 :<C-u>call <SID>QstackNth(9)<CR>

"}}}

"{{{ stack operations

" add
nnoremap <silent> <Space>ja :<C-u>call <SID>QstackCurAdd()<CR>
vnoremap <silent> <Space>ja :<C-u>call <SID>QstackCurAdd()\|norm gv<CR>

" del
nnoremap <silent> <Space>jd :<C-u>call <SID>QstackCurDel()<CR>
vnoremap <silent> <Space>jd :<C-u>call <SID>QstackCurDel()\|norm gv<CR>

" swap
nnoremap <silent> <Space>jos :<C-u>call <SID>QstackSwap()<CR>
vnoremap <silent> <Space>jos :<C-u>call <SID>QstackSwap()\|norm gv<CR>

" rot
nnoremap <silent> <Space>jo2 :<C-u>call <SID>QstackRot(2, v:count1)<CR>
vnoremap <silent> <Space>jo2 :<C-u>call <SID>QstackRot(2, v:count1)\|norm gv<CR>
nnoremap <silent> <Space>jo3 :<C-u>call <SID>QstackRot(3, v:count1)<CR>
vnoremap <silent> <Space>jo3 :<C-u>call <SID>QstackRot(3, v:count1)\|norm gv<CR>
nnoremap <silent> <Space>jo4 :<C-u>call <SID>QstackRot(4, v:count1)<CR>
vnoremap <silent> <Space>jo4 :<C-u>call <SID>QstackRot(4, v:count1)\|norm gv<CR>
nnoremap <silent> <Space>jo5 :<C-u>call <SID>QstackRot(5, v:count1)<CR>
vnoremap <silent> <Space>jo5 :<C-u>call <SID>QstackRot(5, v:count1)\|norm gv<CR>
nnoremap <silent> <Space>jo6 :<C-u>call <SID>QstackRot(6, v:count1)<CR>
vnoremap <silent> <Space>jo6 :<C-u>call <SID>QstackRot(6, v:count1)\|norm gv<CR>
nnoremap <silent> <Space>jo7 :<C-u>call <SID>QstackRot(7, v:count1)<CR>
vnoremap <silent> <Space>jo7 :<C-u>call <SID>QstackRot(7, v:count1)\|norm gv<CR>
nnoremap <silent> <Space>jo8 :<C-u>call <SID>QstackRot(8, v:count1)<CR>
vnoremap <silent> <Space>jo8 :<C-u>call <SID>QstackRot(8, v:count1)\|norm gv<CR>
nnoremap <silent> <Space>jo9 :<C-u>call <SID>QstackRot(9, v:count1)<CR>
vnoremap <silent> <Space>jo9 :<C-u>call <SID>QstackRot(9, v:count1)\|norm gv<CR>

"}}}
