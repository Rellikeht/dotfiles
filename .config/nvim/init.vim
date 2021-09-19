" This line makes pacman-installed global Arch Linux vim packages work.
source /usr/share/nvim/archlinux.vim
source ~/.vimrc

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
"let g:ale_completion_enabled = 1

let g:ale_completion_enabled = 1
" Plugins will be downloaded under the specified directory.
 call plug#begin('~/.config/nvim/plugins')

" Plug 'numirias/semshi'
" Plug 'preservim/nerdtree'
 Plug 'dense-analysis/ale'
 Plug 'mbbill/undotree'
 Plug 'junegunn/fzf'
 Plug 'unblevable/quick-scope'
 Plug 'easymotion/vim-easymotion'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'maxboisvert/vim-simple-complete'
 Plug 'norcalli/nvim-colorizer.lua'
 Plug 'jceb/vim-orgmode'
 Plug 'vlime/vlime'
 Plug 'romainl/vim-cool'

"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
"  Plug 'deoplete-plugins/deoplete-jedi'
"  Plug 'deoplete-plugins/deoplete-clangx'
"let g:deoplete#enable_at_startup = 1

" List ends here. Plugins become visible to Vim after this call.
 call plug#end()

autocmd FileType json syntax match Comment +\/\/.\+$+

"inoremap <silent><expr> <Tab> coc#refresh()

"inoremap <silent><expr> <Tab> deoplete#complete()
" Use ALE as completion sources for all code.
"call deoplete#custom#option('sources', {
"\ '_': ['ale'],
"\})

let g:ale_completion_autoimport = 1
"set omnifunc=ale#completion#OmniFunc
"inoremap <silent><expr> <Tab> 

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

"nnoremap tk  :tabfirst<CR>
"nnoremap tj  :tablast<CR>
"nnoremap tm  :tabm<Space>
"nnoremap te  :tabedit<Space>
"nnoremap tt  :tabedit<Space>
"nnoremap td  :tabclose<CR>
"nnoremap tl :tabnext<CR>
"nnoremap th :tabprev<CR>
"nnoremap tn :tabnew<CR>

filetype plugin on
set nu rnu
"syntax on
"set wildmenu
"set smartcase
"set ignorecase
