" plug {{{ 

function GeneralUpgrade()
  silent! PlugUpgrade
  silent! PlugUpdate --sync
endfunction

nnoremap <silent> <Leader>qu :silent! call GeneralUpgrade()<CR>
nnoremap <silent> <Leader>qP :silent! PlugClean!<CR>

" }}} 

" vis {{{ 

noremap <Leader>is :<C-u>S
noremap <Leader>ib :<C-u>B

" }}} 

" bbye {{{ 

" TODO Proper expand
command! -nargs=* -bang -complete=buffer Bdel
      \ call Multif('Bdelete'.<q-bang>, [<f-args>])
command! -nargs=* -bang -complete=buffer Bwip
      \ call Multif('Bwipeout'.<q-bang>, [<f-args>])
command! -nargs=* -bang -complete=buffer Bunl
      \ call Multif('Bunload'.<q-bang>, [<f-args>])

noremap <silent> <Space><Space>- :<C-u>Bdel<CR>
noremap <silent> <Space><Space>;- :<C-u>Bdel!<CR>
noremap <silent> <Space><Space>w :<C-u>Bwip<CR>
noremap <silent> <Space><Space>W :<C-u>Bwip!<CR>

noremap <Space><Space>;d :<C-u>Bdel<Space>
noremap <Space><Space>;D :<C-u>Bdel!<Space>
noremap <Space><Space>;u :<C-u>Bunl<Space>
noremap <Space><Space>;U :<C-u>Bunl!<Space>
noremap <Space><Space>;w :<C-u>Bwip<Space>
noremap <Space><Space>;W :<C-u>Bwip!<Space>

" }}} 

" surround & sneak {{{

xmap <Space>a <Plug>VSurround
xmap <Space>A <Plug>VgSurround

noremap f <Plug>Sneak_f
noremap F <Plug>Sneak_F
noremap t <Plug>Sneak_t
noremap T <Plug>Sneak_T
noremap s <Plug>Sneak_s
noremap S <Plug>Sneak_S
noremap <C-p> <Plug>Sneak_,
noremap <C-n> <Plug>Sneak_;

" }}}

" other {{{ 

cnoreabbrev Abo Abolish

if !has("nvim")
  call lazy_utils#LoadOnStartup("SlimeSetupTmux")
endif

" }}} 
