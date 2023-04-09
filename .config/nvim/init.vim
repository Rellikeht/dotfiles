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
    Plug 'luochen1990/rainbow'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'unblevable/quick-scope'

    Plug 'kmonad/kmonad-vim'
    Plug 'numirias/semshi', { 'do': 'UpdateRemotePlugins' }
    Plug 'jceb/vim-orgmode'
    Plug 'vlime/vlime'
    Plug 'mattn/emmet-vim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }

    Plug 'fatih/vim-go', { 'do': 'GoUpdateBinaries' }
    Plug 'ziglang/zig.vim'
    Plug 'JuliaEditorSupport/julia-vim'
    Plug 'zah/nim.vim'

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
