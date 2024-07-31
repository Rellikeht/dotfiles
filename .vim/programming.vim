"{{{ settings

" from opam installation
set rtp^="~/.opam/default/share/ocp-indent/vim"

autocmd BufReadPre *
      \ let b:compilers = []

" Doesn't work :(
" autocmd BufNew,BufNewFile *
"       \ let b:compilers = []

"}}}

"{{{ :make

nnoremap expr <Space>mm g:qfloc ?
      \ ':<C-u>lmake<CR>' : ':<C-u>make<CR>'
vnoremap expr <Space>mm g:qfloc ?
      \ ':<C-u>lmake\|norm gv<CR>' : ':<C-u>make\|norm gv<CR>'
nnoremap expr <Space>m<Space>m g:qfloc ?
      \ ':<C-u>lmake<Space>' : ':<C-u>make<Space>'
vnoremap expr <Space>m<Space>m g:qfloc ?
      \ ':<C-u>lmake  \|norm gv<C-Left><C-Left><Left>'
      \ ':<C-u>make  \|norm gv<C-Left><C-Left><Left>'

nnoremap <Space>mp :<C-u>setlocal makeprg<CR>
nnoremap <Space>m<Space>p :<C-u>setlocal makeprg=
vnoremap <Space>m<Space>p :<C-u>setlocal makeprg= \|norm gv
      \ <C-Left><C-Left><Left>
nnoremap <Space>mf :<C-u>setlocal errorformat<CR>
nnoremap <Space>m<Space>f :<C-u>setlocal errorformat=<Space>
vnoremap <Space>m<Space>p :<C-u>setlocal errorformat= \|norm gv
      \ <C-Left><C-Left><Left>

nnoremap <Space>mP :<C-u>set makeprg<CR>
nnoremap <Space>m<Space>P :<C-u>set makeprg=
vnoremap <Space>m<Space>P :<C-u>set makeprg= \|norm gv
      \ <C-Left><C-Left><Left>
nnoremap <Space>mF :<C-u>set errorformat<CR>
nnoremap <Space>m<Space>F :<C-u>set errorformat=<Space>
vnoremap <Space>m<Space>P :<C-u>set errorformat= \|norm gv
      \ <C-Left><C-Left><Left>

"}}}

"{{{ compiler

function CompleteCompiler(lead, cmdline, curpos)
  return CompleteList(b:compilers, a:lead, a:cmdline, a:curpos)
endfunction

command -nargs=1 -complete=customlist,CompleteCompiler SelectCompiler
      \ exe 'compiler '.<args>

nnoremap <Space>mc<Space> :<C-u>SelectCompiler<Space>
vnoremap <Space>mc<Space> :<C-u>SelectCompiler  \|norm gv
      \ <C-Left><C-Left><Left>

nnoremap <Space>mc; :<C-u>compiler<Space>
vnoremap <Space>mc; :<C-u>compiler  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space>mC; :<C-u>compiler!<Space>
vnoremap <Space>mC; :<C-u>compiler!  \|norm gv<C-Left><C-Left><Left>

"}}}

"{{{ groff

autocmd BufWritePost *.ms call CompileGroffMs()

let g:groff_pdf = 'groff -ktep -T pdf '

function CompileGroffMs()
  if get(b:, "bufcomp", 0)
    call system(g:groff_pdf.' -ms '.expand('%').' > '.expand('%:r').'.pdf')
  endif
endfunction

"}}}
