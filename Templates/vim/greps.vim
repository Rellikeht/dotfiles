" general helpers {{{

" exe 'set grepprg='.escape(copy(g:vimgrep_prog), ' ')
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m

" }}}

" grep helpers {{{

" silent grep
function s:Grep(...)
  let l:grep = substitute(g:vgrep_prog, '\ ', ' ', 'g')
  let cmd = join([l:grep] + [expandcmd(join(a:000, ' '))], ' ')
  echo cmd
  return system(cmd)
endfunction

" commands for it
command -nargs=+ -complete=file Grep cgetexpr <SID>Grep(<f-args>)
command -nargs=+ -complete=file Lgrep lgetexpr <SID>Grep(<f-args>)
command -nargs=+ -complete=file Sgrep
      \ if g:qfloc
      \ | exe 'Lgrep '.<q-args>
      \ | else
      \ | exe 'Grep '.<q-args>
      \ | endif

command -nargs=+ -complete=file Wgrep
      \ exe 'Sgrep '.<q-args>
      \ | call QFcmd('open')

" and abbrev
cnoreabbrev <expr> grep
      \ (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ?
      \ 'Grep' : 'grep'
cnoreabbrev <expr> lgrep
      \ (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ?
      \ 'Lgrep' : 'lgrep'

" }}}

" rg helpers {{{

let s:rg_args = ' --vimgrep --color=never --no-heading --smart-case '
let s:rg_prog = 'rg '.s:rg_args

function s:Rg(...)
  let l:grep = substitute(s:rg_prog, '\ ', ' ', 'g')
  let cmd = join([l:grep] + [expandcmd(join(a:000, ' '))], ' ')
  echo cmd
  return system(cmd)
endfunction

" commands for it
command -nargs=+ -complete=file Rg cgetexpr <SID>Rg(<f-args>)
command -nargs=+ -complete=file Lrg lgetexpr <SID>Rg(<f-args>)
command -nargs=+ -complete=file Srg
      \ if g:qfloc
      \ | exe 'Lrg '.<q-args>
      \ | else
      \ | exe 'Rg '.<q-args>
      \ | endif
      \ | call QFcmd('open')

command -nargs=+ -complete=file Wrg
      \ Srg <args>
      \ | call QFcmd('open')

" }}}

" ag helpers {{{

let s:ag_args = ' --vimgrep --nobreak --nocolor --no-heading --smart-case '
let s:ag_prog = 'ag '.s:ag_args

" silent grep
function s:Ag(...)
  let l:grep = substitute(s:ag_prog, '\ ', ' ', 'g')
  let cmd = join([l:grep] + [expandcmd(join(a:000, ' '))], ' ')
  echo cmd
  return system(cmd)
endfunction

" commands for it
command -nargs=+ -complete=file Ag cgetexpr <SID>Ag(<f-args>)
command -nargs=+ -complete=file Lag lgetexpr <SID>Ag(<f-args>)
command -nargs=+ -complete=file Sag
      \ if g:qfloc
      \ | exe 'Lag '.<q-args>
      \ | else
      \ | exe 'Ag '.<q-args>
      \ | endif
      \ | call QFcmd('open')

command -nargs=+ -complete=file Wag
      \ Sag <args>
      \ | call QFcmd('open')

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
