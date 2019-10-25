let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ pkgs.hello ]; }
  ''
    hello > $out
  ''
