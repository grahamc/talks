let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "network"
{ buildInputs = [ pkgs.curl ]; }
  ''
    curl http://1.1.1.1
  ''
