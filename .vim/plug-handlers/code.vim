" cosco

"nmap <silent> ; <Plug>(cosco-commaOrSemiColon)
map <silent> <C-;> <C-o><Plug>(cosco-commaOrSemiColon)
" let g:cosco_ignore_comment_lines = 1

" nix

autocmd FileType nix setlocal commentstring=#\ %s
autocmd FileType nix setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType nix map <buffer> <Leader>nle :NixEdit<CR>
autocmd FileType nix map <buffer> <Leader>nlE :NixEdit<CR>

" neoformat

" This probably isn't needed, because of lsp
"let g:neoformat_enabled_go = ['gofmt']
let g:neoformat_enabled_go = []

" ???
let g:neoformat_enabled_python = ['ruff', 'autopep8', 'flake8']

let g:neoformat_enabled_c = ['clangformat', 'astyle', 'uncrustify']
let g:neoformat_enabled_cpp = ['clangformat', 'astyle', 'uncrustify']
let g:neoformat_enabled_nix = ['alejandra']
let g:neoformat_enabled_ocaml = ['ocamlformat', 'topiary']
let g:neoformat_enabled_haskell = ['floskell']
" TODO clangformat

autocmd FileType dhall let b:buffmt=0 " :(((
" done in zig plugin
"let g:neoformat_enabled_zig = ['zig_fmt']

" Untested
let g:neoformat_enabled_lua = ['luaformat']
let g:neoformat_enabled_nim = ['nimpretty']
let g:neoformat_enabled_shell = ['shfmt', 'topiary']
let g:neoformat_enabled_zsh = ['shfmt']
let g:neoformat_enabled_markdown = ['mdformat', 'prettierd', 'prettier']
let g:neoformat_enabled_yaml = ['yamlfix', 'pyaml', 'prettierd', 'prettier']

let g:neoformat_markdown_mdformat = {
        \ 'exe': 'mdformat',
        \ 'args': ['--number', '--wrap', '64', '-'],
        \ 'stdin': 1,
        \ }
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
" from reading README, but somehow This
" shit works
let g:neoformat_typst_typstfmt = {
            \'exe': 'typstfmt',
            \'args': ['-o -'],
            \'stdin': 1,
            \'stderr': 1,
            \'replace': 0,
            \'no_append': 1,
            \}
let g:neoformat_enabled_typst = ["typstfmt"]

" ???
"let b:neoformat_run_all_formatters = 1
let b:neoformat_basic_format_retab = 1
let g:neoformat_only_msg_on_error = 1

augroup fmt
  autocmd!
  autocmd BufWritePre *
              \ if b:buffmt
              \| try
              \| undojoin
              \| Neoformat
              \| catch /E790/
              \| Neoformat
              \| endtry
              \| endif
augroup END

map <Leader>Ff :Neoformat<CR>
map <Leader>FF :Neoformat<Space>

" context
" TODO B sane settings
map <Leader>qt :ContextPeek<CR>
map <Leader>qT :ContextToggle<CR>
map <Leader>qW :ContextToggleWindow<CR>

" TODO D emmet

" zig.vim
" TODO C compiler

let g:zig_fmt_autosave = 1

" julia-vim
let g:latex_to_unicode_keymap = 1
let g:latex_to_unicode_tab = "on"
let g:latex_to_unicode_file_types = '.*'
noremap <expr> <Leader>nlt LaTeXtoUnicode#Toggle()
autocmd FileType julia map <buffer> <Leader>nld :execute 'JuliaDoc '.GetVisualSelection()<CR>
autocmd FileType julia map <buffer> <Leader>nlD :JuliaDoc

" direnv.vim
" let g:direnv_auto = 0
let g:direnv_edit_mode = 'split'

map <Leader>qde :EditEnvrc<CR>
map <Leader>qdE :EditDirenvrc<CR>
map <Leader>qdl :DirenvExport<CR>

" others

function GeneralUpgrade()
    PlugUpgrade
    PlugUpdate --sync
endfunction

autocmd FileType zinc setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType zinc setlocal commentstring=%\ %s

" Pluto.jl :)

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

map <Leader>npc :exe 'norm i# ╔═╡ '.NuuidNewUuid()<CR>
map <Leader>npa :call PlutoAdd()<CR>
map <Leader>npA :call PlutoAdd(1)<CR>

" Toggle visibility when in cell list
map <Leader>npT 03lx:call PLR()<CR>P
" Toggle visibility when in cell
map <Leader>npt 0wwv$hy<Esc>/<C-r>=@<CR><CR>,npTnn

" TODO disable
" Start:
"#=╠═╡
" End:
"  ╠═╡ =#

" Disabled in file:
"# ╠═╡ skip_as_script = true
" Disabled:
"# ╠═╡ disabled = true
