{
  description = "DESCRIPTION";

  inputs.nixpkgs.url = github:NixOS/nixpkgs;

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    name = "PACKAGE NAME";
    src = self;
  in {
    packages.x86_64-linux.default = with import nixpkgs {system = system;};
      stdenv.mkDerivation {
        inherit name src;

        PREFIX = "$(out)";
        CC = pkgs.gcc;

        #       Build dependencies
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
}
