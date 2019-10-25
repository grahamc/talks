let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    /nix/store/ccsr8xxhzj1hdig4p2cpdrw6ayrfrlid-hello-2.10/bin/hello > $out
  ''
