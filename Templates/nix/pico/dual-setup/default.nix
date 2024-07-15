let
  b = builtins;
  fallback-sdk = b.getFlake "github:Rellikeht/nix-builds?dir=pico-sdk";
in
  {
    # {{{
    pkgs ? (import <nixpkgs> {}),
    sdk-pkg ? fallback-sdk.packages.${pkgs.system}.default,
    # }}}
  }: let
    cc = pkgs.gcc-arm-embedded;
  in
    pkgs.stdenv.mkDerivation {
      # {{{

      # {{{
      name = "pico-hello-world";
      src = ./.;
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

      preConfigure =
        # {{{
        ''
          rm -rf build
        ''; # }}}

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
    }
