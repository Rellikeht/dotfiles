" settings {{{ 

" from opam installation
set rtp^="~/.opam/default/share/ocp-indent/vim"

autocmd BufReadPre *
      \ let b:compilers = []

" Doesn't work :(
" autocmd BufNew,BufNewFile *
"       \ let b:compilers = []

autocmd FileType
      \ html,
      \ vim,
      \ lua,
      \ r,
      setlocal shiftwidth=2 softtabstop=2 tabstop=2

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
nnoremap <expr> <Space>m<Space>r g:qfloc ?
      \ ':<C-u>lmake<Space>' : ':<C-u>make<Space>'

nnoremap <expr> <Space>me ':<C-u>setlocal makeprg='.&makeprg

nnoremap <Space>mqp :<C-u>setlocal makeprg<CR>
nnoremap <Space>mp :<C-u>setlocal makeprg=
nnoremap <Space>mqf :<C-u>setlocal errorformat<CR>
nnoremap <Space>mf :<C-u>setlocal errorformat=<Space>

nnoremap <Space>mqP :<C-u>set makeprg<CR>
nnoremap <Space>mP :<C-u>set makeprg=
nnoremap <Space>mqF :<C-u>set errorformat<CR>
nnoremap <Space>mF :<C-u>set errorformat=<Space>

" }}} 

" compiler {{{ 

function CompleteCompiler(lead, cmdline, curpos)
  return CompleteList(b:compilers, a:lead, a:cmdline, a:curpos)
endfunction

command -nargs=1 -complete=customlist,CompleteCompiler SelectCompiler
      \ exe 'compiler '.<args>

nnoremap <Space>mc<Space> :<C-u>SelectCompiler<Space>

nnoremap <Space>mc; :<C-u>compiler<Space>
nnoremap <Space>mC; :<C-u>compiler!<Space>

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
