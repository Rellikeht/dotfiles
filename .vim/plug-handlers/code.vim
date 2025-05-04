" cosco {{{ 

"nmap <silent> ; <Plug>(cosco-commaOrSemiColon)
" map <silent> <C-;> <C-o><Plug>(cosco-commaOrSemiColon)
" let g:cosco_ignore_comment_lines = 1

" }}} 

" neoformat formatters {{{ 
let g:neoformat_enabled_go = ['gofmt']

" ???
let g:neoformat_enabled_python = [
      \ 'ruff',
      \ 'autopep8',
      \ 'flake8',
      \ 'docformatter'
      \ ]

let g:neoformat_enabled_c = ['clangformat', 'astyle', 'uncrustify']
let g:neoformat_enabled_cpp = ['clangformat', 'astyle', 'uncrustify']
let g:neoformat_enabled_nix = ['alejandra']
let g:neoformat_enabled_haskell = [
      \ 'floskell',
      \ 'stylishhaskell',
      \ 'brittany',
      \ 'hfmt',
      \ 'hindent',
      \ 'sortimports',
      \ 'ormolu',
      \ ]

let g:neoformat_ocaml_ocamlformat = {
        \ 'exe': 'ocamlformat',
        \ 'no_append': 1,
        \ 'stdin': 1,
        \ 'args': ['--enable-outside-detected-project', '--name', '"%:p"', '-']
        \ }

let g:neoformat_enabled_ocaml = ['ocamlformat', 'topiary']

autocmd FileType dhall let b:buffmt=0 " :(((

" done in zig plugin
let g:neoformat_enabled_zig = []
"let g:neoformat_enabled_zig = ['zig_fmt']

let g:neoformat_enabled_nim = ['nimpretty']
let g:neoformat_enabled_shell = ['shfmt', 'topiary']
let g:neoformat_enabled_zsh = ['shfmt']

" 'mdformat',
let g:neoformat_enabled_markdown = ['prettierd', 'prettier']

let g:neoformat_markdown_mdformat = {
      \ 'exe': 'mdformat',
      \ 'args': ['--number', '--wrap', '64', '-'],
      \ 'stdin': 1,
      \ }

let g:neoformat_enabled_html = [
      \ 'prettierd',
      \ 'prettier',
      \ 'tidy',
      \ 'htmlbeautify',
      \ 'prettydiff',
      \ ]

" TODO can this be usable??
" let g:neoformat_html_tidy = {
"       \ 'exe': 'tidy',
"       \ 'args': [
"       \   '--quiet',
"       \   '--tidy-mark no',
"       \   '-wrap ' . &textwidth
"       \ ],
"       \ 'try_node_exe': 1,
"       \ }
"       " \ '--wrap', '64'

let g:neoformat_enabled_lua = [
      \ 'luaformat',
      \ ]

" FUCKING YAML
let g:neoformat_enabled_yaml = [
      \ 'google_yamlfmt',
      \ 'yamlfix',
      \ 'prettierd',
      \ 'prettier'
      \ ]
" \ 'pyaml'
"
" https://github.com/mikefarah/yq
" https://github.com/opt-nc/yamlfixer

let g:neoformat_yaml_yamlfix = {
      \ 'exe': 'yamlfix',
      \ 'args': ['-c', '~/.vim/plug-handlers/pyproject.toml', '-'],
      \ 'stdin': 1,
      \ }

" prettier ???
let g:neoformat_enabled_json = ['jq', 'clangformat', 'topiary', 'prettierd', 'prettier']
let g:neoformat_enabled_jsonc = ['prettierd', 'prettier']
let g:neoformat_enabled_javascript = ['clangformat', 'prettierd', 'prettier']
let g:neoformat_enabled_typescript = ['clangformat', 'prettierd', 'prettier']
let g:neoformat_enabled_java = ['clangformat', 'astyle', 'uncrustify', 'prettierd', 'prettier']

" Totally differently than it seems
" from reading README, but somehow this shit works
let g:neoformat_typst_typstfmt = {
      \ 'exe': 'typstfmt',
      \ 'args': ['-o -'],
      \ 'stdin': 1,
      \ 'stderr': 1,
      \ 'replace': 0,
      \ 'no_append': 1,
      \ }

let g:neoformat_typst_prettypst = {
      \ 'exe': 'prettypst',
      \ 'args': [
      \ '--use-std-in',
      \ '--use-std-out',
      \ '--use-configuration',
      \ '--file-location=$HOME/.vim/plug-handlers',
      \ ],
      \ 'stdin': 1,
      \ 'stderr': 1,
      \ 'replace': 0,
      \ 'no_append': 1,
      \ }

let g:neoformat_enabled_typst = ["typstfmt", "prettypst"]

" }}} 

" neoformat settings {{{ 

" ???
"let b:neoformat_run_all_formatters = 1
let b:neoformat_basic_format_retab = 1
let g:neoformat_only_msg_on_error = 1

augroup fmt
  autocmd!
  autocmd BufWritePre *
        \ if get(b:, "buffmt", 0)
        \| try
        \| undojoin
        \| Neoformat
        \| catch /E790/
        \| Neoformat
        \| endtry
        \| endif
augroup END

noremap <silent> <Leader>nf :Neoformat<CR>
noremap <Leader>n<Space>f :Neoformat<Space>

" }}} 

"" context {{{ 
"
"" TODO B sane settings
"" :(
"" too annoying
"let g:context_enabled = 0
"
"nnoremap <Leader>qcp :ContextPeek<CR>
"nnoremap <Leader>qct :ContextToggle<CR>
"nnoremap <Leader>qcw :ContextToggleWindow<CR>
"
"autocmd FileType qf ContextDisableWindow
"
"" }}} 

" TODO B dispatch {{{ 

" }}} 

" specialized {{{ 

" zig.vim {{{ 

let g:zig_fmt_autosave = 1

" }}} 

" julia-vim {{{ 

let g:latex_to_unicode_keymap = 1
let g:latex_to_unicode_tab = "on"
let g:latex_to_unicode_file_types = '.*'
let g:latex_to_unicode_suggestions = 1

noremap <expr> <Leader>nlt LaTeXtoUnicode#Toggle()

" }}} 

" direnv.vim {{{ 
" TODO C this plugin is too shallow, it needs to be done better way

nnoremap <silent> <Leader>qde :EditEnvrc<CR>
nnoremap <silent> <Leader>qdE :EditDirenvrc<CR>
nnoremap <silent> <Leader>qdl :DirenvExport<CR>

" }}} 

" haskell-vim {{{ 

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

let g:haskell_disable_HT = 0              " disable template haskell
let g:haskell_classic_highlighting = 0
let g:haskell_indent_disable = 0

" }}} 

" Pluto.jl :) {{{ 

function PLR()
  if @" == '─'
    call setreg('"', '═')
  else
    call setreg('"', '─')
  endif
endfunction

" TODO make this more stable
function PlutoAdd(hidden=0)
  if a:hidden
    norm mcyyGp02lr╟lr─lxx'c<CR>
  else
    norm mcyyGp02lr╟lr═lxx'c<CR>
  endif
endfunction

nnoremap <silent> <Leader>npc :exe 'norm i# ╔═╡ '.NuuidNewUuid()<CR>
nnoremap <silent> <Leader>npa :call PlutoAdd()<CR>
nnoremap <silent> <Leader>np;a :call PlutoAdd(1)<CR>

" Toggle visibility when in cell
nnoremap <Leader>npt 0wwv$hy<Esc>/<C-r>=@<CR><CR>,npTnn

" Toggle visibility when in cell list
nnoremap <Leader>np;t 03lx:call PLR()<CR>P

" TODO disable
" Start:
"#=╠═╡
" End:
"  ╠═╡ =#

" Disabled in file:
"# ╠═╡ skip_as_script = true
" Disabled:
"# ╠═╡ disabled = true

" }}} 

" tagalong {{{ 

let g:tagalong_filetypes = [
      \ 'markdown', 
      \ 'javascript', 
      \ 'typescript', 
      \ 'eco',
      \ 'eelixir',
      \ 'ejs',
      \ 'eruby',
      \ 'html',
      \ 'htmldjango',
      \ 'javascriptreact',
      \ 'jsx',
      \ 'php',
      \ 'typescriptreact',
      \ 'xml'
      \ ]

" }}}

" emmet {{{ 

let g:user_emmet_install_global = 0
let s:emmet_filetypes = tagalong_filetypes[0]
for t in tagalong_filetypes[1:]
  let s:emmet_filetypes = s:emmet_filetypes.','.t
endfor
exe 'autocmd FileType '.s:emmet_filetypes.' EmmetInstall'

let g:user_emmet_mode = 'nv'  "enable all for modes
let g:user_emmet_leader_key = '<Leader>,'

" }}} 

" TODO D ansible-vim {{{ 

" }}} 

" }}} 

" autopairs {{{ 

let g:AutoPairsShortcutToggle = "<C-x>="

autocmd FileType text
      \ let b:autopairs_enabled = 0

nnoremap <Leader>qa :<C-u>call AutoPairsToggle()<CR>

" }}} 

" gutentags {{{ 
" https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/

" settings {{{ 

" TODO C more ?
let g:gutentags_project_root = [
      \ ".git",
      \ ".hg",
      \ ".project",
      \ ] + [
      \ "go.mod",
      \ "configure.sh",
      \ "flake.lock",
      \ "Cargo.toml",
      \ "Project.toml",
      \ "nimble.nimble",
      \ "dune-project",
      \ "cabal.project",
      \ "stack.yaml",
      \ "__init__.py",
      \ "package.json",
      \ ]

let g:gutentags_add_default_project_roots = 0

autocmd DirChanged global call gutentags#rescan()
let g:gutentags_exclude_project_root = [
      \ expand('/nix/store/'),
      \ ]
      " \ expand('~/gits/configs/dotfiles'),

let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
command! -nargs=0 GutentagsClearCache
      \ call system('rm ' . g:gutentags_cache_dir . '/*')

" What is the best ?
" It needs separate script
let g:gutentags_file_list_command = {
      \ 'markers': {
      \ '.git': 'git ls-files',
      \ '.hg': 'hg files',
      \ },
      \ }
" let g:gutentags_file_list_command = 'rg --files'
" let g:gutentags_file_list_command = 'ag --hidden --files-with-matches . .'

let g:gutentags_define_advanced_commands = 1
let g:gutentags_modules = ['ctags']
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]

let g:gutentags_generate_on_new = 0
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" }}} 

" g:gutentags_ctags_exclude {{{ 

" TODO B something has to be missing
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'build', 'bin', 'compiled',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache', '*.cache',
      \ 'docs', 'example',
      \ 'bundle', 'vendor',
      \ '*.md', '*.txt', '*.rst', '*.asciidoc',
      \ '*-lock.json', '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '*.json', '*.yaml', '*.toml', '*.ini',
      \ '*.conf', '.*rc*',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak', '*.bck',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.pdb',
      \ 'tags*', 'cscope.*',
      \ '*.css', '*.less', '*.scss',
      \ '*.hi',
      \ '*.cma', '*.cmx',
      \ '*.exe', '*.dll', '*.o', '*.so', '*.a',
      \ '*.out', '*.elf', '*.bin',
      \ '*.mp3', '*.ogg', '*.flac', '*.mp4', '*.mkv', '*.webm', '*.m4a',
      \ '*.swp', '*.swo', '*~', '#*',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.jpeg',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

" }}} 

" maps {{{ 

nnoremap <Space>tqg :<C-u>GutentagsToggleEnabled<CR>
nnoremap <Space>tqt :<C-u>GutentagsToggleTrace<CR>
nnoremap <Space>tqc :<C-u>GutentagsClearCache<CR>

" }}} 

" }}} 

" tagbar {{{

" filetypes {{{

let g:tagbar_type_make = {
      \ 'kinds':[
      \ 'm:macros',
      \ 't:targets'
      \ ]
      \}

let g:tagbar_type_markdown = {
  \ 'ctagstype' : 'markdown',
  \ 'kinds'   : [
    \ 'c:chapter:0:1',
    \ 's:section:0:1',
    \ 'S:subsection:0:1',
    \ 't:subsubsection:0:1',
    \ 'T:l4subsection:0:1',
    \ 'u:l5subsection:0:1',
  \ ],
  \ 'sro'     : '""',
  \ 'kind2scope'  : {
    \ 'c' : 'chapter',
    \ 's' : 'section',
    \ 'S' : 'subsection',
    \ 't' : 'subsubsection',
    \ 'T' : 'l4subsection',
  \ },
  \ 'scope2kind'  : {
    \ 'chapter' : 'c',
    \ 'section' : 's',
    \ 'subsection' : 'S',
    \ 'subsubsection' : 't',
    \ 'l4subsection' : 'T',
  \ },
\ }

" }}}

" maps {{{

nnoremap <Leader>le :<C-u>TagbarToggle<CR>
nnoremap <Leader>lE :<C-u>TagbarOpenAutoClose<CR>
nnoremap <Leader>ls :<C-u>TagbarTogglePause<CR>

nnoremap <Leader>lt :<C-u>TagbarCurrentTag<CR>
noremap <Leader>l<Space>t :<C-u>TagbarCurrentTag<Space>
nnoremap <Leader>lu :<C-u>TagbarForceUpdate<CR>

nnoremap <expr> <Leader>ln
      \ ":<C-u>call CmdCount('TagbarJumpNext', ".v:count1.")<CR>"
nnoremap <expr> <Leader>lp
      \ ":<C-u>call CmdCount('TagbarJumpPrev', ".v:count1.")<CR>"

" }}}

" }}}

" Makeshift {{{

command -nargs=0 SMake
      \ if g:qfloc
      \| LMake
      \| else
      \| Make
      \| endif

command -nargs=0 SMakeshiftBuild
      \ if g:qfloc
      \| LMakeshiftBuild
      \| else
      \| MakeshiftBuild
      \| endif

cnoreabbrev <expr> Make (g:qfloc) ? 'Lmake' : 'Make'
cnoreabbrev <expr> MakeshiftBuild (g:qfloc) ? 'LMakeshiftBuild' : 'MakeshiftBuild'

" }}}
