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


" vimgrep {{{

command -nargs=+ -complete=file Svimgrep
      \ if g:qfloc
      \ | exe 'lvimgrep '.<q-args>
      \ | else
      \ | exe 'vimgrep '.<q-args>
      \ | endif

command -nargs=+ -complete=file Wvimgrep
      \ exe 'Svimgrep '.<q-args>
      \ | call QFcmd('open')
        

nnoremap <expr> <Space>vc ':<C-u>'.Vgcount().'Svimgrep '
nnoremap <expr> <Space>v<Space>c ':<C-u>Svimgrep //gj  <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>f ':<C-u>Svimgrep //gj % <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>F ':<C-u>Svimgrep //gj # <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>a ':<C-u>Svimgrep //gj ## <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>l ':<C-u>Svimgrep //gj * .* <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>L ':<C-u>Svimgrep //gj * <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>r ':<C-u>Svimgrep //gj {.[^.]*,*}/**/{.*,*} * .* <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>v<Space>R ':<C-u>Svimgrep //gj ** <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfc ':<C-u>Svimgrep //fgj  <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vff ':<C-u>Svimgrep //fgj % <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfF ':<C-u>Svimgrep //fgj # <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfa ':<C-u>Svimgrep //fgj ## <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfl ':<C-u>Svimgrep //fgj * .* <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfL ':<C-u>Svimgrep //fgj * <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfr ':<C-u>Svimgrep //fgj {.[^.]*,*}/**/{.*,*} * .* <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vfR ':<C-u>Svimgrep //fgj ** <Home><C-Right><Right><Right>'
nnoremap <expr> <Space>vu<Space> ':<C-u>Svimgrep /'.Expand('<cword>').'/gj '
nnoremap <expr> <Space>vw<Space> ':<C-u>Svimgrep /'.Expand('<cWORD>').'/gj '
nnoremap <expr> <Space>ve<Space> ':<C-u>Svimgrep /'.Expand('<cexpr>').'/gj '
nnoremap <expr> <Space>vy<Space> ':<C-u>Svimgrep /'.Vescape(@").'/gj '
nnoremap <expr> <Space>vg<Space> ':<C-u>Svimgrep /'.Vescape(@*).'/gj '
nnoremap <expr> <Space>vp<Space> ':<C-u>Svimgrep /'.Vescape(@+).'/gj '
nnoremap <expr> <Space>vs<Space> ':<C-u>Svimgrep /'.Vescape(GetVisualSelection()).'/gj '

nnoremap <expr> <Space>vuc ':<C-u>Svimgrep /'.Expand('<cword>').'/gj <CR>'
nnoremap <expr> <Space>vuf ':<C-u>Svimgrep /'.Expand('<cword>').'/gj %<CR>'
nnoremap <expr> <Space>vuF ':<C-u>Svimgrep /'.Expand('<cword>').'/gj #<CR>'
nnoremap <expr> <Space>vua ':<C-u>Svimgrep /'.Expand('<cword>').'/gj ##<CR>'
nnoremap <expr> <Space>vul ':<C-u>Svimgrep /'.Expand('<cword>').'/gj * .*<CR>'
nnoremap <expr> <Space>vuL ':<C-u>Svimgrep /'.Expand('<cword>').'/gj *<CR>'
nnoremap <expr> <Space>vur ':<C-u>Svimgrep /'.Expand('<cword>').'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>vuR ':<C-u>Svimgrep /'.Expand('<cword>').'/gj **<CR>'

nnoremap <expr> <Space>vwc ':<C-u>Svimgrep /'.Expand('<cWORD>').'/gj <CR>'
nnoremap <expr> <Space>vwf ':<C-u>Svimgrep /'.Expand('<cWORD>').'/gj %<CR>'
nnoremap <expr> <Space>vwF ':<C-u>Svimgrep /'.Expand('<cWORD>').'/gj #<CR>'
nnoremap <expr> <Space>vwa ':<C-u>Svimgrep /'.Expand('<cWORD>').'/gj ##<CR>'
nnoremap <expr> <Space>vwl ':<C-u>Svimgrep /'.Expand('<cWORD>').'/gj * .*<CR>'
nnoremap <expr> <Space>vwL ':<C-u>Svimgrep /'.Expand('<cWORD>').'/gj *<CR>'
nnoremap <expr> <Space>vwr ':<C-u>Svimgrep /'.Expand('<cWORD>').'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>vwR ':<C-u>Svimgrep /'.Expand('<cWORD>').'/gj **<CR>'

nnoremap <expr> <Space>vec ':<C-u>Svimgrep /'.Expand('<cexpr>').'/gj <CR>'
nnoremap <expr> <Space>vef ':<C-u>Svimgrep /'.Expand('<cexpr>').'/gj %<CR>'
nnoremap <expr> <Space>veF ':<C-u>Svimgrep /'.Expand('<cexpr>').'/gj #<CR>'
nnoremap <expr> <Space>vea ':<C-u>Svimgrep /'.Expand('<cexpr>').'/gj ##<CR>'
nnoremap <expr> <Space>vel ':<C-u>Svimgrep /'.Expand('<cexpr>').'/gj * .*<CR>'
nnoremap <expr> <Space>veL ':<C-u>Svimgrep /'.Expand('<cexpr>').'/gj *<CR>'
nnoremap <expr> <Space>ver ':<C-u>Svimgrep /'.Expand('<cexpr>').'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>veR ':<C-u>Svimgrep /'.Expand('<cexpr>').'/gj **<CR>'

nnoremap <expr> <Space>vyc ':<C-u>Svimgrep /'.Vescape(@").'/gj <CR>'
nnoremap <expr> <Space>vyf ':<C-u>Svimgrep /'.Vescape(@").'/gj %<CR>'
nnoremap <expr> <Space>vyF ':<C-u>Svimgrep /'.Vescape(@").'/gj #<CR>'
nnoremap <expr> <Space>vya ':<C-u>Svimgrep /'.Vescape(@").'/gj ##<CR>'
nnoremap <expr> <Space>vyl ':<C-u>Svimgrep /'.Vescape(@").'/gj * .*<CR>'
nnoremap <expr> <Space>vyL ':<C-u>Svimgrep /'.Vescape(@").'/gj *<CR>'
nnoremap <expr> <Space>vyr ':<C-u>Svimgrep /'.Vescape(@").'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>vyR ':<C-u>Svimgrep /'.Vescape(@").'/gj **<CR>'

nnoremap <expr> <Space>vgc ':<C-u>Svimgrep /'.Vescape(@*).'/gj <CR>'
nnoremap <expr> <Space>vgf ':<C-u>Svimgrep /'.Vescape(@*).'/gj %<CR>'
nnoremap <expr> <Space>vgF ':<C-u>Svimgrep /'.Vescape(@*).'/gj #<CR>'
nnoremap <expr> <Space>vga ':<C-u>Svimgrep /'.Vescape(@*).'/gj ##<CR>'
nnoremap <expr> <Space>vgl ':<C-u>Svimgrep /'.Vescape(@*).'/gj * .*<CR>'
nnoremap <expr> <Space>vgL ':<C-u>Svimgrep /'.Vescape(@*).'/gj *<CR>'
nnoremap <expr> <Space>vgr ':<C-u>Svimgrep /'.Vescape(@*).'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>vgR ':<C-u>Svimgrep /'.Vescape(@*).'/gj **<CR>'

nnoremap <expr> <Space>vpc ':<C-u>Svimgrep /'.Vescape(@+).'/gj <CR>'
nnoremap <expr> <Space>vpf ':<C-u>Svimgrep /'.Vescape(@+).'/gj %<CR>'
nnoremap <expr> <Space>vpF ':<C-u>Svimgrep /'.Vescape(@+).'/gj #<CR>'
nnoremap <expr> <Space>vpa ':<C-u>Svimgrep /'.Vescape(@+).'/gj ##<CR>'
nnoremap <expr> <Space>vpl ':<C-u>Svimgrep /'.Vescape(@+).'/gj * .*<CR>'
nnoremap <expr> <Space>vpL ':<C-u>Svimgrep /'.Vescape(@+).'/gj *<CR>'
nnoremap <expr> <Space>vpr ':<C-u>Svimgrep /'.Vescape(@+).'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>vpR ':<C-u>Svimgrep /'.Vescape(@+).'/gj **<CR>'

nnoremap <expr> <Space>vsc ':<C-u>Svimgrep /'.Vescape(GetVisualSelection()).'/gj <CR>'
nnoremap <expr> <Space>vsf ':<C-u>Svimgrep /'.Vescape(GetVisualSelection()).'/gj %<CR>'
nnoremap <expr> <Space>vsF ':<C-u>Svimgrep /'.Vescape(GetVisualSelection()).'/gj #<CR>'
nnoremap <expr> <Space>vsa ':<C-u>Svimgrep /'.Vescape(GetVisualSelection()).'/gj ##<CR>'
nnoremap <expr> <Space>vsl ':<C-u>Svimgrep /'.Vescape(GetVisualSelection()).'/gj * .*<CR>'
nnoremap <expr> <Space>vsL ':<C-u>Svimgrep /'.Vescape(GetVisualSelection()).'/gj *<CR>'
nnoremap <expr> <Space>vsr ':<C-u>Svimgrep /'.Vescape(GetVisualSelection()).'/gj {.[^.]*,*}/**/{.*,*} * .*<CR>'
nnoremap <expr> <Space>vsR ':<C-u>Svimgrep /'.Vescape(GetVisualSelection()).'/gj **<CR>'
" }}}

" standard grep {{{

command -nargs=+ -complete=file Cgrep
        \ cgetexpr Fgrep(s:grep_prog, <f-args>)
command -nargs=+ -complete=file Lgrep
        \ lgetexpr Fgrep(s:grep_prog, <f-args>)
            

command -nargs=+ -complete=file Sgrep
      \ if g:qfloc
      \ | exe 'Lgrep '.<q-args>
      \ | else
      \ | exe 'Cgrep '.<q-args>
      \ | endif

command -nargs=+ -complete=file Wgrep
      \ exe 'Sgrep '.<q-args>
      \ | call QFcmd('open')
        

nnoremap <expr> <Space>fc ':<C-u>Sgrep '
nnoremap <expr> <Space>f<Space>f ':<C-u>Sgrep  % <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>F ':<C-u>Sgrep  # <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>a ':<C-u>Sgrep  ## <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>l ':<C-u>Sgrep  * .* <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>L ':<C-u>Sgrep  * <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>r ':<C-u>Sgrep  -r . <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>g ':<C-u>Sgrep  -r '.GitRoot().' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>G ':<C-u>Sgrep  -r '.GitRoot(GitRoot().'/..').' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>m ':<C-u>Sgrep  -r '.HgRoot().' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>M ':<C-u>Sgrep  -r '.HgRoot(HgRoot().'/..').' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>e ':<C-u>Sgrep  -r '.EnvrcRoot().' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>E ':<C-u>Sgrep  -r '.EnvrcRoot(EnvrcRoot().'/..').' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space><C-e> ':<C-u>Sgrep  -r '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>b ':<C-u>Sgrep  -r '.g:starting_path.' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>1 ':<C-u>Sgrep  -r '.Bp(1).' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>2 ':<C-u>Sgrep  -r '.Bp(2).' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>3 ':<C-u>Sgrep  -r '.Bp(3).' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>4 ':<C-u>Sgrep  -r '.Bp(4).' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>5 ':<C-u>Sgrep  -r '.Bp(5).' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>6 ':<C-u>Sgrep  -r '.Bp(6).' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>7 ':<C-u>Sgrep  -r '.Bp(7).' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>8 ':<C-u>Sgrep  -r '.Bp(8).' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>9 ':<C-u>Sgrep  -r '.Bp(9).' <Home><C-Right><Right>'
nnoremap <expr> <Space>f<Space>10 ':<C-u>Sgrep  -r '.Bp(10).' <Home><C-Right><Right>'
nnoremap <expr> <Space>fu<Space> ':<C-u>Sgrep '.Expand('<cword>').' '
nnoremap <expr> <Space>fw<Space> ':<C-u>Sgrep '.Expand('<cWORD>').' '
nnoremap <expr> <Space>fe<Space> ':<C-u>Sgrep '.Expand('<cexpr>').' '
nnoremap <expr> <Space>fy<Space> ':<C-u>Sgrep '.Vescape(@").' '
nnoremap <expr> <Space>fg<Space> ':<C-u>Sgrep '.Vescape(@*).' '
nnoremap <expr> <Space>fp<Space> ':<C-u>Sgrep '.Vescape(@+).' '
nnoremap <expr> <Space>fs<Space> ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' '


nnoremap <expr> <Space>fuf ':<C-u>Sgrep '.Expand('<cword>').' %<CR>'
nnoremap <expr> <Space>fuF ':<C-u>Sgrep '.Expand('<cword>').' #<CR>'
nnoremap <expr> <Space>fua ':<C-u>Sgrep '.Expand('<cword>').' ##<CR>'
nnoremap <expr> <Space>ful ':<C-u>Sgrep '.Expand('<cword>').' * .*<CR>'
nnoremap <expr> <Space>fuL ':<C-u>Sgrep '.Expand('<cword>').' *<CR>'
nnoremap <expr> <Space>fur ':<C-u>Sgrep '.Expand('<cword>').' -r .<CR>'
nnoremap <expr> <Space>fug ':<C-u>Sgrep '.Expand('<cword>').' -r '.GitRoot().'<CR>'
nnoremap <expr> <Space>fuG ':<C-u>Sgrep '.Expand('<cword>').' -r '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Space>fum ':<C-u>Sgrep '.Expand('<cword>').' -r '.HgRoot().'<CR>'
nnoremap <expr> <Space>fuM ':<C-u>Sgrep '.Expand('<cword>').' -r '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Space>fue ':<C-u>Sgrep '.Expand('<cword>').' -r '.EnvrcRoot().'<CR>'
nnoremap <expr> <Space>fuE ':<C-u>Sgrep '.Expand('<cword>').' -r '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Space>fu<C-e> ':<C-u>Sgrep '.Expand('<cword>').' -r '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Space>fub ':<C-u>Sgrep '.Expand('<cword>').' -r '.g:starting_path.'<CR>'
nnoremap <expr> <Space>fu1 ':<C-u>Sgrep '.Expand('<cword>').' -r '.Bp(1).'<CR>'
nnoremap <expr> <Space>fu2 ':<C-u>Sgrep '.Expand('<cword>').' -r '.Bp(2).'<CR>'
nnoremap <expr> <Space>fu3 ':<C-u>Sgrep '.Expand('<cword>').' -r '.Bp(3).'<CR>'
nnoremap <expr> <Space>fu4 ':<C-u>Sgrep '.Expand('<cword>').' -r '.Bp(4).'<CR>'
nnoremap <expr> <Space>fu5 ':<C-u>Sgrep '.Expand('<cword>').' -r '.Bp(5).'<CR>'
nnoremap <expr> <Space>fu6 ':<C-u>Sgrep '.Expand('<cword>').' -r '.Bp(6).'<CR>'
nnoremap <expr> <Space>fu7 ':<C-u>Sgrep '.Expand('<cword>').' -r '.Bp(7).'<CR>'
nnoremap <expr> <Space>fu8 ':<C-u>Sgrep '.Expand('<cword>').' -r '.Bp(8).'<CR>'
nnoremap <expr> <Space>fu9 ':<C-u>Sgrep '.Expand('<cword>').' -r '.Bp(9).'<CR>'
nnoremap <expr> <Space>fu10 ':<C-u>Sgrep '.Expand('<cword>').' -r '.Bp(10).'<CR>'

nnoremap <expr> <Space>fwf ':<C-u>Sgrep '.Expand('<cWORD>').' %<CR>'
nnoremap <expr> <Space>fwF ':<C-u>Sgrep '.Expand('<cWORD>').' #<CR>'
nnoremap <expr> <Space>fwa ':<C-u>Sgrep '.Expand('<cWORD>').' ##<CR>'
nnoremap <expr> <Space>fwl ':<C-u>Sgrep '.Expand('<cWORD>').' * .*<CR>'
nnoremap <expr> <Space>fwL ':<C-u>Sgrep '.Expand('<cWORD>').' *<CR>'
nnoremap <expr> <Space>fwr ':<C-u>Sgrep '.Expand('<cWORD>').' -r .<CR>'
nnoremap <expr> <Space>fwg ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.GitRoot().'<CR>'
nnoremap <expr> <Space>fwG ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Space>fwm ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.HgRoot().'<CR>'
nnoremap <expr> <Space>fwM ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Space>fwe ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.EnvrcRoot().'<CR>'
nnoremap <expr> <Space>fwE ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Space>fw<C-e> ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Space>fwb ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.g:starting_path.'<CR>'
nnoremap <expr> <Space>fw1 ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.Bp(1).'<CR>'
nnoremap <expr> <Space>fw2 ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.Bp(2).'<CR>'
nnoremap <expr> <Space>fw3 ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.Bp(3).'<CR>'
nnoremap <expr> <Space>fw4 ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.Bp(4).'<CR>'
nnoremap <expr> <Space>fw5 ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.Bp(5).'<CR>'
nnoremap <expr> <Space>fw6 ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.Bp(6).'<CR>'
nnoremap <expr> <Space>fw7 ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.Bp(7).'<CR>'
nnoremap <expr> <Space>fw8 ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.Bp(8).'<CR>'
nnoremap <expr> <Space>fw9 ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.Bp(9).'<CR>'
nnoremap <expr> <Space>fw10 ':<C-u>Sgrep '.Expand('<cWORD>').' -r '.Bp(10).'<CR>'

nnoremap <expr> <Space>fef ':<C-u>Sgrep '.Expand('<cexpr>').' %<CR>'
nnoremap <expr> <Space>feF ':<C-u>Sgrep '.Expand('<cexpr>').' #<CR>'
nnoremap <expr> <Space>fea ':<C-u>Sgrep '.Expand('<cexpr>').' ##<CR>'
nnoremap <expr> <Space>fel ':<C-u>Sgrep '.Expand('<cexpr>').' * .*<CR>'
nnoremap <expr> <Space>feL ':<C-u>Sgrep '.Expand('<cexpr>').' *<CR>'
nnoremap <expr> <Space>fer ':<C-u>Sgrep '.Expand('<cexpr>').' -r .<CR>'
nnoremap <expr> <Space>feg ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.GitRoot().'<CR>'
nnoremap <expr> <Space>feG ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Space>fem ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.HgRoot().'<CR>'
nnoremap <expr> <Space>feM ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Space>fee ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.EnvrcRoot().'<CR>'
nnoremap <expr> <Space>feE ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Space>fe<C-e> ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Space>feb ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.g:starting_path.'<CR>'
nnoremap <expr> <Space>fe1 ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.Bp(1).'<CR>'
nnoremap <expr> <Space>fe2 ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.Bp(2).'<CR>'
nnoremap <expr> <Space>fe3 ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.Bp(3).'<CR>'
nnoremap <expr> <Space>fe4 ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.Bp(4).'<CR>'
nnoremap <expr> <Space>fe5 ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.Bp(5).'<CR>'
nnoremap <expr> <Space>fe6 ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.Bp(6).'<CR>'
nnoremap <expr> <Space>fe7 ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.Bp(7).'<CR>'
nnoremap <expr> <Space>fe8 ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.Bp(8).'<CR>'
nnoremap <expr> <Space>fe9 ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.Bp(9).'<CR>'
nnoremap <expr> <Space>fe10 ':<C-u>Sgrep '.Expand('<cexpr>').' -r '.Bp(10).'<CR>'

nnoremap <expr> <Space>fyf ':<C-u>Sgrep '.Vescape(@").' %<CR>'
nnoremap <expr> <Space>fyF ':<C-u>Sgrep '.Vescape(@").' #<CR>'
nnoremap <expr> <Space>fya ':<C-u>Sgrep '.Vescape(@").' ##<CR>'
nnoremap <expr> <Space>fyl ':<C-u>Sgrep '.Vescape(@").' * .*<CR>'
nnoremap <expr> <Space>fyL ':<C-u>Sgrep '.Vescape(@").' *<CR>'
nnoremap <expr> <Space>fyr ':<C-u>Sgrep '.Vescape(@").' -r .<CR>'
nnoremap <expr> <Space>fyg ':<C-u>Sgrep '.Vescape(@").' -r '.GitRoot().'<CR>'
nnoremap <expr> <Space>fyG ':<C-u>Sgrep '.Vescape(@").' -r '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Space>fym ':<C-u>Sgrep '.Vescape(@").' -r '.HgRoot().'<CR>'
nnoremap <expr> <Space>fyM ':<C-u>Sgrep '.Vescape(@").' -r '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Space>fye ':<C-u>Sgrep '.Vescape(@").' -r '.EnvrcRoot().'<CR>'
nnoremap <expr> <Space>fyE ':<C-u>Sgrep '.Vescape(@").' -r '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Space>fy<C-e> ':<C-u>Sgrep '.Vescape(@").' -r '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Space>fyb ':<C-u>Sgrep '.Vescape(@").' -r '.g:starting_path.'<CR>'
nnoremap <expr> <Space>fy1 ':<C-u>Sgrep '.Vescape(@").' -r '.Bp(1).'<CR>'
nnoremap <expr> <Space>fy2 ':<C-u>Sgrep '.Vescape(@").' -r '.Bp(2).'<CR>'
nnoremap <expr> <Space>fy3 ':<C-u>Sgrep '.Vescape(@").' -r '.Bp(3).'<CR>'
nnoremap <expr> <Space>fy4 ':<C-u>Sgrep '.Vescape(@").' -r '.Bp(4).'<CR>'
nnoremap <expr> <Space>fy5 ':<C-u>Sgrep '.Vescape(@").' -r '.Bp(5).'<CR>'
nnoremap <expr> <Space>fy6 ':<C-u>Sgrep '.Vescape(@").' -r '.Bp(6).'<CR>'
nnoremap <expr> <Space>fy7 ':<C-u>Sgrep '.Vescape(@").' -r '.Bp(7).'<CR>'
nnoremap <expr> <Space>fy8 ':<C-u>Sgrep '.Vescape(@").' -r '.Bp(8).'<CR>'
nnoremap <expr> <Space>fy9 ':<C-u>Sgrep '.Vescape(@").' -r '.Bp(9).'<CR>'
nnoremap <expr> <Space>fy10 ':<C-u>Sgrep '.Vescape(@").' -r '.Bp(10).'<CR>'

nnoremap <expr> <Space>fgf ':<C-u>Sgrep '.Vescape(@*).' %<CR>'
nnoremap <expr> <Space>fgF ':<C-u>Sgrep '.Vescape(@*).' #<CR>'
nnoremap <expr> <Space>fga ':<C-u>Sgrep '.Vescape(@*).' ##<CR>'
nnoremap <expr> <Space>fgl ':<C-u>Sgrep '.Vescape(@*).' * .*<CR>'
nnoremap <expr> <Space>fgL ':<C-u>Sgrep '.Vescape(@*).' *<CR>'
nnoremap <expr> <Space>fgr ':<C-u>Sgrep '.Vescape(@*).' -r .<CR>'
nnoremap <expr> <Space>fgg ':<C-u>Sgrep '.Vescape(@*).' -r '.GitRoot().'<CR>'
nnoremap <expr> <Space>fgG ':<C-u>Sgrep '.Vescape(@*).' -r '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Space>fgm ':<C-u>Sgrep '.Vescape(@*).' -r '.HgRoot().'<CR>'
nnoremap <expr> <Space>fgM ':<C-u>Sgrep '.Vescape(@*).' -r '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Space>fge ':<C-u>Sgrep '.Vescape(@*).' -r '.EnvrcRoot().'<CR>'
nnoremap <expr> <Space>fgE ':<C-u>Sgrep '.Vescape(@*).' -r '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Space>fg<C-e> ':<C-u>Sgrep '.Vescape(@*).' -r '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Space>fgb ':<C-u>Sgrep '.Vescape(@*).' -r '.g:starting_path.'<CR>'
nnoremap <expr> <Space>fg1 ':<C-u>Sgrep '.Vescape(@*).' -r '.Bp(1).'<CR>'
nnoremap <expr> <Space>fg2 ':<C-u>Sgrep '.Vescape(@*).' -r '.Bp(2).'<CR>'
nnoremap <expr> <Space>fg3 ':<C-u>Sgrep '.Vescape(@*).' -r '.Bp(3).'<CR>'
nnoremap <expr> <Space>fg4 ':<C-u>Sgrep '.Vescape(@*).' -r '.Bp(4).'<CR>'
nnoremap <expr> <Space>fg5 ':<C-u>Sgrep '.Vescape(@*).' -r '.Bp(5).'<CR>'
nnoremap <expr> <Space>fg6 ':<C-u>Sgrep '.Vescape(@*).' -r '.Bp(6).'<CR>'
nnoremap <expr> <Space>fg7 ':<C-u>Sgrep '.Vescape(@*).' -r '.Bp(7).'<CR>'
nnoremap <expr> <Space>fg8 ':<C-u>Sgrep '.Vescape(@*).' -r '.Bp(8).'<CR>'
nnoremap <expr> <Space>fg9 ':<C-u>Sgrep '.Vescape(@*).' -r '.Bp(9).'<CR>'
nnoremap <expr> <Space>fg10 ':<C-u>Sgrep '.Vescape(@*).' -r '.Bp(10).'<CR>'

nnoremap <expr> <Space>fpf ':<C-u>Sgrep '.Vescape(@+).' %<CR>'
nnoremap <expr> <Space>fpF ':<C-u>Sgrep '.Vescape(@+).' #<CR>'
nnoremap <expr> <Space>fpa ':<C-u>Sgrep '.Vescape(@+).' ##<CR>'
nnoremap <expr> <Space>fpl ':<C-u>Sgrep '.Vescape(@+).' * .*<CR>'
nnoremap <expr> <Space>fpL ':<C-u>Sgrep '.Vescape(@+).' *<CR>'
nnoremap <expr> <Space>fpr ':<C-u>Sgrep '.Vescape(@+).' -r .<CR>'
nnoremap <expr> <Space>fpg ':<C-u>Sgrep '.Vescape(@+).' -r '.GitRoot().'<CR>'
nnoremap <expr> <Space>fpG ':<C-u>Sgrep '.Vescape(@+).' -r '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Space>fpm ':<C-u>Sgrep '.Vescape(@+).' -r '.HgRoot().'<CR>'
nnoremap <expr> <Space>fpM ':<C-u>Sgrep '.Vescape(@+).' -r '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Space>fpe ':<C-u>Sgrep '.Vescape(@+).' -r '.EnvrcRoot().'<CR>'
nnoremap <expr> <Space>fpE ':<C-u>Sgrep '.Vescape(@+).' -r '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Space>fp<C-e> ':<C-u>Sgrep '.Vescape(@+).' -r '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Space>fpb ':<C-u>Sgrep '.Vescape(@+).' -r '.g:starting_path.'<CR>'
nnoremap <expr> <Space>fp1 ':<C-u>Sgrep '.Vescape(@+).' -r '.Bp(1).'<CR>'
nnoremap <expr> <Space>fp2 ':<C-u>Sgrep '.Vescape(@+).' -r '.Bp(2).'<CR>'
nnoremap <expr> <Space>fp3 ':<C-u>Sgrep '.Vescape(@+).' -r '.Bp(3).'<CR>'
nnoremap <expr> <Space>fp4 ':<C-u>Sgrep '.Vescape(@+).' -r '.Bp(4).'<CR>'
nnoremap <expr> <Space>fp5 ':<C-u>Sgrep '.Vescape(@+).' -r '.Bp(5).'<CR>'
nnoremap <expr> <Space>fp6 ':<C-u>Sgrep '.Vescape(@+).' -r '.Bp(6).'<CR>'
nnoremap <expr> <Space>fp7 ':<C-u>Sgrep '.Vescape(@+).' -r '.Bp(7).'<CR>'
nnoremap <expr> <Space>fp8 ':<C-u>Sgrep '.Vescape(@+).' -r '.Bp(8).'<CR>'
nnoremap <expr> <Space>fp9 ':<C-u>Sgrep '.Vescape(@+).' -r '.Bp(9).'<CR>'
nnoremap <expr> <Space>fp10 ':<C-u>Sgrep '.Vescape(@+).' -r '.Bp(10).'<CR>'

nnoremap <expr> <Space>fsf ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' %<CR>'
nnoremap <expr> <Space>fsF ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' #<CR>'
nnoremap <expr> <Space>fsa ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' ##<CR>'
nnoremap <expr> <Space>fsl ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' * .*<CR>'
nnoremap <expr> <Space>fsL ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' *<CR>'
nnoremap <expr> <Space>fsr ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r .<CR>'
nnoremap <expr> <Space>fsg ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.GitRoot().'<CR>'
nnoremap <expr> <Space>fsG ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Space>fsm ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.HgRoot().'<CR>'
nnoremap <expr> <Space>fsM ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Space>fse ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.EnvrcRoot().'<CR>'
nnoremap <expr> <Space>fsE ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Space>fs<C-e> ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Space>fsb ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.g:starting_path.'<CR>'
nnoremap <expr> <Space>fs1 ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.Bp(1).'<CR>'
nnoremap <expr> <Space>fs2 ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.Bp(2).'<CR>'
nnoremap <expr> <Space>fs3 ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.Bp(3).'<CR>'
nnoremap <expr> <Space>fs4 ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.Bp(4).'<CR>'
nnoremap <expr> <Space>fs5 ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.Bp(5).'<CR>'
nnoremap <expr> <Space>fs6 ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.Bp(6).'<CR>'
nnoremap <expr> <Space>fs7 ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.Bp(7).'<CR>'
nnoremap <expr> <Space>fs8 ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.Bp(8).'<CR>'
nnoremap <expr> <Space>fs9 ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.Bp(9).'<CR>'
nnoremap <expr> <Space>fs10 ':<C-u>Sgrep '.Vescape(GetVisualSelection()).' -r '.Bp(10).'<CR>'
" }}}

" ripgrep {{{

command -nargs=+ -complete=file Crg
        \ cgetexpr Fgrep(s:rg_prog, <f-args>)
command -nargs=+ -complete=file Lrg
        \ lgetexpr Fgrep(s:rg_prog, <f-args>)
            

command -nargs=+ -complete=file Srg
      \ if g:qfloc
      \ | exe 'Lrg '.<q-args>
      \ | else
      \ | exe 'Crg '.<q-args>
      \ | endif

command -nargs=+ -complete=file Wrg
      \ exe 'Srg '.<q-args>
      \ | call QFcmd('open')
        

nnoremap <expr> <Leader>rc ':<C-u>Srg '
nnoremap <expr> <Leader>r<Space>f ':<C-u>Srg  % <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>F ':<C-u>Srg  # <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>a ':<C-u>Srg  ## <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>l ':<C-u>Srg  --max-depth 0 * .* <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>L ':<C-u>Srg  --max-depth 0 * <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>r ':<C-u>Srg  --hidden . <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>g ':<C-u>Srg  --hidden '.GitRoot().' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>G ':<C-u>Srg  --hidden '.GitRoot(GitRoot().'/..').' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>m ':<C-u>Srg  --hidden '.HgRoot().' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>M ':<C-u>Srg  --hidden '.HgRoot(HgRoot().'/..').' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>e ':<C-u>Srg  --hidden '.EnvrcRoot().' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>E ':<C-u>Srg  --hidden '.EnvrcRoot(EnvrcRoot().'/..').' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space><C-e> ':<C-u>Srg  --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>b ':<C-u>Srg  --hidden '.g:starting_path.' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>1 ':<C-u>Srg  --hidden '.Bp(1).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>2 ':<C-u>Srg  --hidden '.Bp(2).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>3 ':<C-u>Srg  --hidden '.Bp(3).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>4 ':<C-u>Srg  --hidden '.Bp(4).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>5 ':<C-u>Srg  --hidden '.Bp(5).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>6 ':<C-u>Srg  --hidden '.Bp(6).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>7 ':<C-u>Srg  --hidden '.Bp(7).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>8 ':<C-u>Srg  --hidden '.Bp(8).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>9 ':<C-u>Srg  --hidden '.Bp(9).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>r<Space>R ':<C-u>Srg  . <Home><C-Right><Right>'
nnoremap <expr> <Leader>ru<Space> ':<C-u>Srg '.Expand('<cword>').' '
nnoremap <expr> <Leader>rw<Space> ':<C-u>Srg '.Expand('<cWORD>').' '
nnoremap <expr> <Leader>re<Space> ':<C-u>Srg '.Expand('<cexpr>').' '
nnoremap <expr> <Leader>ry<Space> ':<C-u>Srg '.Vescape(@").' '
nnoremap <expr> <Leader>rg<Space> ':<C-u>Srg '.Vescape(@*).' '
nnoremap <expr> <Leader>rp<Space> ':<C-u>Srg '.Vescape(@+).' '
nnoremap <expr> <Leader>rs<Space> ':<C-u>Srg '.Vescape(GetVisualSelection()).' '


nnoremap <expr> <Leader>ruf ':<C-u>Srg '.Expand('<cword>').' %<CR>'
nnoremap <expr> <Leader>ruF ':<C-u>Srg '.Expand('<cword>').' #<CR>'
nnoremap <expr> <Leader>rua ':<C-u>Srg '.Expand('<cword>').' ##<CR>'
nnoremap <expr> <Leader>rul ':<C-u>Srg '.Expand('<cword>').' --max-depth 0 * .*<CR>'
nnoremap <expr> <Leader>ruL ':<C-u>Srg '.Expand('<cword>').' --max-depth 0 *<CR>'
nnoremap <expr> <Leader>rur ':<C-u>Srg '.Expand('<cword>').' --hidden .<CR>'
nnoremap <expr> <Leader>rug ':<C-u>Srg '.Expand('<cword>').' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>ruG ':<C-u>Srg '.Expand('<cword>').' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rum ':<C-u>Srg '.Expand('<cword>').' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>ruM ':<C-u>Srg '.Expand('<cword>').' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rue ':<C-u>Srg '.Expand('<cword>').' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>ruE ':<C-u>Srg '.Expand('<cword>').' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>ru<C-e> ':<C-u>Srg '.Expand('<cword>').' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>rub ':<C-u>Srg '.Expand('<cword>').' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>ru1 ':<C-u>Srg '.Expand('<cword>').' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>ru2 ':<C-u>Srg '.Expand('<cword>').' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>ru3 ':<C-u>Srg '.Expand('<cword>').' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>ru4 ':<C-u>Srg '.Expand('<cword>').' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>ru5 ':<C-u>Srg '.Expand('<cword>').' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>ru6 ':<C-u>Srg '.Expand('<cword>').' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>ru7 ':<C-u>Srg '.Expand('<cword>').' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>ru8 ':<C-u>Srg '.Expand('<cword>').' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>ru9 ':<C-u>Srg '.Expand('<cword>').' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>ruR ':<C-u>Srg '.Expand('<cword>').' .<CR>'

nnoremap <expr> <Leader>rwf ':<C-u>Srg '.Expand('<cWORD>').' %<CR>'
nnoremap <expr> <Leader>rwF ':<C-u>Srg '.Expand('<cWORD>').' #<CR>'
nnoremap <expr> <Leader>rwa ':<C-u>Srg '.Expand('<cWORD>').' ##<CR>'
nnoremap <expr> <Leader>rwl ':<C-u>Srg '.Expand('<cWORD>').' --max-depth 0 * .*<CR>'
nnoremap <expr> <Leader>rwL ':<C-u>Srg '.Expand('<cWORD>').' --max-depth 0 *<CR>'
nnoremap <expr> <Leader>rwr ':<C-u>Srg '.Expand('<cWORD>').' --hidden .<CR>'
nnoremap <expr> <Leader>rwg ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>rwG ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rwm ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>rwM ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rwe ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>rwE ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rw<C-e> ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>rwb ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>rw1 ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>rw2 ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>rw3 ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>rw4 ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>rw5 ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>rw6 ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>rw7 ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>rw8 ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>rw9 ':<C-u>Srg '.Expand('<cWORD>').' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>rwR ':<C-u>Srg '.Expand('<cWORD>').' .<CR>'

nnoremap <expr> <Leader>ref ':<C-u>Srg '.Expand('<cexpr>').' %<CR>'
nnoremap <expr> <Leader>reF ':<C-u>Srg '.Expand('<cexpr>').' #<CR>'
nnoremap <expr> <Leader>rea ':<C-u>Srg '.Expand('<cexpr>').' ##<CR>'
nnoremap <expr> <Leader>rel ':<C-u>Srg '.Expand('<cexpr>').' --max-depth 0 * .*<CR>'
nnoremap <expr> <Leader>reL ':<C-u>Srg '.Expand('<cexpr>').' --max-depth 0 *<CR>'
nnoremap <expr> <Leader>rer ':<C-u>Srg '.Expand('<cexpr>').' --hidden .<CR>'
nnoremap <expr> <Leader>reg ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>reG ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rem ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>reM ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>ree ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>reE ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>re<C-e> ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>reb ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>re1 ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>re2 ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>re3 ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>re4 ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>re5 ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>re6 ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>re7 ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>re8 ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>re9 ':<C-u>Srg '.Expand('<cexpr>').' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>reR ':<C-u>Srg '.Expand('<cexpr>').' .<CR>'

nnoremap <expr> <Leader>ryf ':<C-u>Srg '.Vescape(@").' %<CR>'
nnoremap <expr> <Leader>ryF ':<C-u>Srg '.Vescape(@").' #<CR>'
nnoremap <expr> <Leader>rya ':<C-u>Srg '.Vescape(@").' ##<CR>'
nnoremap <expr> <Leader>ryl ':<C-u>Srg '.Vescape(@").' --max-depth 0 * .*<CR>'
nnoremap <expr> <Leader>ryL ':<C-u>Srg '.Vescape(@").' --max-depth 0 *<CR>'
nnoremap <expr> <Leader>ryr ':<C-u>Srg '.Vescape(@").' --hidden .<CR>'
nnoremap <expr> <Leader>ryg ':<C-u>Srg '.Vescape(@").' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>ryG ':<C-u>Srg '.Vescape(@").' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rym ':<C-u>Srg '.Vescape(@").' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>ryM ':<C-u>Srg '.Vescape(@").' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rye ':<C-u>Srg '.Vescape(@").' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>ryE ':<C-u>Srg '.Vescape(@").' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>ry<C-e> ':<C-u>Srg '.Vescape(@").' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>ryb ':<C-u>Srg '.Vescape(@").' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>ry1 ':<C-u>Srg '.Vescape(@").' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>ry2 ':<C-u>Srg '.Vescape(@").' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>ry3 ':<C-u>Srg '.Vescape(@").' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>ry4 ':<C-u>Srg '.Vescape(@").' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>ry5 ':<C-u>Srg '.Vescape(@").' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>ry6 ':<C-u>Srg '.Vescape(@").' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>ry7 ':<C-u>Srg '.Vescape(@").' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>ry8 ':<C-u>Srg '.Vescape(@").' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>ry9 ':<C-u>Srg '.Vescape(@").' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>ryR ':<C-u>Srg '.Vescape(@").' .<CR>'

nnoremap <expr> <Leader>rgf ':<C-u>Srg '.Vescape(@*).' %<CR>'
nnoremap <expr> <Leader>rgF ':<C-u>Srg '.Vescape(@*).' #<CR>'
nnoremap <expr> <Leader>rga ':<C-u>Srg '.Vescape(@*).' ##<CR>'
nnoremap <expr> <Leader>rgl ':<C-u>Srg '.Vescape(@*).' --max-depth 0 * .*<CR>'
nnoremap <expr> <Leader>rgL ':<C-u>Srg '.Vescape(@*).' --max-depth 0 *<CR>'
nnoremap <expr> <Leader>rgr ':<C-u>Srg '.Vescape(@*).' --hidden .<CR>'
nnoremap <expr> <Leader>rgg ':<C-u>Srg '.Vescape(@*).' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>rgG ':<C-u>Srg '.Vescape(@*).' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rgm ':<C-u>Srg '.Vescape(@*).' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>rgM ':<C-u>Srg '.Vescape(@*).' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rge ':<C-u>Srg '.Vescape(@*).' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>rgE ':<C-u>Srg '.Vescape(@*).' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rg<C-e> ':<C-u>Srg '.Vescape(@*).' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>rgb ':<C-u>Srg '.Vescape(@*).' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>rg1 ':<C-u>Srg '.Vescape(@*).' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>rg2 ':<C-u>Srg '.Vescape(@*).' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>rg3 ':<C-u>Srg '.Vescape(@*).' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>rg4 ':<C-u>Srg '.Vescape(@*).' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>rg5 ':<C-u>Srg '.Vescape(@*).' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>rg6 ':<C-u>Srg '.Vescape(@*).' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>rg7 ':<C-u>Srg '.Vescape(@*).' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>rg8 ':<C-u>Srg '.Vescape(@*).' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>rg9 ':<C-u>Srg '.Vescape(@*).' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>rgR ':<C-u>Srg '.Vescape(@*).' .<CR>'

nnoremap <expr> <Leader>rpf ':<C-u>Srg '.Vescape(@+).' %<CR>'
nnoremap <expr> <Leader>rpF ':<C-u>Srg '.Vescape(@+).' #<CR>'
nnoremap <expr> <Leader>rpa ':<C-u>Srg '.Vescape(@+).' ##<CR>'
nnoremap <expr> <Leader>rpl ':<C-u>Srg '.Vescape(@+).' --max-depth 0 * .*<CR>'
nnoremap <expr> <Leader>rpL ':<C-u>Srg '.Vescape(@+).' --max-depth 0 *<CR>'
nnoremap <expr> <Leader>rpr ':<C-u>Srg '.Vescape(@+).' --hidden .<CR>'
nnoremap <expr> <Leader>rpg ':<C-u>Srg '.Vescape(@+).' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>rpG ':<C-u>Srg '.Vescape(@+).' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rpm ':<C-u>Srg '.Vescape(@+).' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>rpM ':<C-u>Srg '.Vescape(@+).' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rpe ':<C-u>Srg '.Vescape(@+).' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>rpE ':<C-u>Srg '.Vescape(@+).' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rp<C-e> ':<C-u>Srg '.Vescape(@+).' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>rpb ':<C-u>Srg '.Vescape(@+).' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>rp1 ':<C-u>Srg '.Vescape(@+).' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>rp2 ':<C-u>Srg '.Vescape(@+).' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>rp3 ':<C-u>Srg '.Vescape(@+).' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>rp4 ':<C-u>Srg '.Vescape(@+).' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>rp5 ':<C-u>Srg '.Vescape(@+).' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>rp6 ':<C-u>Srg '.Vescape(@+).' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>rp7 ':<C-u>Srg '.Vescape(@+).' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>rp8 ':<C-u>Srg '.Vescape(@+).' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>rp9 ':<C-u>Srg '.Vescape(@+).' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>rpR ':<C-u>Srg '.Vescape(@+).' .<CR>'

nnoremap <expr> <Leader>rsf ':<C-u>Srg '.Vescape(GetVisualSelection()).' %<CR>'
nnoremap <expr> <Leader>rsF ':<C-u>Srg '.Vescape(GetVisualSelection()).' #<CR>'
nnoremap <expr> <Leader>rsa ':<C-u>Srg '.Vescape(GetVisualSelection()).' ##<CR>'
nnoremap <expr> <Leader>rsl ':<C-u>Srg '.Vescape(GetVisualSelection()).' --max-depth 0 * .*<CR>'
nnoremap <expr> <Leader>rsL ':<C-u>Srg '.Vescape(GetVisualSelection()).' --max-depth 0 *<CR>'
nnoremap <expr> <Leader>rsr ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden .<CR>'
nnoremap <expr> <Leader>rsg ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>rsG ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rsm ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>rsM ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rse ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>rsE ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>rs<C-e> ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>rsb ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>rs1 ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>rs2 ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>rs3 ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>rs4 ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>rs5 ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>rs6 ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>rs7 ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>rs8 ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>rs9 ':<C-u>Srg '.Vescape(GetVisualSelection()).' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>rsR ':<C-u>Srg '.Vescape(GetVisualSelection()).' .<CR>'
" }}}

" silver searcher {{{

command -nargs=+ -complete=file Cag
        \ cgetexpr Fgrep(s:ag_prog, <f-args>)
command -nargs=+ -complete=file Lag
        \ lgetexpr Fgrep(s:ag_prog, <f-args>)
            

command -nargs=+ -complete=file Sag
      \ if g:qfloc
      \ | exe 'Lag '.<q-args>
      \ | else
      \ | exe 'Cag '.<q-args>
      \ | endif

command -nargs=+ -complete=file Wag
      \ exe 'Sag '.<q-args>
      \ | call QFcmd('open')
        

nnoremap <expr> <Leader>ac ':<C-u>Sag '
nnoremap <expr> <Leader>a<Space>f ':<C-u>Sag  % <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>F ':<C-u>Sag  # <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>a ':<C-u>Sag  ## <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>l ':<C-u>Sag  --depth 0 * .* <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>L ':<C-u>Sag  --depth 0 * <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>r ':<C-u>Sag  --hidden . <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>g ':<C-u>Sag  --hidden '.GitRoot().' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>G ':<C-u>Sag  --hidden '.GitRoot(GitRoot().'/..').' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>m ':<C-u>Sag  --hidden '.HgRoot().' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>M ':<C-u>Sag  --hidden '.HgRoot(HgRoot().'/..').' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>e ':<C-u>Sag  --hidden '.EnvrcRoot().' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>E ':<C-u>Sag  --hidden '.EnvrcRoot(EnvrcRoot().'/..').' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space><C-e> ':<C-u>Sag  --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>b ':<C-u>Sag  --hidden '.g:starting_path.' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>1 ':<C-u>Sag  --hidden '.Bp(1).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>2 ':<C-u>Sag  --hidden '.Bp(2).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>3 ':<C-u>Sag  --hidden '.Bp(3).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>4 ':<C-u>Sag  --hidden '.Bp(4).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>5 ':<C-u>Sag  --hidden '.Bp(5).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>6 ':<C-u>Sag  --hidden '.Bp(6).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>7 ':<C-u>Sag  --hidden '.Bp(7).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>8 ':<C-u>Sag  --hidden '.Bp(8).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>9 ':<C-u>Sag  --hidden '.Bp(9).' <Home><C-Right><Right>'
nnoremap <expr> <Leader>a<Space>R ':<C-u>Sag  . <Home><C-Right><Right>'
nnoremap <expr> <Leader>au<Space> ':<C-u>Sag '.Expand('<cword>').' '
nnoremap <expr> <Leader>aw<Space> ':<C-u>Sag '.Expand('<cWORD>').' '
nnoremap <expr> <Leader>ae<Space> ':<C-u>Sag '.Expand('<cexpr>').' '
nnoremap <expr> <Leader>ay<Space> ':<C-u>Sag '.Vescape(@").' '
nnoremap <expr> <Leader>ag<Space> ':<C-u>Sag '.Vescape(@*).' '
nnoremap <expr> <Leader>ap<Space> ':<C-u>Sag '.Vescape(@+).' '
nnoremap <expr> <Leader>as<Space> ':<C-u>Sag '.Vescape(GetVisualSelection()).' '

nnoremap <expr> <Leader>auf ':<C-u>Sag '.Expand('<cword>').' %<CR>'
nnoremap <expr> <Leader>auF ':<C-u>Sag '.Expand('<cword>').' #<CR>'
nnoremap <expr> <Leader>aua ':<C-u>Sag '.Expand('<cword>').' ##<CR>'
nnoremap <expr> <Leader>aul ':<C-u>Sag '.Expand('<cword>').' --depth 0 * .*<CR>'
nnoremap <expr> <Leader>auL ':<C-u>Sag '.Expand('<cword>').' --depth 0 *<CR>'
nnoremap <expr> <Leader>aur ':<C-u>Sag '.Expand('<cword>').' --hidden .<CR>'
nnoremap <expr> <Leader>aug ':<C-u>Sag '.Expand('<cword>').' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>auG ':<C-u>Sag '.Expand('<cword>').' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>aum ':<C-u>Sag '.Expand('<cword>').' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>auM ':<C-u>Sag '.Expand('<cword>').' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>aue ':<C-u>Sag '.Expand('<cword>').' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>auE ':<C-u>Sag '.Expand('<cword>').' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>au<C-e> ':<C-u>Sag '.Expand('<cword>').' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>aub ':<C-u>Sag '.Expand('<cword>').' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>au1 ':<C-u>Sag '.Expand('<cword>').' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>au2 ':<C-u>Sag '.Expand('<cword>').' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>au3 ':<C-u>Sag '.Expand('<cword>').' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>au4 ':<C-u>Sag '.Expand('<cword>').' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>au5 ':<C-u>Sag '.Expand('<cword>').' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>au6 ':<C-u>Sag '.Expand('<cword>').' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>au7 ':<C-u>Sag '.Expand('<cword>').' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>au8 ':<C-u>Sag '.Expand('<cword>').' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>au9 ':<C-u>Sag '.Expand('<cword>').' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>auR ':<C-u>Sag '.Expand('<cword>').' .<CR>'

nnoremap <expr> <Leader>awf ':<C-u>Sag '.Expand('<cWORD>').' %<CR>'
nnoremap <expr> <Leader>awF ':<C-u>Sag '.Expand('<cWORD>').' #<CR>'
nnoremap <expr> <Leader>awa ':<C-u>Sag '.Expand('<cWORD>').' ##<CR>'
nnoremap <expr> <Leader>awl ':<C-u>Sag '.Expand('<cWORD>').' --depth 0 * .*<CR>'
nnoremap <expr> <Leader>awL ':<C-u>Sag '.Expand('<cWORD>').' --depth 0 *<CR>'
nnoremap <expr> <Leader>awr ':<C-u>Sag '.Expand('<cWORD>').' --hidden .<CR>'
nnoremap <expr> <Leader>awg ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>awG ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>awm ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>awM ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>awe ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>awE ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>aw<C-e> ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>awb ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>aw1 ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>aw2 ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>aw3 ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>aw4 ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>aw5 ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>aw6 ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>aw7 ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>aw8 ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>aw9 ':<C-u>Sag '.Expand('<cWORD>').' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>awR ':<C-u>Sag '.Expand('<cWORD>').' .<CR>'

nnoremap <expr> <Leader>aef ':<C-u>Sag '.Expand('<cexpr>').' %<CR>'
nnoremap <expr> <Leader>aeF ':<C-u>Sag '.Expand('<cexpr>').' #<CR>'
nnoremap <expr> <Leader>aea ':<C-u>Sag '.Expand('<cexpr>').' ##<CR>'
nnoremap <expr> <Leader>ael ':<C-u>Sag '.Expand('<cexpr>').' --depth 0 * .*<CR>'
nnoremap <expr> <Leader>aeL ':<C-u>Sag '.Expand('<cexpr>').' --depth 0 *<CR>'
nnoremap <expr> <Leader>aer ':<C-u>Sag '.Expand('<cexpr>').' --hidden .<CR>'
nnoremap <expr> <Leader>aeg ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>aeG ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>aem ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>aeM ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>aee ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>aeE ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>ae<C-e> ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>aeb ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>ae1 ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>ae2 ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>ae3 ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>ae4 ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>ae5 ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>ae6 ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>ae7 ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>ae8 ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>ae9 ':<C-u>Sag '.Expand('<cexpr>').' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>aeR ':<C-u>Sag '.Expand('<cexpr>').' .<CR>'

nnoremap <expr> <Leader>ayf ':<C-u>Sag '.Vescape(@").' %<CR>'
nnoremap <expr> <Leader>ayF ':<C-u>Sag '.Vescape(@").' #<CR>'
nnoremap <expr> <Leader>aya ':<C-u>Sag '.Vescape(@").' ##<CR>'
nnoremap <expr> <Leader>ayl ':<C-u>Sag '.Vescape(@").' --depth 0 * .*<CR>'
nnoremap <expr> <Leader>ayL ':<C-u>Sag '.Vescape(@").' --depth 0 *<CR>'
nnoremap <expr> <Leader>ayr ':<C-u>Sag '.Vescape(@").' --hidden .<CR>'
nnoremap <expr> <Leader>ayg ':<C-u>Sag '.Vescape(@").' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>ayG ':<C-u>Sag '.Vescape(@").' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>aym ':<C-u>Sag '.Vescape(@").' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>ayM ':<C-u>Sag '.Vescape(@").' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>aye ':<C-u>Sag '.Vescape(@").' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>ayE ':<C-u>Sag '.Vescape(@").' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>ay<C-e> ':<C-u>Sag '.Vescape(@").' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>ayb ':<C-u>Sag '.Vescape(@").' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>ay1 ':<C-u>Sag '.Vescape(@").' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>ay2 ':<C-u>Sag '.Vescape(@").' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>ay3 ':<C-u>Sag '.Vescape(@").' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>ay4 ':<C-u>Sag '.Vescape(@").' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>ay5 ':<C-u>Sag '.Vescape(@").' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>ay6 ':<C-u>Sag '.Vescape(@").' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>ay7 ':<C-u>Sag '.Vescape(@").' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>ay8 ':<C-u>Sag '.Vescape(@").' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>ay9 ':<C-u>Sag '.Vescape(@").' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>ayR ':<C-u>Sag '.Vescape(@").' .<CR>'

nnoremap <expr> <Leader>agf ':<C-u>Sag '.Vescape(@*).' %<CR>'
nnoremap <expr> <Leader>agF ':<C-u>Sag '.Vescape(@*).' #<CR>'
nnoremap <expr> <Leader>aga ':<C-u>Sag '.Vescape(@*).' ##<CR>'
nnoremap <expr> <Leader>agl ':<C-u>Sag '.Vescape(@*).' --depth 0 * .*<CR>'
nnoremap <expr> <Leader>agL ':<C-u>Sag '.Vescape(@*).' --depth 0 *<CR>'
nnoremap <expr> <Leader>agr ':<C-u>Sag '.Vescape(@*).' --hidden .<CR>'
nnoremap <expr> <Leader>agg ':<C-u>Sag '.Vescape(@*).' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>agG ':<C-u>Sag '.Vescape(@*).' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>agm ':<C-u>Sag '.Vescape(@*).' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>agM ':<C-u>Sag '.Vescape(@*).' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>age ':<C-u>Sag '.Vescape(@*).' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>agE ':<C-u>Sag '.Vescape(@*).' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>ag<C-e> ':<C-u>Sag '.Vescape(@*).' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>agb ':<C-u>Sag '.Vescape(@*).' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>ag1 ':<C-u>Sag '.Vescape(@*).' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>ag2 ':<C-u>Sag '.Vescape(@*).' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>ag3 ':<C-u>Sag '.Vescape(@*).' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>ag4 ':<C-u>Sag '.Vescape(@*).' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>ag5 ':<C-u>Sag '.Vescape(@*).' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>ag6 ':<C-u>Sag '.Vescape(@*).' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>ag7 ':<C-u>Sag '.Vescape(@*).' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>ag8 ':<C-u>Sag '.Vescape(@*).' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>ag9 ':<C-u>Sag '.Vescape(@*).' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>agR ':<C-u>Sag '.Vescape(@*).' .<CR>'

nnoremap <expr> <Leader>apf ':<C-u>Sag '.Vescape(@+).' %<CR>'
nnoremap <expr> <Leader>apF ':<C-u>Sag '.Vescape(@+).' #<CR>'
nnoremap <expr> <Leader>apa ':<C-u>Sag '.Vescape(@+).' ##<CR>'
nnoremap <expr> <Leader>apl ':<C-u>Sag '.Vescape(@+).' --depth 0 * .*<CR>'
nnoremap <expr> <Leader>apL ':<C-u>Sag '.Vescape(@+).' --depth 0 *<CR>'
nnoremap <expr> <Leader>apr ':<C-u>Sag '.Vescape(@+).' --hidden .<CR>'
nnoremap <expr> <Leader>apg ':<C-u>Sag '.Vescape(@+).' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>apG ':<C-u>Sag '.Vescape(@+).' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>apm ':<C-u>Sag '.Vescape(@+).' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>apM ':<C-u>Sag '.Vescape(@+).' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>ape ':<C-u>Sag '.Vescape(@+).' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>apE ':<C-u>Sag '.Vescape(@+).' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>ap<C-e> ':<C-u>Sag '.Vescape(@+).' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>apb ':<C-u>Sag '.Vescape(@+).' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>ap1 ':<C-u>Sag '.Vescape(@+).' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>ap2 ':<C-u>Sag '.Vescape(@+).' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>ap3 ':<C-u>Sag '.Vescape(@+).' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>ap4 ':<C-u>Sag '.Vescape(@+).' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>ap5 ':<C-u>Sag '.Vescape(@+).' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>ap6 ':<C-u>Sag '.Vescape(@+).' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>ap7 ':<C-u>Sag '.Vescape(@+).' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>ap8 ':<C-u>Sag '.Vescape(@+).' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>ap9 ':<C-u>Sag '.Vescape(@+).' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>apR ':<C-u>Sag '.Vescape(@+).' .<CR>'

nnoremap <expr> <Leader>asf ':<C-u>Sag '.Vescape(GetVisualSelection()).' %<CR>'
nnoremap <expr> <Leader>asF ':<C-u>Sag '.Vescape(GetVisualSelection()).' #<CR>'
nnoremap <expr> <Leader>asa ':<C-u>Sag '.Vescape(GetVisualSelection()).' ##<CR>'
nnoremap <expr> <Leader>asl ':<C-u>Sag '.Vescape(GetVisualSelection()).' --depth 0 * .*<CR>'
nnoremap <expr> <Leader>asL ':<C-u>Sag '.Vescape(GetVisualSelection()).' --depth 0 *<CR>'
nnoremap <expr> <Leader>asr ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden .<CR>'
nnoremap <expr> <Leader>asg ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.GitRoot().'<CR>'
nnoremap <expr> <Leader>asG ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.GitRoot(GitRoot().'/..').'<CR>'
nnoremap <expr> <Leader>asm ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.HgRoot().'<CR>'
nnoremap <expr> <Leader>asM ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.HgRoot(HgRoot().'/..').'<CR>'
nnoremap <expr> <Leader>ase ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.EnvrcRoot().'<CR>'
nnoremap <expr> <Leader>asE ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.EnvrcRoot(EnvrcRoot().'/..').'<CR>'
nnoremap <expr> <Leader>as<C-e> ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'<CR>'
nnoremap <expr> <Leader>asb ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.g:starting_path.'<CR>'
nnoremap <expr> <Leader>as1 ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.Bp(1).'<CR>'
nnoremap <expr> <Leader>as2 ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.Bp(2).'<CR>'
nnoremap <expr> <Leader>as3 ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.Bp(3).'<CR>'
nnoremap <expr> <Leader>as4 ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.Bp(4).'<CR>'
nnoremap <expr> <Leader>as5 ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.Bp(5).'<CR>'
nnoremap <expr> <Leader>as6 ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.Bp(6).'<CR>'
nnoremap <expr> <Leader>as7 ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.Bp(7).'<CR>'
nnoremap <expr> <Leader>as8 ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.Bp(8).'<CR>'
nnoremap <expr> <Leader>as9 ':<C-u>Sag '.Vescape(GetVisualSelection()).' --hidden '.Bp(9).'<CR>'
nnoremap <expr> <Leader>asR ':<C-u>Sag '.Vescape(GetVisualSelection()).' .<CR>'
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

