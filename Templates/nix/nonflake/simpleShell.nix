{pkgs ? (import <nixpkgs> {}), ...}: let
  nativeBuildInputs = with pkgs; [
  ];
in
  pkgs.mkShell {
    packages = nativeBuildInputs;
    phases = [];
    shellHook = ''
    '';
  }
