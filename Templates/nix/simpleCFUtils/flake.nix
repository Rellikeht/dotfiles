{
  description = "DESCRIPTION";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flakeUtils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flakeUtils,
  }: let
    flib = flakeUtils.lib;
  in
    flib.eachSystem [
      "x86_64-linux"
      "aarch64-linux"
    ] (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      name = "NAME";
      src = self;
    in {
      packages = {
        default = pkgs.stdenv.mkDerivation {
          inherit name system src;

          PREFIX = "$(out)";
          CC = pkgs.gcc;

          buildInputs = with pkgs; [
            xorg.libX11
            xorg.libXft
          ];

          buildPhase = "
            make clean
            make
            ";

          installPhase = "
          mkdir -p $out/bin
          make install
          ";
        };
      };
    });
}
