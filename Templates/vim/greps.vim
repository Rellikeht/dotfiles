" TODO C (more ?) - grep {{{ 

" - separate shortcut for grep and ag/rg
" - grep with variable controlling case
" - ag/rg with the same variable, --hidden/unrestricted
"   as variable or generate separate shortcuts
" - ag/rg switch as separate variable
" - recursive ???

" grep helpers {{{ 

" TODO B async
" TODO C count
" silent grep
function Grep(...)
  let l:grep = substitute(&grepprg, '\ ', ' ', 'g')
  let cmd = join([l:grep] + [expandcmd(join(a:000, ' '))], ' ')
  echo cmd
  return system(cmd)
endfunction

" commands for it
command -nargs=+ -complete=file Grep cgetexpr Grep(<f-args>)
command -nargs=+ -complete=file Lgrep lgetexpr Grep(<f-args>)
command -nargs=+ -complete=file Sgrep
      \ let grepres = Grep(<f-args>)
      \ | if g:qfloc
      \ | exe 'lgetexpr grepres'
      \ | else
      \ | exe 'cgetexpr grepres'
      \ | endif

command -nargs=+ -complete=file Wgrep
      \ Sgrep <args>
      \ | if g:qfloc
      \ | lopen
      \ | else
      \ | copen
      \ | endif

" and abbrev
cnoreabbrev <expr> grep
      \ (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ?
      \ 'Grep' : 'grep'
cnoreabbrev <expr> lgrep
      \ (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ?
      \ 'Lgrep' : 'lgrep'

let s:grep_prefix = '<Space>f'

" }}} 

" additional helpers {{{ 

" silent grep
function Egrep(...)
  let l:grep = substitute(&grepprg, '\ ', ' ', 'g')
  let cmd = join([g:egrep_prog] + [expandcmd(join(a:000, ' '))], ' ')
  echo cmd
  return system(cmd)
endfunction

" commands for it
command -nargs=+ -complete=file Egrep cgetexpr Egrep(<f-args>)
command -nargs=+ -complete=file Legrep lgetexpr Egrep(<f-args>)
command -nargs=+ -complete=file Segrep
      \ let grepres = Egrep(<f-args>)
      \ | if g:qfloc
      \ | exe 'lgetexpr grepres'
      \ | else
      \ | exe 'cgetexpr grepres'
      \ | endif

command -nargs=+ -complete=file Wegrep
      \ Segrep <args>
      \ | if g:qfloc
      \ | lopen
      \ | else
      \ | copen
      \ | endif

" and abbrev
cnoreabbrev <expr> egrep
      \ (getcmdtype() ==# ':' && getcmdline() ==# 'egrep') ?
      \ 'Egrep' : 'egrep'
cnoreabbrev <expr> legrep
      \ (getcmdtype() ==# ':' && getcmdline() ==# 'legrep') ?
      \ 'Legrep' : 'legrep'

let s:egrep_prefix = '<Space>s'

" }}} 

" grep settings {{{ 

exe 'set grepprg='.escape(copy(g:vimgrep), ' ')
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
let g:greprec = 0
let g:grepcase = 0

call MapToggle(s:grep_prefix, 'r', 'g:greprec', 0, 
      \ '\|exe (g:greprec ? "set grepprg+=\\ -r" : "set grepprg-=\\ -r")')
call VarPrint(s:grep_prefix, 'r',  'Recursive grep', 'g:greprec')
call MapToggle(s:grep_prefix, 'i', 'g:grepcase', 0,
      \ '\|exe (g:grepcase ? "set grepprg+=\\ -i" : "set grepprg-=\\ -i")')
call VarPrint(s:grep_prefix, 'i',  'grep ignore case', 'g:grepcase')
call VarPrint(s:grep_prefix, 'c', 'grepprg', &grepprg, 0)

" }}} 

" additional settings {{{ 

let s:egrep_format = '%f:%l:%c:%m'
let s:egrep_flags = '--vimgrep --smart-case --no-heading --hidden'
let s:egrep_progs = [
     \ 'ag --nobreak --nocolor '.s:egrep_flags,
     \ 'rg --color=never '.s:egrep_flags,
     \ ]

let g:egrep_rec = 0
let g:egrep_urest = 0
let g:egrep_ind = 0

function EgrepPrg()
  let l:prg = s:egrep_progs[g:egrep_ind]
  let l:rec = (g:egrep_rec ? '' : 
        \ (l:prg[0:1] == 'ag' ? '-n ' : '--max-depth=0 '))
  let l:urest = (g:egrep_urest ? '--unrestricted ' : '')
  return l:prg.' '.l:rec.l:urest
endfunction

let g:egrep_prog = EgrepPrg()

call MapToggle(s:egrep_prefix, 'u', 'g:egrep_urest')
call VarPrint(s:egrep_prefix, 'u',  'Unrestricted egrep', 'g:egrep_urest')
call MapToggle(s:egrep_prefix, 'r', 'g:egrep_rec')
call VarPrint(s:egrep_prefix, 'r',  'Recursive egrep', 'g:egrep_rec')
call MapToggle(s:egrep_prefix, 'c', 'g:egrep_ind', 1,
      \ '\|let g:egrep_prog = EgrepPrg()\|echo "egrep program: ".g:egrep_prog')
call VarPrint(s:egrep_prefix, 'c', 'egrep program', 'g:egrep_prog', 0)

" }}} 

" TODO C grepadd

" }}} 

