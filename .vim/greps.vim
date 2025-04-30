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

nnoremap <expr> <Space>vfc g:qfloc ? ':<C-u>lvimgrep //gjf  <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gjf  <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vff g:qfloc ? ':<C-u>lvimgrep //gjf % <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gjf % <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfF g:qfloc ? ':<C-u>lvimgrep //gjf # <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gjf # <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfa g:qfloc ? ':<C-u>lvimgrep //gjf ## <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gjf ## <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfl g:qfloc ? ':<C-u>lvimgrep //gjf * .* <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gjf * .* <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfL g:qfloc ? ':<C-u>lvimgrep //gjf * <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gjf * <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfr g:qfloc ? ':<C-u>lvimgrep //gjf {.[^.]*,*}/**/{.*,*} * .* <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gjf {.[^.]*,*}/**/{.*,*} * .* <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfR g:qfloc ? ':<C-u>lvimgrep //gjf ** <Home><C-Right><Right><Right>' : ':<C-u>vimgrep //gjf ** <Home><C-Right><Right><Right>'

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

" ripgrep {{{
nnoremap <expr> <Leader>rc g:qfloc ? ':<C-u>Lrg ' : ':<C-u>Rg '

nnoremap <expr> <Leader>r<Space>f g:qfloc ? ':<C-u>Lrg  %<Home><C-Right><Right>' : ':<C-u>Rg  %<Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>F g:qfloc ? ':<C-u>Lrg  #<Home><C-Right><Right>' : ':<C-u>Rg  #<Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>a g:qfloc ? ':<C-u>Lrg  ##<Home><C-Right><Right>' : ':<C-u>Rg  ##<Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>l g:qfloc ? ':<C-u>Lrg  * .*<Home><C-Right><Right>' : ':<C-u>Rg  * .*<Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>L g:qfloc ? ':<C-u>Lrg  *<Home><C-Right><Right>' : ':<C-u>Rg  *<Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>r g:qfloc ? ':<C-u>Lrg  -r .<Home><C-Right><Right>' : ':<C-u>Rg  -r .<Home><C-Right><Right>'

nnoremap <expr> <Leader>ruf g:qfloc ? ':<C-u>Lrg '.Expand('<cword>').' %<CR>' : ':<C-u>Rg '.Expand('<cword>').' %<CR>'
nnoremap <expr> <Leader>ruF g:qfloc ? ':<C-u>Lrg '.Expand('<cword>').' #<CR>' : ':<C-u>Rg '.Expand('<cword>').' #<CR>'
nnoremap <expr> <Leader>rua g:qfloc ? ':<C-u>Lrg '.Expand('<cword>').' ##<CR>' : ':<C-u>Rg '.Expand('<cword>').' ##<CR>'
nnoremap <expr> <Leader>rul g:qfloc ? ':<C-u>Lrg '.Expand('<cword>').' * .*<CR>' : ':<C-u>Rg '.Expand('<cword>').' * .*<CR>'
nnoremap <expr> <Leader>ruL g:qfloc ? ':<C-u>Lrg '.Expand('<cword>').' *<CR>' : ':<C-u>Rg '.Expand('<cword>').' *<CR>'
nnoremap <expr> <Leader>rur g:qfloc ? ':<C-u>Lrg '.Expand('<cword>').' -r .<CR>' : ':<C-u>Rg '.Expand('<cword>').' -r .<CR>'

nnoremap <expr> <Leader>rwf g:qfloc ? ':<C-u>Lrg '.Expand('<cWORD>').' %<CR>' : ':<C-u>Rg '.Expand('<cWORD>').' %<CR>'
nnoremap <expr> <Leader>rwF g:qfloc ? ':<C-u>Lrg '.Expand('<cWORD>').' #<CR>' : ':<C-u>Rg '.Expand('<cWORD>').' #<CR>'
nnoremap <expr> <Leader>rwa g:qfloc ? ':<C-u>Lrg '.Expand('<cWORD>').' ##<CR>' : ':<C-u>Rg '.Expand('<cWORD>').' ##<CR>'
nnoremap <expr> <Leader>rwl g:qfloc ? ':<C-u>Lrg '.Expand('<cWORD>').' * .*<CR>' : ':<C-u>Rg '.Expand('<cWORD>').' * .*<CR>'
nnoremap <expr> <Leader>rwL g:qfloc ? ':<C-u>Lrg '.Expand('<cWORD>').' *<CR>' : ':<C-u>Rg '.Expand('<cWORD>').' *<CR>'
nnoremap <expr> <Leader>rwr g:qfloc ? ':<C-u>Lrg '.Expand('<cWORD>').' -r .<CR>' : ':<C-u>Rg '.Expand('<cWORD>').' -r .<CR>'

nnoremap <expr> <Leader>ref g:qfloc ? ':<C-u>Lrg '.Expand('<cexpr>').' %<CR>' : ':<C-u>Rg '.Expand('<cexpr>').' %<CR>'
nnoremap <expr> <Leader>reF g:qfloc ? ':<C-u>Lrg '.Expand('<cexpr>').' #<CR>' : ':<C-u>Rg '.Expand('<cexpr>').' #<CR>'
nnoremap <expr> <Leader>rea g:qfloc ? ':<C-u>Lrg '.Expand('<cexpr>').' ##<CR>' : ':<C-u>Rg '.Expand('<cexpr>').' ##<CR>'
nnoremap <expr> <Leader>rel g:qfloc ? ':<C-u>Lrg '.Expand('<cexpr>').' * .*<CR>' : ':<C-u>Rg '.Expand('<cexpr>').' * .*<CR>'
nnoremap <expr> <Leader>reL g:qfloc ? ':<C-u>Lrg '.Expand('<cexpr>').' *<CR>' : ':<C-u>Rg '.Expand('<cexpr>').' *<CR>'
nnoremap <expr> <Leader>rer g:qfloc ? ':<C-u>Lrg '.Expand('<cexpr>').' -r .<CR>' : ':<C-u>Rg '.Expand('<cexpr>').' -r .<CR>'

nnoremap <expr> <Leader>ryf g:qfloc ? ':<C-u>Lrg '.Vescape(@").' %<CR>' : ':<C-u>Rg '.Vescape(@").' %<CR>'
nnoremap <expr> <Leader>ryF g:qfloc ? ':<C-u>Lrg '.Vescape(@").' #<CR>' : ':<C-u>Rg '.Vescape(@").' #<CR>'
nnoremap <expr> <Leader>rya g:qfloc ? ':<C-u>Lrg '.Vescape(@").' ##<CR>' : ':<C-u>Rg '.Vescape(@").' ##<CR>'
nnoremap <expr> <Leader>ryl g:qfloc ? ':<C-u>Lrg '.Vescape(@").' * .*<CR>' : ':<C-u>Rg '.Vescape(@").' * .*<CR>'
nnoremap <expr> <Leader>ryL g:qfloc ? ':<C-u>Lrg '.Vescape(@").' *<CR>' : ':<C-u>Rg '.Vescape(@").' *<CR>'
nnoremap <expr> <Leader>ryr g:qfloc ? ':<C-u>Lrg '.Vescape(@").' -r .<CR>' : ':<C-u>Rg '.Vescape(@").' -r .<CR>'

nnoremap <expr> <Leader>rgf g:qfloc ? ':<C-u>Lrg '.Vescape(@*).' %<CR>' : ':<C-u>Rg '.Vescape(@*).' %<CR>'
nnoremap <expr> <Leader>rgF g:qfloc ? ':<C-u>Lrg '.Vescape(@*).' #<CR>' : ':<C-u>Rg '.Vescape(@*).' #<CR>'
nnoremap <expr> <Leader>rga g:qfloc ? ':<C-u>Lrg '.Vescape(@*).' ##<CR>' : ':<C-u>Rg '.Vescape(@*).' ##<CR>'
nnoremap <expr> <Leader>rgl g:qfloc ? ':<C-u>Lrg '.Vescape(@*).' * .*<CR>' : ':<C-u>Rg '.Vescape(@*).' * .*<CR>'
nnoremap <expr> <Leader>rgL g:qfloc ? ':<C-u>Lrg '.Vescape(@*).' *<CR>' : ':<C-u>Rg '.Vescape(@*).' *<CR>'
nnoremap <expr> <Leader>rgr g:qfloc ? ':<C-u>Lrg '.Vescape(@*).' -r .<CR>' : ':<C-u>Rg '.Vescape(@*).' -r .<CR>'

nnoremap <expr> <Leader>rpf g:qfloc ? ':<C-u>Lrg '.Vescape(@+).' %<CR>' : ':<C-u>Rg '.Vescape(@+).' %<CR>'
nnoremap <expr> <Leader>rpF g:qfloc ? ':<C-u>Lrg '.Vescape(@+).' #<CR>' : ':<C-u>Rg '.Vescape(@+).' #<CR>'
nnoremap <expr> <Leader>rpa g:qfloc ? ':<C-u>Lrg '.Vescape(@+).' ##<CR>' : ':<C-u>Rg '.Vescape(@+).' ##<CR>'
nnoremap <expr> <Leader>rpl g:qfloc ? ':<C-u>Lrg '.Vescape(@+).' * .*<CR>' : ':<C-u>Rg '.Vescape(@+).' * .*<CR>'
nnoremap <expr> <Leader>rpL g:qfloc ? ':<C-u>Lrg '.Vescape(@+).' *<CR>' : ':<C-u>Rg '.Vescape(@+).' *<CR>'
nnoremap <expr> <Leader>rpr g:qfloc ? ':<C-u>Lrg '.Vescape(@+).' -r .<CR>' : ':<C-u>Rg '.Vescape(@+).' -r .<CR>'

nnoremap <expr> <Leader>rsf g:qfloc ? ':<C-u>Lrg '.Vescape(GetVisualSelection()).' %<CR>' : ':<C-u>Rg '.Vescape(GetVisualSelection()).' %<CR>'
nnoremap <expr> <Leader>rsF g:qfloc ? ':<C-u>Lrg '.Vescape(GetVisualSelection()).' #<CR>' : ':<C-u>Rg '.Vescape(GetVisualSelection()).' #<CR>'
nnoremap <expr> <Leader>rsa g:qfloc ? ':<C-u>Lrg '.Vescape(GetVisualSelection()).' ##<CR>' : ':<C-u>Rg '.Vescape(GetVisualSelection()).' ##<CR>'
nnoremap <expr> <Leader>rsl g:qfloc ? ':<C-u>Lrg '.Vescape(GetVisualSelection()).' * .*<CR>' : ':<C-u>Rg '.Vescape(GetVisualSelection()).' * .*<CR>'
nnoremap <expr> <Leader>rsL g:qfloc ? ':<C-u>Lrg '.Vescape(GetVisualSelection()).' *<CR>' : ':<C-u>Rg '.Vescape(GetVisualSelection()).' *<CR>'
nnoremap <expr> <Leader>rsr g:qfloc ? ':<C-u>Lrg '.Vescape(GetVisualSelection()).' -r .<CR>' : ':<C-u>Rg '.Vescape(GetVisualSelection()).' -r .<CR>'

" }}}

" silver searcher {{{
nnoremap <expr> <Leader>ac g:qfloc ? ':<C-u>Lag ' : ':<C-u>Ag '

nnoremap <expr> <Leader>a<Space>f g:qfloc ? ':<C-u>Lag  %<Home><C-Right><Right>' : ':<C-u>Ag  %<Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>F g:qfloc ? ':<C-u>Lag  #<Home><C-Right><Right>' : ':<C-u>Ag  #<Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>a g:qfloc ? ':<C-u>Lag  ##<Home><C-Right><Right>' : ':<C-u>Ag  ##<Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>l g:qfloc ? ':<C-u>Lag  * .*<Home><C-Right><Right>' : ':<C-u>Ag  * .*<Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>L g:qfloc ? ':<C-u>Lag  *<Home><C-Right><Right>' : ':<C-u>Ag  *<Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>r g:qfloc ? ':<C-u>Lag  -r .<Home><C-Right><Right>' : ':<C-u>Ag  -r .<Home><C-Right><Right>'

nnoremap <expr> <Leader>auf g:qfloc ? ':<C-u>Lag '.Expand('<cword>').' %<CR>' : ':<C-u>Ag '.Expand('<cword>').' %<CR>'
nnoremap <expr> <Leader>auF g:qfloc ? ':<C-u>Lag '.Expand('<cword>').' #<CR>' : ':<C-u>Ag '.Expand('<cword>').' #<CR>'
nnoremap <expr> <Leader>aua g:qfloc ? ':<C-u>Lag '.Expand('<cword>').' ##<CR>' : ':<C-u>Ag '.Expand('<cword>').' ##<CR>'
nnoremap <expr> <Leader>aul g:qfloc ? ':<C-u>Lag '.Expand('<cword>').' * .*<CR>' : ':<C-u>Ag '.Expand('<cword>').' * .*<CR>'
nnoremap <expr> <Leader>auL g:qfloc ? ':<C-u>Lag '.Expand('<cword>').' *<CR>' : ':<C-u>Ag '.Expand('<cword>').' *<CR>'
nnoremap <expr> <Leader>aur g:qfloc ? ':<C-u>Lag '.Expand('<cword>').' -r .<CR>' : ':<C-u>Ag '.Expand('<cword>').' -r .<CR>'

nnoremap <expr> <Leader>awf g:qfloc ? ':<C-u>Lag '.Expand('<cWORD>').' %<CR>' : ':<C-u>Ag '.Expand('<cWORD>').' %<CR>'
nnoremap <expr> <Leader>awF g:qfloc ? ':<C-u>Lag '.Expand('<cWORD>').' #<CR>' : ':<C-u>Ag '.Expand('<cWORD>').' #<CR>'
nnoremap <expr> <Leader>awa g:qfloc ? ':<C-u>Lag '.Expand('<cWORD>').' ##<CR>' : ':<C-u>Ag '.Expand('<cWORD>').' ##<CR>'
nnoremap <expr> <Leader>awl g:qfloc ? ':<C-u>Lag '.Expand('<cWORD>').' * .*<CR>' : ':<C-u>Ag '.Expand('<cWORD>').' * .*<CR>'
nnoremap <expr> <Leader>awL g:qfloc ? ':<C-u>Lag '.Expand('<cWORD>').' *<CR>' : ':<C-u>Ag '.Expand('<cWORD>').' *<CR>'
nnoremap <expr> <Leader>awr g:qfloc ? ':<C-u>Lag '.Expand('<cWORD>').' -r .<CR>' : ':<C-u>Ag '.Expand('<cWORD>').' -r .<CR>'

nnoremap <expr> <Leader>aef g:qfloc ? ':<C-u>Lag '.Expand('<cexpr>').' %<CR>' : ':<C-u>Ag '.Expand('<cexpr>').' %<CR>'
nnoremap <expr> <Leader>aeF g:qfloc ? ':<C-u>Lag '.Expand('<cexpr>').' #<CR>' : ':<C-u>Ag '.Expand('<cexpr>').' #<CR>'
nnoremap <expr> <Leader>aea g:qfloc ? ':<C-u>Lag '.Expand('<cexpr>').' ##<CR>' : ':<C-u>Ag '.Expand('<cexpr>').' ##<CR>'
nnoremap <expr> <Leader>ael g:qfloc ? ':<C-u>Lag '.Expand('<cexpr>').' * .*<CR>' : ':<C-u>Ag '.Expand('<cexpr>').' * .*<CR>'
nnoremap <expr> <Leader>aeL g:qfloc ? ':<C-u>Lag '.Expand('<cexpr>').' *<CR>' : ':<C-u>Ag '.Expand('<cexpr>').' *<CR>'
nnoremap <expr> <Leader>aer g:qfloc ? ':<C-u>Lag '.Expand('<cexpr>').' -r .<CR>' : ':<C-u>Ag '.Expand('<cexpr>').' -r .<CR>'

nnoremap <expr> <Leader>ayf g:qfloc ? ':<C-u>Lag '.Vescape(@").' %<CR>' : ':<C-u>Ag '.Vescape(@").' %<CR>'
nnoremap <expr> <Leader>ayF g:qfloc ? ':<C-u>Lag '.Vescape(@").' #<CR>' : ':<C-u>Ag '.Vescape(@").' #<CR>'
nnoremap <expr> <Leader>aya g:qfloc ? ':<C-u>Lag '.Vescape(@").' ##<CR>' : ':<C-u>Ag '.Vescape(@").' ##<CR>'
nnoremap <expr> <Leader>ayl g:qfloc ? ':<C-u>Lag '.Vescape(@").' * .*<CR>' : ':<C-u>Ag '.Vescape(@").' * .*<CR>'
nnoremap <expr> <Leader>ayL g:qfloc ? ':<C-u>Lag '.Vescape(@").' *<CR>' : ':<C-u>Ag '.Vescape(@").' *<CR>'
nnoremap <expr> <Leader>ayr g:qfloc ? ':<C-u>Lag '.Vescape(@").' -r .<CR>' : ':<C-u>Ag '.Vescape(@").' -r .<CR>'

nnoremap <expr> <Leader>agf g:qfloc ? ':<C-u>Lag '.Vescape(@*).' %<CR>' : ':<C-u>Ag '.Vescape(@*).' %<CR>'
nnoremap <expr> <Leader>agF g:qfloc ? ':<C-u>Lag '.Vescape(@*).' #<CR>' : ':<C-u>Ag '.Vescape(@*).' #<CR>'
nnoremap <expr> <Leader>aga g:qfloc ? ':<C-u>Lag '.Vescape(@*).' ##<CR>' : ':<C-u>Ag '.Vescape(@*).' ##<CR>'
nnoremap <expr> <Leader>agl g:qfloc ? ':<C-u>Lag '.Vescape(@*).' * .*<CR>' : ':<C-u>Ag '.Vescape(@*).' * .*<CR>'
nnoremap <expr> <Leader>agL g:qfloc ? ':<C-u>Lag '.Vescape(@*).' *<CR>' : ':<C-u>Ag '.Vescape(@*).' *<CR>'
nnoremap <expr> <Leader>agr g:qfloc ? ':<C-u>Lag '.Vescape(@*).' -r .<CR>' : ':<C-u>Ag '.Vescape(@*).' -r .<CR>'

nnoremap <expr> <Leader>apf g:qfloc ? ':<C-u>Lag '.Vescape(@+).' %<CR>' : ':<C-u>Ag '.Vescape(@+).' %<CR>'
nnoremap <expr> <Leader>apF g:qfloc ? ':<C-u>Lag '.Vescape(@+).' #<CR>' : ':<C-u>Ag '.Vescape(@+).' #<CR>'
nnoremap <expr> <Leader>apa g:qfloc ? ':<C-u>Lag '.Vescape(@+).' ##<CR>' : ':<C-u>Ag '.Vescape(@+).' ##<CR>'
nnoremap <expr> <Leader>apl g:qfloc ? ':<C-u>Lag '.Vescape(@+).' * .*<CR>' : ':<C-u>Ag '.Vescape(@+).' * .*<CR>'
nnoremap <expr> <Leader>apL g:qfloc ? ':<C-u>Lag '.Vescape(@+).' *<CR>' : ':<C-u>Ag '.Vescape(@+).' *<CR>'
nnoremap <expr> <Leader>apr g:qfloc ? ':<C-u>Lag '.Vescape(@+).' -r .<CR>' : ':<C-u>Ag '.Vescape(@+).' -r .<CR>'

nnoremap <expr> <Leader>asf g:qfloc ? ':<C-u>Lag '.Vescape(GetVisualSelection()).' %<CR>' : ':<C-u>Ag '.Vescape(GetVisualSelection()).' %<CR>'
nnoremap <expr> <Leader>asF g:qfloc ? ':<C-u>Lag '.Vescape(GetVisualSelection()).' #<CR>' : ':<C-u>Ag '.Vescape(GetVisualSelection()).' #<CR>'
nnoremap <expr> <Leader>asa g:qfloc ? ':<C-u>Lag '.Vescape(GetVisualSelection()).' ##<CR>' : ':<C-u>Ag '.Vescape(GetVisualSelection()).' ##<CR>'
nnoremap <expr> <Leader>asl g:qfloc ? ':<C-u>Lag '.Vescape(GetVisualSelection()).' * .*<CR>' : ':<C-u>Ag '.Vescape(GetVisualSelection()).' * .*<CR>'
nnoremap <expr> <Leader>asL g:qfloc ? ':<C-u>Lag '.Vescape(GetVisualSelection()).' *<CR>' : ':<C-u>Ag '.Vescape(GetVisualSelection()).' *<CR>'
nnoremap <expr> <Leader>asr g:qfloc ? ':<C-u>Lag '.Vescape(GetVisualSelection()).' -r .<CR>' : ':<C-u>Ag '.Vescape(GetVisualSelection()).' -r .<CR>'

" }}}

" additional {{{


    noremap <expr> <Space>f- g:qfloc ?
    \ ':<C-u>Lfilter /^grep: /<CR>'
    \ : ':<C-u>Cfilter /^grep: /<CR>'

    noremap <Space>fj :<C-u>Sgrep<Space>
    noremap <Space>fJ :<C-u>Sgrep!<Space>
    noremap <Leader>rj :<C-u>Srg<Space>
    noremap <Leader>rJ :<C-u>Srg!<Space>
    noremap <Leader>aj :<C-u>Sag<Space>
    noremap <Leader>aJ :<C-u>Sag!<Space>

    

" }}}

