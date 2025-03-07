if exists("b:did_ftplugin")
  finish
endif

let b:compilers = get(b:, 'compilers', [])
let b:compilers += ['nix-build', 'flake-build']

nnoremap <buffer> <silent> <Leader>nle
      \ :NixEdit<CR>
nnoremap <buffer> <Leader>nl<Space>
      \ :NixEdit<Space>

if expand('%:t') == 'flake.nix'
  compiler flake-build
else
  compiler nix-build
endif
