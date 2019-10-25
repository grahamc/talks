let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    echo hello > $out
  ''

