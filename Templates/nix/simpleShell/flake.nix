{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flakeUtils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flakeUtils,
  }:
    flakeUtils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        packages = with pkgs;
          [
            #
          ]
          ++ (with self.packages.${system}; [default]);
      in {
        devShells = {
          default = pkgs.mkShell {
            inherit packages;
            phases = [];
            shellHook = '''';
          };
        };

        packages = rec {
          default = pkgs.writeScriptBin "run" ''
            echo "Do the thing"
          '';
        };

        apps = rec {
          default = {
            type = "app";
            program = "${self.packages.${system}.default}/bin/run";
          };
        };
      }
    );
}
