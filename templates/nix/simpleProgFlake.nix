{
  description = "Simple flake for building some program";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    flakeUtils.url = github:numtide/flake-utils;
    package = {
      url = github:user/program;
      flake = false;
    };

    dependency.url = "../dependency";
  };

  outputs = {
    self,
    nixpkgs,
    flakeUtils,
    package,
    dependency,
  }:
    flakeUtils.lib.eachSystem [systems] (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      name = "program";
      src = package;
    in {
      packages = {
        default = pkgs.stdenv.mkDerivation {
          inherit name system src;

          CMAKE_MAKE_PROGRAM = "make -j $NIX_BUILD_CORES";

          buildInputs = with pkgs;
            [
            ]
            ++ [dependencypackages.${system}.default];

          nativeBuildInputs = with pkgs; [
          ];

          meta = with nixpkgs.lib; {
            homepage = "homepage";
            description = "description";
          };
        };
      };
    });
}
