" helpers {{{ 

map <Leader>u<Esc> <Nop>

" }}} 

" TINYMRU {{{ 

noremap <Leader>ue :<C-u>ME<Space>
noremap <Leader>uv :<C-u>MS<Space>
noremap <Leader>uh :<C-u>MV<Space>
noremap <Leader>un :<C-u>MT<Space>

" }}} 

" UNDO TREE {{{ 

let g:undotree_WindowLayout = 1
let g:undotree_ShortIndicators = 0
let g:undotree_CursorLine = 1

noremap <silent> <Leader>ut :<C-u>UndotreeToggle<CR><C-w>W<C-w>w

function g:Undotree_CustomMap()
  nnoremap <buffer> <Leader>d <Plug>UndotreeDiffToggle

  " TODO
  "     <plug>UndotreeHelp
  "     <plug>UndotreeClose
  "     <plug>UndotreeFocusTarget
  "     <plug>UndotreeClearHistory
  "     <plug>UndotreeTimestampToggle
  "     <plug>UndotreeDiffToggle
  "     <plug>UndotreeNextState
  "     <plug>UndotreePreviousState
  "     <plug>UndotreeNextSavedState
  "     <plug>UndotreePreviousSavedState
  "     <plug>UndotreeRedo
  "     <plug>UndotreeUndo
  "     <plug>UndotreeEnter

  " let s:keymap += [['Help','?','Toggle quick help']]
  " let s:keymap += [['Close','q','Close undotree panel']]
  " let s:keymap += [['FocusTarget','<tab>','Set Focus back to the editor']]
  " let s:keymap += [['ClearHistory','C','Clear undo history (with confirmation)']]
  " let s:keymap += [['TimestampToggle','T','Toggle relative timestamp']]
  " let s:keymap += [['DiffToggle','D','Toggle the diff panel']]
  " let s:keymap += [['NextState','K','Move to the next undo state']]
  " let s:keymap += [['PreviousState','J','Move to the previous undo state']]
  " let s:keymap += [['NextSavedState','>','Move to the next saved state']]
  " let s:keymap += [['PreviousSavedState','<','Move to the previous saved state']]
  " let s:keymap += [['Redo','<c-r>','Redo']]
  " let s:keymap += [['Undo','u','Undo']]
  " let s:keymap += [['Enter','<2-LeftMouse>','Move to the current state']]
  " let s:keymap += [['Enter','<cr>','Move to the current state']]

endfunc

" }}} 

" OBSESSION {{{ 
" Not good, not bad

autocmd VimEnter * execute 'silent! Mkdir '.g:data_dir.'/sessions'

nnoremap <Leader>usd :<C-u>execute 'mksession '.g:data_dir.
      \ '/sessions/'.localtime().'.vim'<CR>
nnoremap <expr> <Leader>usD ':<C-u>mksession '.g:data_dir.'/sessions/'

nnoremap <Leader>uso :<C-u>Obsession<CR>
nnoremap <Leader>usO :<C-u>Obsession<Space>
nnoremap <Leader>usr :<C-u>Obsession!<CR>

nnoremap <Leader>uss :<C-u>execute 'Obsession '.g:data_dir.
      \ '/sessions/'.localtime().'.vim'<CR>
nnoremap <expr> <Leader>usS ':<C-u>Obsession '.g:data_dir.'/sessions/'

" }}} 
