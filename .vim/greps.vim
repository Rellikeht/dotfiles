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

" }}}

" TODO B
let s:rg_args = ' --vimgrep --color=never --no-heading --smart-case '
let s:rg_prog = 'rg '.s:rg_args

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

" " additional helpers {{{

" " silent grep
" function Egrep(...)
"   let l:grep = substitute(g:egrep_prog, '\ ', ' ', 'g')
"   let cmd = join([l:grep] + [expandcmd(join(a:000, ' '))], ' ')
"   echo cmd
"   return system(cmd)
" endfunction

" " commands for it
" command -nargs=+ -complete=file Egrep cgetexpr Egrep(<f-args>)
" command -nargs=+ -complete=file Legrep lgetexpr Egrep(<f-args>)
" command -nargs=+ -complete=file Segrep
"       \ let grepres = Egrep(<f-args>)
"       \ | if g:qfloc
"       \ | exe 'lgetexpr grepres'
"       \ | else
"       \ | exe 'cgetexpr grepres'
"       \ | endif

" command -nargs=+ -complete=file Wegrep
"       \ Segrep <args>
"       \ | if g:qfloc
"       \ | lopen
"       \ | else
"       \ | copen
"       \ | endif

" " and abbrev
" cnoreabbrev <expr> egrep
"       \ (getcmdtype() ==# ':' && getcmdline() ==# 'egrep') ?
"       \ 'Egrep' : 'egrep'
" cnoreabbrev <expr> legrep
"       \ (getcmdtype() ==# ':' && getcmdline() ==# 'legrep') ?
"       \ 'Legrep' : 'legrep'

" let s:egrep_prefix = '<Space>s'

" " }}}

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


" vimgrep {{{
nnoremap <expr> <Space>vc g:qfloc ? ':<C-u>'.Vgcount().'lvimgrep ' : ':<C-u>'.Vgcount().'vimgrep '

nnoremap <expr> <Space>v<Space>c g:qfloc ? ':<C-u>lvimgrep //gj  <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj  <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>f g:qfloc ? ':<C-u>lvimgrep //gj % <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj % <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>F g:qfloc ? ':<C-u>lvimgrep //gj # <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj # <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>a g:qfloc ? ':<C-u>lvimgrep //gj ## <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj ## <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>l g:qfloc ? ':<C-u>lvimgrep //gj * .* <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj * .* <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>L g:qfloc ? ':<C-u>lvimgrep //gj * <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj * <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>r g:qfloc ? ':<C-u>lvimgrep //gj {.[^.]*,*}/**/{.*,*} * .* <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj {.[^.]*,*}/**/{.*,*} * .* <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>R g:qfloc ? ':<C-u>lvimgrep //gj ** <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gj ** <Home><C-Right><Right><Right>'

nnoremap <expr> <Space>vuc g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj <CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj <CR>'
nnoremap <expr> <Space>vuf g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj %<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj %<CR>'
nnoremap <expr> <Space>vuF g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj #<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj #<CR>'
nnoremap <expr> <Space>vua g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj ##<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj ##<CR>'
nnoremap <expr> <Space>vul g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj * .*<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj * .*<CR>'
nnoremap <expr> <Space>vuL g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj *<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj *<CR>'
nnoremap <expr> <Space>vur g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>vuR g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cword>').'/gj **<CR>' : ':<C-u>vimgrep /'.Expand('<cword>').'/gj **<CR>'

nnoremap <expr> <Space>vwc g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj <CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj <CR>'
nnoremap <expr> <Space>vwf g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj %<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj %<CR>'
nnoremap <expr> <Space>vwF g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj #<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj #<CR>'
nnoremap <expr> <Space>vwa g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj ##<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj ##<CR>'
nnoremap <expr> <Space>vwl g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj * .*<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj * .*<CR>'
nnoremap <expr> <Space>vwL g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj *<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj *<CR>'
nnoremap <expr> <Space>vwr g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>vwR g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cWORD>').'/gj **<CR>' : ':<C-u>vimgrep /'.Expand('<cWORD>').'/gj **<CR>'

nnoremap <expr> <Space>vec g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj <CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj <CR>'
nnoremap <expr> <Space>vef g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj %<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj %<CR>'
nnoremap <expr> <Space>veF g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj #<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj #<CR>'
nnoremap <expr> <Space>vea g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj ##<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj ##<CR>'
nnoremap <expr> <Space>vel g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj * .*<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj * .*<CR>'
nnoremap <expr> <Space>veL g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj *<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj *<CR>'
nnoremap <expr> <Space>ver g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>veR g:qfloc ? ':<C-u>lvimgrep /'.Expand('<cexpr>').'/gj **<CR>' : ':<C-u>vimgrep /'.Expand('<cexpr>').'/gj **<CR>'

nnoremap <expr> <Space>vyc g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj <CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj <CR>'
nnoremap <expr> <Space>vyf g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj %<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj %<CR>'
nnoremap <expr> <Space>vyF g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj #<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj #<CR>'
nnoremap <expr> <Space>vya g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj ##<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj ##<CR>'
nnoremap <expr> <Space>vyl g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj * .*<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj * .*<CR>'
nnoremap <expr> <Space>vyL g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj *<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj *<CR>'
nnoremap <expr> <Space>vyr g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>vyR g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@").'/gj **<CR>' : ':<C-u>vimgrep /'.Vescape(@").'/gj **<CR>'

nnoremap <expr> <Space>vgc g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj <CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj <CR>'
nnoremap <expr> <Space>vgf g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj %<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj %<CR>'
nnoremap <expr> <Space>vgF g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj #<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj #<CR>'
nnoremap <expr> <Space>vga g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj ##<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj ##<CR>'
nnoremap <expr> <Space>vgl g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj * .*<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj * .*<CR>'
nnoremap <expr> <Space>vgL g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj *<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj *<CR>'
nnoremap <expr> <Space>vgr g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>vgR g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@*).'/gj **<CR>' : ':<C-u>vimgrep /'.Vescape(@*).'/gj **<CR>'

nnoremap <expr> <Space>vpc g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj <CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj <CR>'
nnoremap <expr> <Space>vpf g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj %<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj %<CR>'
nnoremap <expr> <Space>vpF g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj #<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj #<CR>'
nnoremap <expr> <Space>vpa g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj ##<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj ##<CR>'
nnoremap <expr> <Space>vpl g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj * .*<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj * .*<CR>'
nnoremap <expr> <Space>vpL g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj *<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj *<CR>'
nnoremap <expr> <Space>vpr g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>vpR g:qfloc ? ':<C-u>lvimgrep /'.Vescape(@+).'/gj **<CR>' : ':<C-u>vimgrep /'.Vescape(@+).'/gj **<CR>'

nnoremap <expr> <Space>vsc g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj <CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj <CR>'
nnoremap <expr> <Space>vsf g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj %<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj %<CR>'
nnoremap <expr> <Space>vsF g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj #<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj #<CR>'
nnoremap <expr> <Space>vsa g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj ##<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj ##<CR>'
nnoremap <expr> <Space>vsl g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj * .*<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj * .*<CR>'
nnoremap <expr> <Space>vsL g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj *<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj *<CR>'
nnoremap <expr> <Space>vsr g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>vsR g:qfloc ? ':<C-u>lvimgrep /'.Vescape(GetVisualSelection()).'/gj **<CR>' : ':<C-u>vimgrep /'.Vescape(GetVisualSelection()).'/gj **<CR>'

" }}}

" standard grep {{{
nnoremap <expr> <Space>fc g:qfloc ? ':<C-u>Lgrep ' : ':<C-u>Grep '

nnoremap <expr> <Space>f<Space>f g:qfloc ? ':<C-u>Lgrep  %<Home><C-Right><Right>' : ':<C-u>Grep  %<Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>F g:qfloc ? ':<C-u>Lgrep  #<Home><C-Right><Right>' : ':<C-u>Grep  #<Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>a g:qfloc ? ':<C-u>Lgrep  ##<Home><C-Right><Right>' : ':<C-u>Grep  ##<Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>l g:qfloc ? ':<C-u>Lgrep  * .*<Home><C-Right><Right>' : ':<C-u>Grep  * .*<Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>L g:qfloc ? ':<C-u>Lgrep  *<Home><C-Right><Right>' : ':<C-u>Grep  *<Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>r g:qfloc ? ':<C-u>Lgrep  -r .<Home><C-Right><Right>' : ':<C-u>Grep  -r .<Home><C-Right><Right>'

nnoremap <expr> <Space>fuf g:qfloc ? ':<C-u>Lgrep '.Expand('<cword>').' %<CR>' : ':<C-u>Grep '.Expand('<cword>').' %<CR>'
nnoremap <expr> <Space>fuF g:qfloc ? ':<C-u>Lgrep '.Expand('<cword>').' #<CR>' : ':<C-u>Grep '.Expand('<cword>').' #<CR>'
nnoremap <expr> <Space>fua g:qfloc ? ':<C-u>Lgrep '.Expand('<cword>').' ##<CR>' : ':<C-u>Grep '.Expand('<cword>').' ##<CR>'
nnoremap <expr> <Space>ful g:qfloc ? ':<C-u>Lgrep '.Expand('<cword>').' * .*<CR>' : ':<C-u>Grep '.Expand('<cword>').' * .*<CR>'
nnoremap <expr> <Space>fuL g:qfloc ? ':<C-u>Lgrep '.Expand('<cword>').' *<CR>' : ':<C-u>Grep '.Expand('<cword>').' *<CR>'
nnoremap <expr> <Space>fur g:qfloc ? ':<C-u>Lgrep '.Expand('<cword>').' -r .<CR>' : ':<C-u>Grep '.Expand('<cword>').' -r .<CR>'

nnoremap <expr> <Space>fwf g:qfloc ? ':<C-u>Lgrep '.Expand('<cWORD>').' %<CR>' : ':<C-u>Grep '.Expand('<cWORD>').' %<CR>'
nnoremap <expr> <Space>fwF g:qfloc ? ':<C-u>Lgrep '.Expand('<cWORD>').' #<CR>' : ':<C-u>Grep '.Expand('<cWORD>').' #<CR>'
nnoremap <expr> <Space>fwa g:qfloc ? ':<C-u>Lgrep '.Expand('<cWORD>').' ##<CR>' : ':<C-u>Grep '.Expand('<cWORD>').' ##<CR>'
nnoremap <expr> <Space>fwl g:qfloc ? ':<C-u>Lgrep '.Expand('<cWORD>').' * .*<CR>' : ':<C-u>Grep '.Expand('<cWORD>').' * .*<CR>'
nnoremap <expr> <Space>fwL g:qfloc ? ':<C-u>Lgrep '.Expand('<cWORD>').' *<CR>' : ':<C-u>Grep '.Expand('<cWORD>').' *<CR>'
nnoremap <expr> <Space>fwr g:qfloc ? ':<C-u>Lgrep '.Expand('<cWORD>').' -r .<CR>' : ':<C-u>Grep '.Expand('<cWORD>').' -r .<CR>'

nnoremap <expr> <Space>fef g:qfloc ? ':<C-u>Lgrep '.Expand('<cexpr>').' %<CR>' : ':<C-u>Grep '.Expand('<cexpr>').' %<CR>'
nnoremap <expr> <Space>feF g:qfloc ? ':<C-u>Lgrep '.Expand('<cexpr>').' #<CR>' : ':<C-u>Grep '.Expand('<cexpr>').' #<CR>'
nnoremap <expr> <Space>fea g:qfloc ? ':<C-u>Lgrep '.Expand('<cexpr>').' ##<CR>' : ':<C-u>Grep '.Expand('<cexpr>').' ##<CR>'
nnoremap <expr> <Space>fel g:qfloc ? ':<C-u>Lgrep '.Expand('<cexpr>').' * .*<CR>' : ':<C-u>Grep '.Expand('<cexpr>').' * .*<CR>'
nnoremap <expr> <Space>feL g:qfloc ? ':<C-u>Lgrep '.Expand('<cexpr>').' *<CR>' : ':<C-u>Grep '.Expand('<cexpr>').' *<CR>'
nnoremap <expr> <Space>fer g:qfloc ? ':<C-u>Lgrep '.Expand('<cexpr>').' -r .<CR>' : ':<C-u>Grep '.Expand('<cexpr>').' -r .<CR>'

nnoremap <expr> <Space>fyf g:qfloc ? ':<C-u>Lgrep '.Vescape(@").' %<CR>' : ':<C-u>Grep '.Vescape(@").' %<CR>'
nnoremap <expr> <Space>fyF g:qfloc ? ':<C-u>Lgrep '.Vescape(@").' #<CR>' : ':<C-u>Grep '.Vescape(@").' #<CR>'
nnoremap <expr> <Space>fya g:qfloc ? ':<C-u>Lgrep '.Vescape(@").' ##<CR>' : ':<C-u>Grep '.Vescape(@").' ##<CR>'
nnoremap <expr> <Space>fyl g:qfloc ? ':<C-u>Lgrep '.Vescape(@").' * .*<CR>' : ':<C-u>Grep '.Vescape(@").' * .*<CR>'
nnoremap <expr> <Space>fyL g:qfloc ? ':<C-u>Lgrep '.Vescape(@").' *<CR>' : ':<C-u>Grep '.Vescape(@").' *<CR>'
nnoremap <expr> <Space>fyr g:qfloc ? ':<C-u>Lgrep '.Vescape(@").' -r .<CR>' : ':<C-u>Grep '.Vescape(@").' -r .<CR>'

nnoremap <expr> <Space>fgf g:qfloc ? ':<C-u>Lgrep '.Vescape(@*).' %<CR>' : ':<C-u>Grep '.Vescape(@*).' %<CR>'
nnoremap <expr> <Space>fgF g:qfloc ? ':<C-u>Lgrep '.Vescape(@*).' #<CR>' : ':<C-u>Grep '.Vescape(@*).' #<CR>'
nnoremap <expr> <Space>fga g:qfloc ? ':<C-u>Lgrep '.Vescape(@*).' ##<CR>' : ':<C-u>Grep '.Vescape(@*).' ##<CR>'
nnoremap <expr> <Space>fgl g:qfloc ? ':<C-u>Lgrep '.Vescape(@*).' * .*<CR>' : ':<C-u>Grep '.Vescape(@*).' * .*<CR>'
nnoremap <expr> <Space>fgL g:qfloc ? ':<C-u>Lgrep '.Vescape(@*).' *<CR>' : ':<C-u>Grep '.Vescape(@*).' *<CR>'
nnoremap <expr> <Space>fgr g:qfloc ? ':<C-u>Lgrep '.Vescape(@*).' -r .<CR>' : ':<C-u>Grep '.Vescape(@*).' -r .<CR>'

nnoremap <expr> <Space>fpf g:qfloc ? ':<C-u>Lgrep '.Vescape(@+).' %<CR>' : ':<C-u>Grep '.Vescape(@+).' %<CR>'
nnoremap <expr> <Space>fpF g:qfloc ? ':<C-u>Lgrep '.Vescape(@+).' #<CR>' : ':<C-u>Grep '.Vescape(@+).' #<CR>'
nnoremap <expr> <Space>fpa g:qfloc ? ':<C-u>Lgrep '.Vescape(@+).' ##<CR>' : ':<C-u>Grep '.Vescape(@+).' ##<CR>'
nnoremap <expr> <Space>fpl g:qfloc ? ':<C-u>Lgrep '.Vescape(@+).' * .*<CR>' : ':<C-u>Grep '.Vescape(@+).' * .*<CR>'
nnoremap <expr> <Space>fpL g:qfloc ? ':<C-u>Lgrep '.Vescape(@+).' *<CR>' : ':<C-u>Grep '.Vescape(@+).' *<CR>'
nnoremap <expr> <Space>fpr g:qfloc ? ':<C-u>Lgrep '.Vescape(@+).' -r .<CR>' : ':<C-u>Grep '.Vescape(@+).' -r .<CR>'

nnoremap <expr> <Space>fsf g:qfloc ? ':<C-u>Lgrep '.Vescape(GetVisualSelection()).' %<CR>' : ':<C-u>Grep '.Vescape(GetVisualSelection()).' %<CR>'
nnoremap <expr> <Space>fsF g:qfloc ? ':<C-u>Lgrep '.Vescape(GetVisualSelection()).' #<CR>' : ':<C-u>Grep '.Vescape(GetVisualSelection()).' #<CR>'
nnoremap <expr> <Space>fsa g:qfloc ? ':<C-u>Lgrep '.Vescape(GetVisualSelection()).' ##<CR>' : ':<C-u>Grep '.Vescape(GetVisualSelection()).' ##<CR>'
nnoremap <expr> <Space>fsl g:qfloc ? ':<C-u>Lgrep '.Vescape(GetVisualSelection()).' * .*<CR>' : ':<C-u>Grep '.Vescape(GetVisualSelection()).' * .*<CR>'
nnoremap <expr> <Space>fsL g:qfloc ? ':<C-u>Lgrep '.Vescape(GetVisualSelection()).' *<CR>' : ':<C-u>Grep '.Vescape(GetVisualSelection()).' *<CR>'
nnoremap <expr> <Space>fsr g:qfloc ? ':<C-u>Lgrep '.Vescape(GetVisualSelection()).' -r .<CR>' : ':<C-u>Grep '.Vescape(GetVisualSelection()).' -r .<CR>'

" }}}

" additional {{{

" }}}

