if exists("b:did_ftplugin")
  finish
endif

let if get(b:, 'compilers', 0) == 0
  let b:compilers = []
endif
b:compilers += ['nix-build', 'flake-build']

if expand('%:t') == 'flake.nix'
  compiler flake-build
else
  compiler nix-build
endif
