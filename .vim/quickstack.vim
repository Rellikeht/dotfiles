"{{{ setup

let s:qstack = []
let s:qsind = 0
let s:qsprev = 0

"}}}

"{{{ functions

"{{{ state

function s:QstackSet()
  exe 'cexpr []'
  for e in s:qstack
    exe 'caddexpr "'.escape(
          \ bufname(e[0]).':'.e[1].':'.e[2].':'.getbufline(e[0], e[1])[0],
          \ "\\".'"').'"'
  endfor
endfunction

function s:QstackPosSet()
  let pos = s:qstack[s:qsind]
  exe 'buf '.pos[0]
  call setpos(".", pos)
endfunction

function QstackPosGet()
  echo s:qsind
  return 0
endfunction

"}}}

"{{{ helpers

function QSidx()
  return get(getqflist({idx: 0}), 'idx', 0)
endfunction

function s:QstackPosMove(amount = 1)
  if len(s:qstack) < 1
    throw "There aren't any items on the stack"
  endif
  let s:qsprev = s:qsind
  let s:qsind = (s:qsind + a:amount)%len(s:qstack)
  if s:qsind < 0
    let s:qsind = s:qsind + len(s:qstack)
  endif
  echo s:qsind
  return 0
endfunction

"}}}

"{{{ movement

function s:QstackNext(amount = 1)
  call s:QstackPosMove(a:amount)
  call s:QstackPosSet()
endfunction

function s:QstackNth(nth = v:null)
  if a:nth == v:null
    let l:cur = s:qsind
    let s:qsind = s:qsprev
    let s:qsprev = l:cur
  elseif a:nth < 0
    throw "Invalid position in the stack"
  elseif a:nth >= len(s:qstack)
    throw "Too big position in stack"
  else
    let s:qsprev = s:qsind
    let s:qsind = a:nth
  endif
  call s:QstackPosSet()
endfunction

"}}}

"{{{ adding and deleting

" TODO B proper refreshing
function s:QstackCurAdd()
  let s:qstack = add(s:qstack, getpos('.'))
  let s:qstack[len(s:qstack)-1][0] = bufnr()
endfunction

function s:QstackDel(num=v:null)
  if a:num == v:null || a:num == s:qsind
    call s:QstackPosMove()
  elseif a:num >= len(s:qstack) || a:num < 0
    throw "Invalid element to delete from the stack"
  endif
  call remove(s:qstack, a:num)
  if s:qsind >= a:num
    let s:qsind -= 1
  endif
  if s:qsprev >= a:num
    let s:qsprev -= 1
  endif
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
  call setpos('.', [0, s:qsind+1, 1, 0])

  "{{{

  nnoremap <buffer> <silent> dd :<C-u>call
        \ <SID>QstackDD(line('.')-1, v:count1)<CR>
  nnoremap <buffer> <silent> <BS>
        \ :let qstackln = line('.')-1<CR>
        \ :<C-u>wincmd p<CR>
        \ :<C-u>call <SID>QstackNth(qstackln)<CR>
  nmap <buffer> J j<CR>
  nmap <buffer> K k<CR>
  nmap <buffer> <CR>
  \ :<C-u>let qpos = getpos('.')<CR>
  \<BS>:call <SID>QstackOpen(1)<CR>
  \:call setpos('.', qpos)<CR>

  "}}}
endfunction

function s:QstackDD(num, amount)
  let amount = a:amount
  if a:amount < 1
    throw "Invalid amount of items to remove"
  elseif a:num+a:amount >= len(s:qstack)
    let amount = len(s:qstack) - a:num
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
  return s:qstack[len(s:qstack)-1]
endfunction

function s:QstackSwap()
  let top = s:QstackTop()
  let second = s:qstack[len(s:qstack)-2]
  call remove(s:qstack, len(s:qstack)-2, len(s:qstack)-1)
  let s:qstack = add(add(s:qstack, top), second)
endfunction

function s:QstackRot1(amount = 2)
  if a:amount > len(s:qstack)
    throw "Amount of elements to rotate is greater than length of stack"
  elseif a:amount == 2 || a:amount == -2
    call QstackSwap()
  elseif amount > 1
    let keep = s:qstack[:len(s:qstack)-a:amount-1]
    let rot = s:qstack[len(s:qstack)-a:amount:len(s:qstack)-2]
    let top = s:QstackTop()
    let s:qstack = keep + [top] + rot
  elseif a:amount < -1
    let keep = s:qstack[:len(s:qstack)-a:amount-1]
    let rot = s:qstack[len(s:qstack)-a:amount+1:len(s:qstack)-1]
    let moved = s:qstack(len(s:qstack)-a:amount)
    let s:qstack = keep + [moved] + rot
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

"{{{ maps

"{{{ nops :(

map <Space>j<Esc> <Nop>

"}}}

"{{{ basic commands

noremap <silent> <Space>jw :<C-u>call <SID>QstackOpen(0)<CR>
noremap <silent> <Space>jl :<C-u>call <SID>QstackOpen(1)<CR>

"}}}

"{{{ movement

noremap <silent> <Space>jn :<C-u>call <SID>QstackNext(v:count1)<CR>
noremap <silent> <Space>jp :<C-u>call <SID>QstackNext(-v:count1)<CR>
noremap <silent> <c-j> :<C-u>call <SID>QstackNext(v:count1)<CR>
noremap <silent> <c-k> :<C-u>call <SID>QstackNext(-v:count1)<CR>
noremap <silent> <Space>jr :<C-u>call <SID>QstackNth(v:null)<CR>

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
nnoremap <silent> <Space>jd :<C-u>call <SID>QstackDel()<CR>
vnoremap <silent> <Space>jd :<C-u>call <SID>QstackDel()\|norm gv<CR>

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

"}}}
