" TINYMRU

nnoremap <silent> ,ue :ME<Space>
nnoremap <silent> ,us :MS<Space>
nnoremap <silent> ,ul :MV<Space>
nnoremap <silent> ,un :MT<Space>

" TODO right and bottom split
" Doesn't work
" nnoremap <silent> ,ur :botright MV<Space>

" UNDO TREE

let g:undotree_WindowLayout = 1
let g:undotree_ShortIndicators = 0
let g:undotree_CursorLine = 1

nnoremap <silent> ,ut :UndotreeToggle<CR>

function g:Undotree_CustomMap()
    nnoremap <buffer> ,d <Plug>UndotreeDiffToggle

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
