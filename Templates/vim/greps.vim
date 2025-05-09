" general helpers {{{

" exe 'set grepprg='.escape(copy(g:vimgrep_prog), ' ')
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m

" silent grep
function Fgrep(prog, ...)
  let l:grep = substitute(a:prog, '\ ', ' ', 'g')
  let cmd = join([l:grep] + [expandcmd(join(a:000, ' '))], ' ')
  echo cmd
  return system(cmd)
endfunction

let s:grep_prog = copy(g:vgrep_prog)

let s:ag_args = ' --vimgrep --nobreak --nocolor --no-heading --smart-case '
let s:ag_prog = 'ag '.s:ag_args

let s:rg_args = ' --vimgrep --color=never --no-heading --smart-case '
let s:rg_prog = 'rg '.s:rg_args

" }}}

" " additional settings {{{

" let s:egrep_format = '%f:%l:%c:%m'
" let s:egrep_flags = '--vimgrep --smart-case --no-heading --hidden'
" let s:egrep_progs = [
"      \ 'ag --nobreak --nocolor '.s:egrep_flags,
"      \ 'rg --color=never '.s:egrep_flags,
"      \ ]

" let g:egrep_rec = 0
" let g:egrep_urest = 0
" let g:egrep_ind = 0

" function EgrepPrg()
"   let l:prg = s:egrep_progs[g:egrep_ind]
"   let l:rec = (g:egrep_rec ? '' :
"         \ (l:prg[0:1] == 'ag' ? '-n ' : '--max-depth=0 '))
"   let l:urest = (g:egrep_urest ? '--unrestricted ' : '')
"   return l:prg.' '.l:rec.l:urest
" endfunction

" let g:egrep_prog = EgrepPrg()

" call MapToggle(s:egrep_prefix, 'u', 'g:egrep_urest')
" call VarPrint(s:egrep_prefix, 'u',  'Unrestricted egrep', 'g:egrep_urest')
" call MapToggle(s:egrep_prefix, 'r', 'g:egrep_rec')
" call VarPrint(s:egrep_prefix, 'r',  'Recursive egrep', 'g:egrep_rec')
" call MapToggle(s:egrep_prefix, 'c', 'g:egrep_ind', 1,
"       \ '\|let g:egrep_prog = EgrepPrg()\|echo "egrep program: ".g:egrep_prog')
" call VarPrint(s:egrep_prefix, 'c', 'egrep program', 'g:egrep_prog', 0)

" " }}}
