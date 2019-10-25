let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "network" { buildInputs = [ ]; }
  ''
    curl http://1.1.1.1
  ''
