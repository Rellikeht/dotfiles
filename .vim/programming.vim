" settings {{{ 

" from opam installation
set rtp^="~/.opam/default/share/ocp-indent/vim"

autocmd BufReadPre *
      \ let b:compilers = []

" Doesn't work :(
" autocmd BufNew,BufNewFile *
"       \ let b:compilers = []

" }}} 

" :make {{{ 

command -nargs=0 Smake
      \ if g:qfloc
      \| lmake
      \| else
      \| make
      \| endif

cnoreabbrev <expr> make (g:qfloc) ? 'lmake' : 'make'

nnoremap <expr> <Space>mr g:qfloc ?
      \ ':<C-u>lmake<CR>' : ':<C-u>make<CR>'
xnoremap <expr> <Space>mr g:qfloc ?
      \ ':<C-u>lmake\|norm gv<CR>' : ':<C-u>make\|norm gv<CR>'
nnoremap <expr> <Space>m<Space>r g:qfloc ?
      \ ':<C-u>lmake<Space>' : ':<C-u>make<Space>'
xnoremap <expr> <Space>m<Space>r g:qfloc ?
      \ ':<C-u>lmake  \|norm gv<C-Left><C-Left><Left>'
      \ ':<C-u>make  \|norm gv<C-Left><C-Left><Left>'

nnoremap <expr> <Space>me ':<C-u>setlocal makeprg='.&makeprg
xnoremap <expr> <Space>me
      \ ':<C-u>setlocal makeprg='.&makeprg.
      \ ' \|norm gv<C-Left><C-Left><Left>'

nnoremap <Space>mqp :<C-u>setlocal makeprg<CR>
nnoremap <Space>mp :<C-u>setlocal makeprg=
xnoremap <Space>mp :<C-u>setlocal makeprg= \|norm gv
      \ <C-Left><C-Left><Left>
nnoremap <Space>mqf :<C-u>setlocal errorformat<CR>
nnoremap <Space>mf :<C-u>setlocal errorformat=<Space>
xnoremap <Space>mf :<C-u>setlocal errorformat= \|norm gv
      \ <C-Left><C-Left><Left>

nnoremap <Space>mqP :<C-u>set makeprg<CR>
nnoremap <Space>mP :<C-u>set makeprg=
xnoremap <Space>mP :<C-u>set makeprg= \|norm gv
      \ <C-Left><C-Left><Left>
nnoremap <Space>mqF :<C-u>set errorformat<CR>
nnoremap <Space>mF :<C-u>set errorformat=<Space>
xnoremap <Space>mF :<C-u>set errorformat= \|norm gv
      \ <C-Left><C-Left><Left>

" }}} 

" compiler {{{ 

function CompleteCompiler(lead, cmdline, curpos)
  return CompleteList(b:compilers, a:lead, a:cmdline, a:curpos)
endfunction

command -nargs=1 -complete=customlist,CompleteCompiler SelectCompiler
      \ exe 'compiler '.<args>

nnoremap <Space>mc<Space> :<C-u>SelectCompiler<Space>
xnoremap <Space>mc<Space> :<C-u>SelectCompiler  \|norm gv
      \ <C-Left><C-Left><Left>

nnoremap <Space>mc; :<C-u>compiler<Space>
xnoremap <Space>mc; :<C-u>compiler  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space>mC; :<C-u>compiler!<Space>
xnoremap <Space>mC; :<C-u>compiler!  \|norm gv<C-Left><C-Left><Left>

" }}} 

" groff {{{ 

autocmd BufWritePost *.ms call CompileGroffMs()

let g:groff_pdf = 'groff -ktep -T pdf '

function CompileGroffMs()
  if get(b:, "bufcomp", 0)
    call system(g:groff_pdf.' -ms '.expand('%').' > '.expand('%:r').'.pdf')
  endif
endfunction

" }}} 
