" Man pages
" noremap K <Plug>ManPreGetPage

let g:ft_man_open_modes = ['horiz', 'tab', 'vert']
let g:cur_ft_man_open_mode = 0
let g:ft_man_open_mode = g:ft_man_open_modes[g:cur_ft_man_open_mode]

function NextFtManOpenMode()
    let g:cur_ft_man_open_mode = (g:cur_ft_man_open_mode+1)%len(g:ft_man_open_modes)
    let g:ft_man_open_mode = g:ft_man_open_modes[g:cur_ft_man_open_mode]
    echo g:ft_man_open_mode
endfunction
function PrevFtManOpenMode()
    let g:cur_ft_man_open_mode = 
                \ (len(g:ft_man_open_modes)+
                \ g:cur_ft_man_open_mode-1)%
                \ len(g:ft_man_open_modes)
    let g:ft_man_open_mode = g:ft_man_open_modes[g:cur_ft_man_open_mode]
    echo g:ft_man_open_mode
endfunction

nnoremap <silent> gjmn :call NextFtManOpenMode()<CR>
nnoremap <silent> gjmp :call PrevFtManOpenMode()<CR>


