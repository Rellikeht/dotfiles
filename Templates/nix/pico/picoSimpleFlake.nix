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
        cc = pkgs.gcc-arm-embedded;
        # }}}
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          # {{{

          # {{{
          name = "pico-hello-world";
          src = self;
          PICO_SDK_PATH = "${sdk-pkg}/lib/pico-sdk";
          PICO_SDK_BIN = "${sdk-pkg}/bin";
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
              python3
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
              cp -r *.uf2 $out
            ''; # }}}

          # }}}
        };
      }
    );
}
