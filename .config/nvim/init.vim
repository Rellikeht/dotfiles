" This line makes pacman-installed global Arch Linux vim packages work.
silent! source /usr/share/nvim/archlinux.vim

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
 packadd! matchit
endif

" TODO incorporate them
call plug#begin('~/.config/nvim/plugins')
    source ~/.vim/common-plugins.vim

    Plug 'easymotion/vim-easymotion'
    Plug 'norcalli/nvim-colorizer.lua'

    Plug 'kmonad/kmonad-vim'
    Plug 'numirias/semshi', { 'do': 'UpdateRemotePlugins' }
    Plug 'jceb/vim-orgmode'
    Plug 'vlime/vlime'
    Plug 'mattn/emmet-vim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }

    Plug 'JuliaEditorSupport/julia-vim'

call plug#end()

colorscheme elflord
source ~/.vimrc

set termguicolors

" EASYMOTION

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" COC.NVIM

"function StartNextCompletion()
"    "call coc#start()
"    "call coc#refresh()
"    "return coc#_select_confirm()
"    "return coc#refresh()
"    "return [coc#refresh(), coc#pum#next(1)]
"    "return coc#refresh() | coc#pum#next(1)
"    "call CocAction('runCommand', 'coc#refresh')
"    "call CocAction('runCommand', 'coc#pum#next', 1)
"endfunction

"inoremap <silent><expr> <c-n> coc#pum#visible() ? coc#pum#next(1) : StartNextCompletion()

" manual triggering of completion, because automatic does too much
" and because all of that is fucking shit that barely fucking works and IT
" CANNOT RUN TWO FUCKING FUNCTIONS AT ONCE, that is probably the best that can
" be done
inoremap <silent><expr> <c-n> coc#pum#visible() ? coc#pum#next(1) : coc#refresh()
" FUCKING SHITTY PLUGIN, I USE IT NOW ONLY BECAUSE I'M TIRED FUCKING WITH THIS
" I HAVE TO SWITCH, BEFORE I DESTROY MY KEYBOARD

map <Leader>en <Plug>(coc-diagnostic-next-error)
map <Leader>ep <Plug>(coc-diagnostic-prev-error)
map <Leader>eN <Plug>(coc-diagnostic-next)
map <Leader>eP <Plug>(coc-diagnostic-prev)
map <Leader>ei <Plug>(coc-diagnostic-info)
map <Leader>eq <Plug>(coc-fix-current)

map <Leader>ed <Plug>(coc-definition)
map <Leader>eD <Plug>(coc-declaration)
map <Leader>et <Plug>(coc-type-definition)

map <Leader>ef <Plug>(coc-format-selected)
map <Leader>eF <Plug>(coc-format)
map <Leader>er <Plug>(coc-rename)
map <Leader>eR <Plug>(coc-refactor)

map <Leader>ea <Plug>(coc-codeaction)
map <Leader>eA <Plug>(coc-codeaction-selected)
map <Leader>e. <Plug>(coc-command-repeat)
map <Leader>eh <Plug>(coc-float-hide)
