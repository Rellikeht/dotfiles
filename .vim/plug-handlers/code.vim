"{{{ cosco

"nmap <silent> ; <Plug>(cosco-commaOrSemiColon)
map <silent> <C-;> <C-o><Plug>(cosco-commaOrSemiColon)
" let g:cosco_ignore_comment_lines = 1

"}}}

"{{{ neoformat formatters
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
let g:neoformat_enabled_ocaml = ['ocamlformat', 'topiary']
let g:neoformat_enabled_haskell = ['floskell']

autocmd FileType dhall let b:buffmt=0 " :(((

" done in zig plugin
let g:neoformat_enabled_zig = []
"let g:neoformat_enabled_zig = ['zig_fmt']

let g:neoformat_enabled_nim = ['nimpretty']
let g:neoformat_enabled_shell = ['shfmt', 'topiary']
let g:neoformat_enabled_zsh = ['shfmt']
let g:neoformat_enabled_markdown = ['mdformat', 'prettierd', 'prettier']

let g:neoformat_enabled_lua = [
            \ 'luaformat',
            \ ]
            " \ 'luaformatter',
" let g:neoformat_lua_luaformat = {
"             \ 'exe': 'lua-format'
"             \ }


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

"}}}

"{{{ neoformat settings

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

"}}}

""{{{ context
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
""}}}

"{{{ TODO D emmet
"}}}

" {{{ zig.vim

" TODO C compiler

let g:zig_fmt_autosave = 1

"}}}

"{{{ julia-vim

let g:latex_to_unicode_keymap = 1
let g:latex_to_unicode_tab = "on"
let g:latex_to_unicode_file_types = '.*'

noremap <expr> <Leader>nlt LaTeXtoUnicode#Toggle()
autocmd FileType julia 
            \ nnoremap <buffer> <Leader>nld :JuliaDoc
            \ | vnoremap <silent> <buffer> <Leader>nld
            \ :<C-u>execute 'JuliaDoc '.GetVisualSelection()<CR>

"}}}

"{{{ direnv.vim
" TODO C this plugin is too shallow, it needs to be done better way

nnoremap <silent> <Leader>qde :EditEnvrc<CR>
nnoremap <silent> <Leader>qdE :EditDirenvrc<CR>
nnoremap <silent> <Leader>qdl :DirenvExport<CR>

"}}}

"{{{ vim-simple-complete

let g:vsc_type_complete = 1
let g:vsc_tab_complete = 0
let g:vsc_completion_command = "\<C-N>"
let g:vsc_reverse_completion_command = "\<C-P>"
let g:vsc_type_complete_length = 3
let g:vsc_pattern = '\k'

"}}}

"{{{ other filetypes

autocmd FileType nix 
            \ setlocal commentstring=#\ %s
            \ | setlocal shiftwidth=2 softtabstop=2 tabstop=2
            \ | nnoremap <buffer> <silent> <Leader>nle
            \ :NixEdit<CR>
            \ | nnoremap <buffer> <Leader>nl<Space>
            \ :NixEdit<Space>

autocmd FileType zinc 
            \ setlocal shiftwidth=2 softtabstop=2 tabstop=2
            \ | setlocal commentstring=%\ %s

"}}}

"{{{ others

function GeneralUpgrade()
    PlugUpgrade
    PlugUpdate --sync
endfunction

"}}}

" {{{ Pluto.jl :)

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
