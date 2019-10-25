let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    cp ${./talk.md} $out
  ''
