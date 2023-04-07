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
