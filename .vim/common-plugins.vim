" dependencies {{{ 

Plug 'glts/vim-magnum'
Plug 'tpope/vim-repeat'

" }}} 

" essentials {{{ 

Plug 'mbbill/undotree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'jpalardy/vim-slime'
Plug 'ryvnf/readline.vim'

Plug 'unblevable/quick-scope'
Plug 'justinmk/vim-sneak' " TODO A shortcuts
Plug 'dbakker/vim-paragraph-motion'

Plug 'tpope/vim-tbone'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'

" }}} 

" little utilities {{{ 

Plug 'tpope/vim-obsession'
Plug 'romainl/vim-tinyMRU'

Plug 'glts/vim-radical'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-speeddating'

Plug 'chrisbra/unicode.vim', {'do': ':UnicodeDownload!'}
Plug 'kburdett/vim-nuuid'

Plug 'luochen1990/rainbow'
Plug 'kshenoy/vim-signature'

Plug 'godlygeek/tabular'
Plug 'vim-scripts/vis'
Plug 'moll/vim-bbye'
Plug 'azabiong/vim-highlighter'

" }}} 

" coding help {{{ 

Plug 'sbdchd/neoformat'
Plug 'lfilho/cosco.vim'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
" Plug 'neomake/neomake' ?

Plug 'wellle/tmux-complete.vim'

" folds should be enough
" or something
" Plug 'wellle/context.vim'

" Plug 'yegappan/taglist'
Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'

Plug 'xuhdev/SingleCompile'
Plug 'Konfekt/vim-compilers'

" }}} 

" textobjects {{{ 

Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'preservim/vim-textobj-quote'
Plug 'preservim/vim-textobj-sentence'

" targets has this
" Plug 'vim-scripts/argtextobj.vim'

Plug 'kana/vim-textobj-user'
Plug 'rhysd/vim-textobj-continuous-line'
Plug 'mattn/vim-textobj-url'
Plug 'paulhybryant/vim-textobj-path'
Plug 'rhysd/vim-textobj-anyblock'
Plug 'thinca/vim-textobj-between'

Plug 'alberto-lazari/vim-textobj-typst'
Plug 'coachshea/vim-textobj-markdown'

" Needs python :)
" Plug 'spacewander/vim-textobj-lua'

" }}} 

" version control {{{ 

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'rhysd/git-messenger.vim' " TODO

Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tommcdo/vim-fubitive'

" }}} 

" config help {{{ 

Plug 'direnv/direnv.vim'

Plug 'tmux-plugins/vim-tmux'
Plug 'vifm/vifm.vim'
Plug 'nickel-lang/vim-nickel'

Plug 'kmonad/kmonad-vim'
Plug 'mmikeww/autohotkey.vim'

" }}} 

" specialized {{{ 

Plug 'JuliaEditorSupport/julia-vim'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'vale1410/vim-minizinc'

Plug 'LnL7/vim-nix' " TODO A what is going on
Plug 'ziglang/zig.vim', {'for': 'zig'}
Plug 'pearofducks/ansible-vim'
Plug 'neovimhaskell/haskell-vim', 
      \ {'for': ['haskell', 'cabal']}

Plug 'jceb/vim-orgmode'
Plug 'lervag/vimtex', {'for': 'latex'}
Plug 'Gavinok/vim-troff'
Plug 'kaarmu/typst.vim'
Plug 'mattn/emmet-vim'
Plug 'HiPhish/info.vim'

" TODO C and make this not slow vim down
" Plug 'vimwiki/vimwiki'

Plug 'preservim/vim-markdown', {'for': 'markdown'}
" Plug 'vim-pandoc/vim-markdownfootnotes'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'bullets-vim/bullets.vim'

" Maybe...
" Plug 'dbridges/vim-markdown-runner'

" }}} 

" other {{{ 

Plug 'vim-pandoc/vim-pandoc'
Plug 'rhysd/accelerated-jk'
Plug 'preservim/vim-wheel'

" TODO C ???
" Plug 'preservim/vim-colors-pencil'

" }}} 
