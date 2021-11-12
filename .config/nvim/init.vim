" This line makes pacman-installed global Arch Linux vim packages work.
silent! source /usr/share/nvim/archlinux.vim
"colorscheme desert

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

 Plug 'mbbill/undotree'
 Plug 'junegunn/fzf.vim'
 Plug 'junegunn/fzf'

 Plug 'easymotion/vim-easymotion'
 Plug 'justinmk/vim-sneak'
 Plug 'tpope/vim-repeat'
 Plug 'tpope/vim-surround'
 Plug 'tpope/vim-speeddating'

 Plug 'luochen1990/rainbow'
 Plug 'norcalli/nvim-colorizer.lua'
 Plug 'unblevable/quick-scope'

 Plug 'numirias/semshi', { 'do': 'UpdateRemotePlugins' }
 Plug 'jceb/vim-orgmode'
 Plug 'vlime/vlime'
 Plug 'mattn/emmet-vim'

 " ?
" Plug 'maxboisvert/vim-simple-complete'
 Plug 'dense-analysis/ale'
 " TODO i don't really know how it works
 " but somehow it works
 Plug 'ms-jpq/coq_nvim'
 Plug 'ms-jpq/coq.artifacts'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let g:coq_settings = { 'auto_start': v:true }

source ~/.vimrc

autocmd FileType json syntax match Comment +\/\/.\+$+

" Use ALE as completion sources for all code.
"call deoplete#custom#option('sources', {
"\ '_': ['ale'],
"\})
let g:ale_completion_autoimport = 1

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
