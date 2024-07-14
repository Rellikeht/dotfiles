{
  description = "Simple Raspberry Pi Pico project";

  inputs = {
    # {{{
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    builds = {
      url = "github:Rellikeht/nix-builds";
    };
  }; # }}}

  outputs = {
    # {{{
    self,
    nixpkgs,
    flake-utils,
    builds,
    # }}}
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        # {{{
        pkgs = nixpkgs.legacyPackages.${system};
        sdk-pkg = builds.packages.${system}.pico-sdk;
        cc = pkgs.gcc-arm-embedded;
        # }}}
      in rec {
        packages.default = pkgs.stdenv.mkDerivation {
          # {{{

          # {{{
          name = "pico-examples";
          src = examples;
          PICO_SDK_PATH = "${sdk-pkg}/lib/pico-sdk";
          # }}}

          phases = [
            # {{{
            "unpackPhase"
            "configurePhase"
            "buildPhase"
            "installPhase"
          ]; # }}}

          nativeBuildInputs = with pkgs;
            [
              # {{{
              cmake
            ] # }}}
            ++ [
              # {{{
              cc
            ]; # }}}

          cmakeFlags = [
            # {{{
            "-D CMAKE_C_COMPILER=${cc}/bin/arm-none-eabi-gcc"
            "-D CMAKE_CXX_COMPILER=${cc}/bin/arm-none-eabi-g++"
          ]; # }}}

          installPhase =
            # {{{
            ''
              mkdir -p $out
            ''; # }}}

          # }}}
        };
      }
    );
}
