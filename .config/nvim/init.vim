" This line makes pacman-installed global Arch Linux vim packages work.
source /usr/share/nvim/archlinux.vim

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
 if has('syntax') && has('eval')
  packadd! matchit
 endif

" Enable completion where available.
" This setting must be set before ALE is loaded.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
let g:ale_completion_enabled = 1

" Plugins will be downloaded under the specified directory.
 call plug#begin('~/.config/nvim/plugins')

" Plug 'numirias/semshi'
" Plug 'preservim/nerdtree'
 Plug 'dense-analysis/ale'
 Plug 'mbbill/undotree'
 Plug 'junegunn/fzf'
 Plug 'unblevable/quick-scope'
" Plug 'justinmk/vim-sneak'
 Plug 'easymotion/vim-easymotion'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'maxboisvert/vim-simple-complete'
 Plug 'norcalli/nvim-colorizer.lua'

"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
"  Plug 'deoplete-plugins/deoplete-jedi'
"let g:deoplete#enable_at_startup = 1

" List ends here. Plugins become visible to Vim after this call.
 call plug#end()
set termguicolors
lua require'colorizer'.setup()

let mapleader = ','

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

set nu rnu
syntax on
set wildmenu
set smartcase
set ignorecase
