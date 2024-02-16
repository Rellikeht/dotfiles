" cosco

"nmap <silent> ; <Plug>(cosco-commaOrSemiColon)
map <silent> <C-;> <C-o><Plug>(cosco-commaOrSemiColon)

" vimtex

" Viewer options: One may configure the viewer either by specifying a built-in
let g:vimtex_view_method = 'zathura'
" Works
let g:vimtex_compiler_method = 'latexmk'

" Also workWorkss
"let g:vimtex_compiler_method = 'tectonic'

" nix

autocmd FileType nix setlocal commentstring=#\ %s
autocmd FileType nix setlocal shiftwidth=2 softtabstop=2 tabstop=2

map <Leader>BN :NixEdit<CR>

" troff

autocmd FileType groff,troff,nroff setlocal shiftwidth=2 softtabstop=2 tabstop=2

" neoformat

" This probably isn't needed, because of lsp
"let g:neoformat_enabled_go = ['gofmt']
let g:neoformat_enabled_go = []

" ???
let g:neoformat_enabled_python = ['ruff', 'autopep8', 'flake8']

let g:neoformat_enabled_c = ['clang-format']
let g:neoformat_enabled_nix = ['alejandra']
let g:neoformat_enabled_ocaml = ['ocamlformat']
let g:neoformat_enabled_rust = ['rustfmt']
let g:neoformat_enabled_haskell = ['floskell']

" done in zig plugin
"let g:neoformat_enabled_zig = ['zig_fmt']

" ??
let g:neoformat_lua_luaformat = {
            \ 'exe': 'lua-format',
            \ 'args': [ 
            \ '--tab-width=2',
            \ '--indent-width=2',
            \ '--continuation-indent-width=2'
            \ ],
            \ }

" Untested
let g:neoformat_enabled_lua = ['luaformat']
let g:neoformat_enabled_nim = ['nimpretty']
let g:neoformat_enabled_shell = ['shfmt']
let g:neoformat_enabled_zsh = ['shfmt']

" ???
"let b:neoformat_run_all_formatters = 1
let b:neoformat_basic_format_retab = 1
let g:neoformat_only_msg_on_error = 1

augroup fmt
  autocmd!
  "autocmd BufWritePre * if b:buffmt | undojoin | Neoformat | endif
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

" others

function GeneralUpgrade()
    PlugUpgrade
    PlugUpdate --sync
endfunction

autocmd FileType zinc setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType zinc setlocal commentstring=%\ %s

let g:zig_fmt_autosave = 1
