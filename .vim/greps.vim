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



" VIMGREP {{{
nnoremap <expr> <Space>vc g:qfloc ? ':<C-u>'.Vgcount().'lvimgrep ' : ':<C-u>'.Vgcount().'vimgrep '

nnoremap <expr> <Space>v<Space>c g:qfloc ? ':<C-u>lvimgrep //gj  <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj  <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>f g:qfloc ? ':<C-u>lvimgrep //gj % <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj % <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>a g:qfloc ? ':<C-u>lvimgrep //gj ## <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj ## <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>l g:qfloc ? ':<C-u>lvimgrep //gj * <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj * <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>h g:qfloc ? ':<C-u>lvimgrep //gj * .* <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj * .* <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>r g:qfloc ? ':<C-u>lvimgrep //gj ** <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj ** <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>R g:qfloc ? ':<C-u>lvimgrep //gj .*/** ** <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj .*/** ** <Home><C-Right><Right><Right>'

nnoremap <expr> <Space>vuc g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj <CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj <CR>'
nnoremap <expr> <Space>vuf g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj %<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj %<CR>'
nnoremap <expr> <Space>vua g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj ##<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj ##<CR>'
nnoremap <expr> <Space>vul g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj *<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj *<CR>'
nnoremap <expr> <Space>vuh g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj * .*<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj * .*<CR>'
nnoremap <expr> <Space>vur g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj **<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj **<CR>'
nnoremap <expr> <Space>vuR g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj .*/** **<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj .*/** **<CR>'

nnoremap <expr> <Space>vwc g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj <CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj <CR>'
nnoremap <expr> <Space>vwf g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj %<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj %<CR>'
nnoremap <expr> <Space>vwa g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj ##<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj ##<CR>'
nnoremap <expr> <Space>vwl g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj *<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj *<CR>'
nnoremap <expr> <Space>vwh g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj * .*<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj * .*<CR>'
nnoremap <expr> <Space>vwr g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj **<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj **<CR>'
nnoremap <expr> <Space>vwR g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj .*/** **<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj .*/** **<CR>'

nnoremap <expr> <Space>vec g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj <CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj <CR>'
nnoremap <expr> <Space>vef g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj %<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj %<CR>'
nnoremap <expr> <Space>vea g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj ##<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj ##<CR>'
nnoremap <expr> <Space>vel g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj *<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj *<CR>'
nnoremap <expr> <Space>veh g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj * .*<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj * .*<CR>'
nnoremap <expr> <Space>ver g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj **<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj **<CR>'
nnoremap <expr> <Space>veR g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj .*/** **<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj .*/** **<CR>'

nnoremap <expr> <Space>vyc g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj <CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj <CR>'
nnoremap <expr> <Space>vyf g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj %<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj %<CR>'
nnoremap <expr> <Space>vya g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj ##<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj ##<CR>'
nnoremap <expr> <Space>vyl g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj *<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj *<CR>'
nnoremap <expr> <Space>vyh g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj * .*<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj * .*<CR>'
nnoremap <expr> <Space>vyr g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj **<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj **<CR>'
nnoremap <expr> <Space>vyR g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj .*/** **<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj .*/** **<CR>'

nnoremap <expr> <Space>vgc g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj <CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj <CR>'
nnoremap <expr> <Space>vgf g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj %<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj %<CR>'
nnoremap <expr> <Space>vga g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj ##<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj ##<CR>'
nnoremap <expr> <Space>vgl g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj *<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj *<CR>'
nnoremap <expr> <Space>vgh g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj * .*<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj * .*<CR>'
nnoremap <expr> <Space>vgr g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj **<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj **<CR>'
nnoremap <expr> <Space>vgR g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj .*/** **<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj .*/** **<CR>'

nnoremap <expr> <Space>vpc g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj <CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj <CR>'
nnoremap <expr> <Space>vpf g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj %<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj %<CR>'
nnoremap <expr> <Space>vpa g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj ##<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj ##<CR>'
nnoremap <expr> <Space>vpl g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj *<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj *<CR>'
nnoremap <expr> <Space>vph g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj * .*<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj * .*<CR>'
nnoremap <expr> <Space>vpr g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj **<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj **<CR>'
nnoremap <expr> <Space>vpR g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj .*/** **<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj .*/** **<CR>'

nnoremap <expr> <Space>vsc g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj <CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj <CR>'
nnoremap <expr> <Space>vsf g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj %<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj %<CR>'
nnoremap <expr> <Space>vsa g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj ##<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj ##<CR>'
nnoremap <expr> <Space>vsl g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj *<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj *<CR>'
nnoremap <expr> <Space>vsh g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj * .*<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj * .*<CR>'
nnoremap <expr> <Space>vsr g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj **<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj **<CR>'
nnoremap <expr> <Space>vsR g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj .*/** **<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj .*/** **<CR>'

" }}}

" STANDARD GREP {{{
nnoremap <expr> <Space>fc g:qfloc ? ':<C-u>Lgrep ' : ':<C-u>Grep '

nnoremap <expr> <Space>f<Space>f g:qfloc ? ':<C-u>Lgrep  %<Home><C-Right><Right>' : ':<C-u>Grep  %<Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>a g:qfloc ? ':<C-u>Lgrep  ##<Home><C-Right><Right>' : ':<C-u>Grep  ##<Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>l g:qfloc ? ':<C-u>Lgrep  *<Home><C-Right><Right>' : ':<C-u>Grep  *<Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>h g:qfloc ? ':<C-u>Lgrep  * .*<Home><C-Right><Right>' : ':<C-u>Grep  * .*<Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>r g:qfloc ? ':<C-u>Lgrep  **<Home><C-Right><Right>' : ':<C-u>Grep  **<Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>R g:qfloc ? ':<C-u>Lgrep  .*/** **<Home><C-Right><Right>' : ':<C-u>Grep  .*/** **<Home><C-Right><Right>'

nnoremap <expr> <Space>fuf g:qfloc ? ':<C-u>Lgrep '.Expand('<cword>').' %<CR>' : ':<C-u>Grep '.Expand('<cword>').' %<CR>'
nnoremap <expr> <Space>fua g:qfloc ? ':<C-u>Lgrep '.Expand('<cword>').' ##<CR>' : ':<C-u>Grep '.Expand('<cword>').' ##<CR>'
nnoremap <expr> <Space>ful g:qfloc ? ':<C-u>Lgrep '.Expand('<cword>').' *<CR>' : ':<C-u>Grep '.Expand('<cword>').' *<CR>'
nnoremap <expr> <Space>fuh g:qfloc ? ':<C-u>Lgrep '.Expand('<cword>').' * .*<CR>' : ':<C-u>Grep '.Expand('<cword>').' * .*<CR>'
nnoremap <expr> <Space>fur g:qfloc ? ':<C-u>Lgrep '.Expand('<cword>').' **<CR>' : ':<C-u>Grep '.Expand('<cword>').' **<CR>'
nnoremap <expr> <Space>fuR g:qfloc ? ':<C-u>Lgrep '.Expand('<cword>').' .*/** **<CR>' : ':<C-u>Grep '.Expand('<cword>').' .*/** **<CR>'

nnoremap <expr> <Space>fwf g:qfloc ? ':<C-u>Lgrep '.Expand('<cWORD>').' %<CR>' : ':<C-u>Grep '.Expand('<cWORD>').' %<CR>'
nnoremap <expr> <Space>fwa g:qfloc ? ':<C-u>Lgrep '.Expand('<cWORD>').' ##<CR>' : ':<C-u>Grep '.Expand('<cWORD>').' ##<CR>'
nnoremap <expr> <Space>fwl g:qfloc ? ':<C-u>Lgrep '.Expand('<cWORD>').' *<CR>' : ':<C-u>Grep '.Expand('<cWORD>').' *<CR>'
nnoremap <expr> <Space>fwh g:qfloc ? ':<C-u>Lgrep '.Expand('<cWORD>').' * .*<CR>' : ':<C-u>Grep '.Expand('<cWORD>').' * .*<CR>'
nnoremap <expr> <Space>fwr g:qfloc ? ':<C-u>Lgrep '.Expand('<cWORD>').' **<CR>' : ':<C-u>Grep '.Expand('<cWORD>').' **<CR>'
nnoremap <expr> <Space>fwR g:qfloc ? ':<C-u>Lgrep '.Expand('<cWORD>').' .*/** **<CR>' : ':<C-u>Grep '.Expand('<cWORD>').' .*/** **<CR>'

nnoremap <expr> <Space>fef g:qfloc ? ':<C-u>Lgrep '.Expand('<cexpr>').' %<CR>' : ':<C-u>Grep '.Expand('<cexpr>').' %<CR>'
nnoremap <expr> <Space>fea g:qfloc ? ':<C-u>Lgrep '.Expand('<cexpr>').' ##<CR>' : ':<C-u>Grep '.Expand('<cexpr>').' ##<CR>'
nnoremap <expr> <Space>fel g:qfloc ? ':<C-u>Lgrep '.Expand('<cexpr>').' *<CR>' : ':<C-u>Grep '.Expand('<cexpr>').' *<CR>'
nnoremap <expr> <Space>feh g:qfloc ? ':<C-u>Lgrep '.Expand('<cexpr>').' * .*<CR>' : ':<C-u>Grep '.Expand('<cexpr>').' * .*<CR>'
nnoremap <expr> <Space>fer g:qfloc ? ':<C-u>Lgrep '.Expand('<cexpr>').' **<CR>' : ':<C-u>Grep '.Expand('<cexpr>').' **<CR>'
nnoremap <expr> <Space>feR g:qfloc ? ':<C-u>Lgrep '.Expand('<cexpr>').' .*/** **<CR>' : ':<C-u>Grep '.Expand('<cexpr>').' .*/** **<CR>'

nnoremap <expr> <Space>fyf g:qfloc ? ':<C-u>Lgrep '.Vescape(@").' %<CR>' : ':<C-u>Grep '.Vescape(@").' %<CR>'
nnoremap <expr> <Space>fya g:qfloc ? ':<C-u>Lgrep '.Vescape(@").' ##<CR>' : ':<C-u>Grep '.Vescape(@").' ##<CR>'
nnoremap <expr> <Space>fyl g:qfloc ? ':<C-u>Lgrep '.Vescape(@").' *<CR>' : ':<C-u>Grep '.Vescape(@").' *<CR>'
nnoremap <expr> <Space>fyh g:qfloc ? ':<C-u>Lgrep '.Vescape(@").' * .*<CR>' : ':<C-u>Grep '.Vescape(@").' * .*<CR>'
nnoremap <expr> <Space>fyr g:qfloc ? ':<C-u>Lgrep '.Vescape(@").' **<CR>' : ':<C-u>Grep '.Vescape(@").' **<CR>'
nnoremap <expr> <Space>fyR g:qfloc ? ':<C-u>Lgrep '.Vescape(@").' .*/** **<CR>' : ':<C-u>Grep '.Vescape(@").' .*/** **<CR>'

nnoremap <expr> <Space>fgf g:qfloc ? ':<C-u>Lgrep '.Vescape(@*).' %<CR>' : ':<C-u>Grep '.Vescape(@*).' %<CR>'
nnoremap <expr> <Space>fga g:qfloc ? ':<C-u>Lgrep '.Vescape(@*).' ##<CR>' : ':<C-u>Grep '.Vescape(@*).' ##<CR>'
nnoremap <expr> <Space>fgl g:qfloc ? ':<C-u>Lgrep '.Vescape(@*).' *<CR>' : ':<C-u>Grep '.Vescape(@*).' *<CR>'
nnoremap <expr> <Space>fgh g:qfloc ? ':<C-u>Lgrep '.Vescape(@*).' * .*<CR>' : ':<C-u>Grep '.Vescape(@*).' * .*<CR>'
nnoremap <expr> <Space>fgr g:qfloc ? ':<C-u>Lgrep '.Vescape(@*).' **<CR>' : ':<C-u>Grep '.Vescape(@*).' **<CR>'
nnoremap <expr> <Space>fgR g:qfloc ? ':<C-u>Lgrep '.Vescape(@*).' .*/** **<CR>' : ':<C-u>Grep '.Vescape(@*).' .*/** **<CR>'

nnoremap <expr> <Space>fpf g:qfloc ? ':<C-u>Lgrep '.Vescape(@+).' %<CR>' : ':<C-u>Grep '.Vescape(@+).' %<CR>'
nnoremap <expr> <Space>fpa g:qfloc ? ':<C-u>Lgrep '.Vescape(@+).' ##<CR>' : ':<C-u>Grep '.Vescape(@+).' ##<CR>'
nnoremap <expr> <Space>fpl g:qfloc ? ':<C-u>Lgrep '.Vescape(@+).' *<CR>' : ':<C-u>Grep '.Vescape(@+).' *<CR>'
nnoremap <expr> <Space>fph g:qfloc ? ':<C-u>Lgrep '.Vescape(@+).' * .*<CR>' : ':<C-u>Grep '.Vescape(@+).' * .*<CR>'
nnoremap <expr> <Space>fpr g:qfloc ? ':<C-u>Lgrep '.Vescape(@+).' **<CR>' : ':<C-u>Grep '.Vescape(@+).' **<CR>'
nnoremap <expr> <Space>fpR g:qfloc ? ':<C-u>Lgrep '.Vescape(@+).' .*/** **<CR>' : ':<C-u>Grep '.Vescape(@+).' .*/** **<CR>'

nnoremap <expr> <Space>fsf g:qfloc ? ':<C-u>Lgrep '.Vescape(GetVisualSelection()).' %<CR>' : ':<C-u>Grep '.Vescape(GetVisualSelection()).' %<CR>'
nnoremap <expr> <Space>fsa g:qfloc ? ':<C-u>Lgrep '.Vescape(GetVisualSelection()).' ##<CR>' : ':<C-u>Grep '.Vescape(GetVisualSelection()).' ##<CR>'
nnoremap <expr> <Space>fsl g:qfloc ? ':<C-u>Lgrep '.Vescape(GetVisualSelection()).' *<CR>' : ':<C-u>Grep '.Vescape(GetVisualSelection()).' *<CR>'
nnoremap <expr> <Space>fsh g:qfloc ? ':<C-u>Lgrep '.Vescape(GetVisualSelection()).' * .*<CR>' : ':<C-u>Grep '.Vescape(GetVisualSelection()).' * .*<CR>'
nnoremap <expr> <Space>fsr g:qfloc ? ':<C-u>Lgrep '.Vescape(GetVisualSelection()).' **<CR>' : ':<C-u>Grep '.Vescape(GetVisualSelection()).' **<CR>'
nnoremap <expr> <Space>fsR g:qfloc ? ':<C-u>Lgrep '.Vescape(GetVisualSelection()).' .*/** **<CR>' : ':<C-u>Grep '.Vescape(GetVisualSelection()).' .*/** **<CR>'

" }}}

" NEW GEN GREP {{{
nnoremap <expr> <Space>sc g:qfloc ? ':<C-u>Egrep ' : ':<C-u>Legrep '

nnoremap <expr> <Space>s<Space>f g:qfloc ? ':<C-u>Egrep  %<Home><C-Right><Right>' : ':<C-u>Legrep  %<Home><C-Right><Right>'
nnoremap <expr> <Space>s<Space>a g:qfloc ? ':<C-u>Egrep  ##<Home><C-Right><Right>' : ':<C-u>Legrep  ##<Home><C-Right><Right>'
nnoremap <expr> <Space>s<Space>l g:qfloc ? ':<C-u>Egrep  *<Home><C-Right><Right>' : ':<C-u>Legrep  *<Home><C-Right><Right>'
nnoremap <expr> <Space>s<Space>h g:qfloc ? ':<C-u>Egrep  * .*<Home><C-Right><Right>' : ':<C-u>Legrep  * .*<Home><C-Right><Right>'
nnoremap <expr> <Space>s<Space>r g:qfloc ? ':<C-u>Egrep  **<Home><C-Right><Right>' : ':<C-u>Legrep  **<Home><C-Right><Right>'
nnoremap <expr> <Space>s<Space>R g:qfloc ? ':<C-u>Egrep  .*/** **<Home><C-Right><Right>' : ':<C-u>Legrep  .*/** **<Home><C-Right><Right>'

nnoremap <expr> <Space>suf g:qfloc ? ':<C-u>Egrep '.Expand('<cword>').' %<CR>' : ':<C-u>Legrep '.Expand('<cword>').' %<CR>'
nnoremap <expr> <Space>sua g:qfloc ? ':<C-u>Egrep '.Expand('<cword>').' ##<CR>' : ':<C-u>Legrep '.Expand('<cword>').' ##<CR>'
nnoremap <expr> <Space>sul g:qfloc ? ':<C-u>Egrep '.Expand('<cword>').' *<CR>' : ':<C-u>Legrep '.Expand('<cword>').' *<CR>'
nnoremap <expr> <Space>suh g:qfloc ? ':<C-u>Egrep '.Expand('<cword>').' * .*<CR>' : ':<C-u>Legrep '.Expand('<cword>').' * .*<CR>'
nnoremap <expr> <Space>sur g:qfloc ? ':<C-u>Egrep '.Expand('<cword>').' **<CR>' : ':<C-u>Legrep '.Expand('<cword>').' **<CR>'
nnoremap <expr> <Space>suR g:qfloc ? ':<C-u>Egrep '.Expand('<cword>').' .*/** **<CR>' : ':<C-u>Legrep '.Expand('<cword>').' .*/** **<CR>'

nnoremap <expr> <Space>swf g:qfloc ? ':<C-u>Egrep '.Expand('<cWORD>').' %<CR>' : ':<C-u>Legrep '.Expand('<cWORD>').' %<CR>'
nnoremap <expr> <Space>swa g:qfloc ? ':<C-u>Egrep '.Expand('<cWORD>').' ##<CR>' : ':<C-u>Legrep '.Expand('<cWORD>').' ##<CR>'
nnoremap <expr> <Space>swl g:qfloc ? ':<C-u>Egrep '.Expand('<cWORD>').' *<CR>' : ':<C-u>Legrep '.Expand('<cWORD>').' *<CR>'
nnoremap <expr> <Space>swh g:qfloc ? ':<C-u>Egrep '.Expand('<cWORD>').' * .*<CR>' : ':<C-u>Legrep '.Expand('<cWORD>').' * .*<CR>'
nnoremap <expr> <Space>swr g:qfloc ? ':<C-u>Egrep '.Expand('<cWORD>').' **<CR>' : ':<C-u>Legrep '.Expand('<cWORD>').' **<CR>'
nnoremap <expr> <Space>swR g:qfloc ? ':<C-u>Egrep '.Expand('<cWORD>').' .*/** **<CR>' : ':<C-u>Legrep '.Expand('<cWORD>').' .*/** **<CR>'

nnoremap <expr> <Space>sef g:qfloc ? ':<C-u>Egrep '.Expand('<cexpr>').' %<CR>' : ':<C-u>Legrep '.Expand('<cexpr>').' %<CR>'
nnoremap <expr> <Space>sea g:qfloc ? ':<C-u>Egrep '.Expand('<cexpr>').' ##<CR>' : ':<C-u>Legrep '.Expand('<cexpr>').' ##<CR>'
nnoremap <expr> <Space>sel g:qfloc ? ':<C-u>Egrep '.Expand('<cexpr>').' *<CR>' : ':<C-u>Legrep '.Expand('<cexpr>').' *<CR>'
nnoremap <expr> <Space>seh g:qfloc ? ':<C-u>Egrep '.Expand('<cexpr>').' * .*<CR>' : ':<C-u>Legrep '.Expand('<cexpr>').' * .*<CR>'
nnoremap <expr> <Space>ser g:qfloc ? ':<C-u>Egrep '.Expand('<cexpr>').' **<CR>' : ':<C-u>Legrep '.Expand('<cexpr>').' **<CR>'
nnoremap <expr> <Space>seR g:qfloc ? ':<C-u>Egrep '.Expand('<cexpr>').' .*/** **<CR>' : ':<C-u>Legrep '.Expand('<cexpr>').' .*/** **<CR>'

nnoremap <expr> <Space>syf g:qfloc ? ':<C-u>Egrep '.Vescape(@").' %<CR>' : ':<C-u>Legrep '.Vescape(@").' %<CR>'
nnoremap <expr> <Space>sya g:qfloc ? ':<C-u>Egrep '.Vescape(@").' ##<CR>' : ':<C-u>Legrep '.Vescape(@").' ##<CR>'
nnoremap <expr> <Space>syl g:qfloc ? ':<C-u>Egrep '.Vescape(@").' *<CR>' : ':<C-u>Legrep '.Vescape(@").' *<CR>'
nnoremap <expr> <Space>syh g:qfloc ? ':<C-u>Egrep '.Vescape(@").' * .*<CR>' : ':<C-u>Legrep '.Vescape(@").' * .*<CR>'
nnoremap <expr> <Space>syr g:qfloc ? ':<C-u>Egrep '.Vescape(@").' **<CR>' : ':<C-u>Legrep '.Vescape(@").' **<CR>'
nnoremap <expr> <Space>syR g:qfloc ? ':<C-u>Egrep '.Vescape(@").' .*/** **<CR>' : ':<C-u>Legrep '.Vescape(@").' .*/** **<CR>'

nnoremap <expr> <Space>sgf g:qfloc ? ':<C-u>Egrep '.Vescape(@*).' %<CR>' : ':<C-u>Legrep '.Vescape(@*).' %<CR>'
nnoremap <expr> <Space>sga g:qfloc ? ':<C-u>Egrep '.Vescape(@*).' ##<CR>' : ':<C-u>Legrep '.Vescape(@*).' ##<CR>'
nnoremap <expr> <Space>sgl g:qfloc ? ':<C-u>Egrep '.Vescape(@*).' *<CR>' : ':<C-u>Legrep '.Vescape(@*).' *<CR>'
nnoremap <expr> <Space>sgh g:qfloc ? ':<C-u>Egrep '.Vescape(@*).' * .*<CR>' : ':<C-u>Legrep '.Vescape(@*).' * .*<CR>'
nnoremap <expr> <Space>sgr g:qfloc ? ':<C-u>Egrep '.Vescape(@*).' **<CR>' : ':<C-u>Legrep '.Vescape(@*).' **<CR>'
nnoremap <expr> <Space>sgR g:qfloc ? ':<C-u>Egrep '.Vescape(@*).' .*/** **<CR>' : ':<C-u>Legrep '.Vescape(@*).' .*/** **<CR>'

nnoremap <expr> <Space>spf g:qfloc ? ':<C-u>Egrep '.Vescape(@+).' %<CR>' : ':<C-u>Legrep '.Vescape(@+).' %<CR>'
nnoremap <expr> <Space>spa g:qfloc ? ':<C-u>Egrep '.Vescape(@+).' ##<CR>' : ':<C-u>Legrep '.Vescape(@+).' ##<CR>'
nnoremap <expr> <Space>spl g:qfloc ? ':<C-u>Egrep '.Vescape(@+).' *<CR>' : ':<C-u>Legrep '.Vescape(@+).' *<CR>'
nnoremap <expr> <Space>sph g:qfloc ? ':<C-u>Egrep '.Vescape(@+).' * .*<CR>' : ':<C-u>Legrep '.Vescape(@+).' * .*<CR>'
nnoremap <expr> <Space>spr g:qfloc ? ':<C-u>Egrep '.Vescape(@+).' **<CR>' : ':<C-u>Legrep '.Vescape(@+).' **<CR>'
nnoremap <expr> <Space>spR g:qfloc ? ':<C-u>Egrep '.Vescape(@+).' .*/** **<CR>' : ':<C-u>Legrep '.Vescape(@+).' .*/** **<CR>'

nnoremap <expr> <Space>ssf g:qfloc ? ':<C-u>Egrep '.Vescape(GetVisualSelection()).' %<CR>' : ':<C-u>Legrep '.Vescape(GetVisualSelection()).' %<CR>'
nnoremap <expr> <Space>ssa g:qfloc ? ':<C-u>Egrep '.Vescape(GetVisualSelection()).' ##<CR>' : ':<C-u>Legrep '.Vescape(GetVisualSelection()).' ##<CR>'
nnoremap <expr> <Space>ssl g:qfloc ? ':<C-u>Egrep '.Vescape(GetVisualSelection()).' *<CR>' : ':<C-u>Legrep '.Vescape(GetVisualSelection()).' *<CR>'
nnoremap <expr> <Space>ssh g:qfloc ? ':<C-u>Egrep '.Vescape(GetVisualSelection()).' * .*<CR>' : ':<C-u>Legrep '.Vescape(GetVisualSelection()).' * .*<CR>'
nnoremap <expr> <Space>ssr g:qfloc ? ':<C-u>Egrep '.Vescape(GetVisualSelection()).' **<CR>' : ':<C-u>Legrep '.Vescape(GetVisualSelection()).' **<CR>'
nnoremap <expr> <Space>ssR g:qfloc ? ':<C-u>Egrep '.Vescape(GetVisualSelection()).' .*/** **<CR>' : ':<C-u>Legrep '.Vescape(GetVisualSelection()).' .*/** **<CR>'

" }}}

