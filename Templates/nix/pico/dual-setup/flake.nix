{
  description = "Raspberry Pi Pico Hello World";

  inputs = {
    # {{{
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    sdk = {
      url = "github:Rellikeht/nix-builds?dir=pico-sdk";
    };
  }; # }}}

  outputs = {
    # {{{
    self,
    nixpkgs,
    flake-utils,
    sdk,
    # }}}
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        # {{{
        pkgs = nixpkgs.legacyPackages.${system};
        sdk-pkg = sdk.packages.${system}.default;
        # }}}
      in {
        packages.default = import ./default.nix {inherit pkgs sdk-pkg;};
      }
    );
}
