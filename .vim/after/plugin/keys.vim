" plug {{{ 

function GeneralUpgrade()
  silent! PlugUpgrade
  silent! PlugUpdate --sync
endfunction

nnoremap <silent> <Leader>qu :silent! call GeneralUpgrade()<CR>
nnoremap <silent> <Leader>qP :silent! PlugClean!<CR>

" }}} 

" Repeat {{{ 

" https://jdhao.github.io/2019/04/29/nvim_map_with_a_count/
" https://vi.stackexchange.com/questions/20760/how-to-add-a-count-to-a-binding

" silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
" Because that does't work with cgn and
" probably some other mappings

" map ;. <Plug>(RepeatDot)
map . <Plug>(RepeatDot)
noremap ;. .

" }}} 

" vim-sneak {{{ 
" TODO colors
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#prompt = '  < sneak > '
let g:sneak#s_next = 0

noremap f <Plug>Sneak_f
noremap F <Plug>Sneak_F
noremap t <Plug>Sneak_t
noremap T <Plug>Sneak_T
noremap s <Plug>Sneak_s
noremap S <Plug>Sneak_S
noremap <C-p> <Plug>Sneak_,
noremap <C-n> <Plug>Sneak_;
" }}} 

" abolish {{{ 

" So little code to do so much
cnoremap <c-g> Subvert

" }}} 

" vis {{{ 

noremap <Leader>is :<C-u>S
noremap <Leader>ib :<C-u>B

" This has to be mapped for plugin not to map it
map <unique> <Leader>iws <Plug>SaveWinPosn
map <unique> <Leader>iwr <Plug>RestoreWinPosn

" }}} 

" bbye {{{ 

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
