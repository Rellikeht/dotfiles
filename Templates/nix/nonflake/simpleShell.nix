{pkgs ? (import <nixpkgs> {}), ...}: let
  packages = with pkgs; [
  ];
in
  pkgs.mkShell {
    inherit packages;
    phases = [];
    shellHook = ''
    '';
  }
