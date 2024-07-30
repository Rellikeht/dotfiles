if exists("b:did_ftplugin")
  finish
endif

compiler nix-build
