if exists("b:did_ftplugin")
  finish
endif

let b:compilers += ['nix-build', 'flake-build']

if expand('%:t') == 'flake.nix'
  compiler flake-build
else
  compiler nix-build
endif
