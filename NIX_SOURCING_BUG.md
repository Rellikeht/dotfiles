# Global files affected by bug in nix additions to configuration files

- /etc/zshrc
- /etc/bashrc
- /etc/bash.bashrc
- /etc/profile.d/nix.sh

# Fix

```sh
if [ -n "$__ETC_PROFILE_NIX_SOURCED" ]; then return; fi
export __ETC_PROFILE_NIX_SOURCED=1
```

or simply

```sh
export __ETC_PROFILE_NIX_SOURCED=1
```

after sourcing
