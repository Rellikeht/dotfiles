
"{{{ TINYMRU

noremap <silent> ,ue :<C-u>ME<Space>
noremap <silent> ,uv :<C-u>MS<Space>
noremap <silent> ,uh :<C-u>MV<Space>
noremap <silent> ,un :<C-u>MT<Space>

" }}}

"{{{ UNDO TREE

let g:undotree_WindowLayout = 1
let g:undotree_ShortIndicators = 0
let g:undotree_CursorLine = 1

noremap <silent> ,ut :<C-u>UndotreeToggle<CR>

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

"}}}

"{{{ OBSESSION
" Not good, not bad

autocmd VimEnter * execute 'silent! Mkdir '.g:data_dir.'/sessions'
" execute 'Mkdir '.g:data_dir.'/sessions'

nnoremap ,usm :<C-u>mksession<CR>
vnoremap ,usm :<C-u>mksession\|norm gv<CR>
nnoremap ,usM :<C-u>mksession<Space>
vnoremap ,usM :<C-u>mksession  \|norm gv<C-Left><C-Left><Left>

nnoremap ,usd :<C-u>execute 'mksession '.g:data_dir.
            \ '/sessions/'.localtime().'.vim'<CR>
vnoremap ,usd :<C-u>execute 'mksession '.g:data_dir.
            \ '/sessions/'.localtime().'.vim'\|norm gv<CR>
nnoremap ,usD :<C-u>execute 'mksession '.
            \ g:data_dir.'/sessions/'.<Space>
vnoremap ,usD :<C-u>execute 'mksession '.
            \ g:data_dir.'/sessions/'.
            \ <Space>\|norm gv<C-Left><C-Left><Left>

nnoremap ,uso :<C-u>Obsession<CR>
vnoremap ,uso :<C-u>Obsession\|norm gv<CR>
nnoremap ,usO :<C-u>Obsession<Space>
vnoremap ,usO :<C-u>Obsession  \|norm gv<C-Left><C-Left><Left>
nnoremap ,usr :<C-u>Obsession!<CR>
vnoremap ,usr :<C-u>Obsession!\|norm gv<CR>

nnoremap ,uss :<C-u>execute 'Obsession '.g:data_dir.
            \ '/sessions/'.localtime().'.vim'<CR>
vnoremap ,uss :<C-u>execute 'Obsession '.g:data_dir.
            \ '/sessions/'.localtime()\|norm gv<CR>
nnoremap ,usS :<C-u>execute 'Obsession '.
            \ g:data_dir.'/sessions/'.<Space>
vnoremap ,usS :<C-u>execute 'Obsession '.
            \ g:data_dir.'/sessions/'.<Space>
            \ <Space>\|norm gv<C-Left><C-Left><Left>

"}}}
