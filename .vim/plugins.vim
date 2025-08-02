" dependencies {{{ 

Plug 'glts/vim-magnum'
Plug 'tpope/vim-repeat'

" }}} 

" essentials {{{ 

Plug 'Rellikeht/arglist-plus'
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
Plug 'Rellikeht/lazy-utils'

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

Plug 'vim-scripts/vis'
Plug 'moll/vim-bbye'
Plug 'azabiong/vim-highlighter'

" TODO C fork and change bindings
" Plug 'Stormherz/tablify'

" TODO revert to godlygeek when updated
Plug 'Rellikeht/tabular'
Plug 'tpope/vim-endwise'

" }}} 

" coding help {{{ 

Plug 'sbdchd/neoformat'
Plug 'lfilho/cosco.vim'

Plug 'suy/vim-context-commentstring'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'

Plug 'wellle/tmux-complete.vim'

Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'

Plug 'xuhdev/SingleCompile'
Plug 'Konfekt/vim-compilers'
Plug 'Rellikeht/vim-makeshift'
Plug 'ilyachur/cmake4vim'
Plug 'igankevich/mesonic'
Plug 'Rellikeht/vim-compiler-collection'

" }}} 

" textobjects {{{ 

Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'preservim/vim-textobj-quote'
Plug 'preservim/vim-textobj-sentence'
Plug 'andymass/vim-matchup'

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

Plug 'junegunn/vader.vim'

Plug 'JuliaEditorSupport/julia-vim'
Plug 'jeetsukumaran/vim-pythonsense', {'for': 'python'}
Plug 'vale1410/vim-minizinc'

Plug 'LnL7/vim-nix', {'for': 'nix'} " TODO A what is going on
Plug 'ziglang/zig.vim', {'for': 'zig'}
Plug 'pearofducks/ansible-vim'
Plug 'neovimhaskell/haskell-vim', 
      \ {'for': ['haskell', 'cabal']}

Plug 'lervag/vimtex', {'for': 'latex'}
Plug 'Gavinok/vim-troff'
Plug 'kaarmu/typst.vim', {'for': 'typst'}
Plug 'HiPhish/info.vim'

Plug 'mattn/emmet-vim'
Plug 'AndrewRadev/tagalong.vim'
Plug 'averms/ebnf-vim'
Plug 'vim-scripts/bnf.vim'

Plug 'preservim/vim-markdown', {'for': 'markdown'}
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'bullets-vim/bullets.vim'

Plug 'jceb/vim-orgmode'
Plug 'habamax/vim-rst'
Plug 'habamax/vim-asciidoctor'

Plug 'ekalinin/Dockerfile.vim'

" Maybe...
" Plug 'dbridges/vim-markdown-runner'

" }}} 

" other {{{ 

Plug 'vim-pandoc/vim-pandoc'
Plug 'rhysd/accelerated-jk'
Plug 'preservim/vim-wheel'

" }}} 

if !has("nvim") " {{{
  Plug 'AndrewRadev/inline_edit.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ap/vim-css-color'

  Plug 'bfrg/vim-cpp-modern', {'for': 'cpp'}
  Plug 'elzr/vim-json', {'for': 'json'}
  Plug 'ocaml/vim-ocaml', {'for': 'ocaml'}
  Plug 'tpope/vim-jdaddy'
  Plug 'elixir-editors/vim-elixir', {'for': 'elixir'}

  Plug 'bfrg/vim-qf-diagnostics'
  Plug 'Rellikeht/vim-simple-complete'
  " Plug 'garbas/vim-snipmate' 
endif " }}}
