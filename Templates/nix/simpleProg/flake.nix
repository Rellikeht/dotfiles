{
  description = "Simple flake for building some program";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flakeUtils.url = "github:numtide/flake-utils";
    package = {
      url = "github:user/program";
      flake = false;
    };

    dependency1.url = "../dependency";
    dependency2.url = "github:user/program";
    dependency3.url = "https://git.com/repo";
  };

  outputs = {
    self,
    nixpkgs,
    flakeUtils,
    package,
    dependency1,
    dependency2,
    dependency3,
  }: let
    systems = [
      "x86_64-linux"
      "i686-linux"

      "aarch64-linux"
      "armv7l-linux"

      "aarch64-darwin"
      "x86_64-darwin"
    ];
    flib = flakeUtils.lib;
  in
    flib.eachSystem systems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib;
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
            ++ [
              dependency1.${system}.default
              dependency2.${system}.default
              dependency3.${system}.default
            ];

          nativeBuildInputs = with pkgs; [
          ];

          meta = with lib; {
            homepage = "homepage";
            description = "description";
            # license = licenses.gpl3;
            mainProgram = "programName";
            maintainers = ["Rellikeht"];
            platforms = platforms.unix;

            longDescription = '''';
          };
        };
      };
    });
}
