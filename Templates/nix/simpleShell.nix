{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
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

        packages =
          []
          ++ (with pkgs; [])
          ++ (with self.packages.${system}; [run]);
      in {
        devShells = {
          default = pkgs.mkShell {
            inherit packages;
            phases = [];
            shellHook = '''';
          };
        };

        packages = rec {
          run = pkgs.writeScriptBin "run" ''
            echo "Do the thing"
          '';
          default = run;
        };

        apps = rec {
          run = {
            type = "app";
            program = "${self.packages.${system}.run}/bin/run";
          };
          default = run;
        };
      }
    );
}
