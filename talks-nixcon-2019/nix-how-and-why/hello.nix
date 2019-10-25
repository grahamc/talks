let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    hello > $out
  ''
