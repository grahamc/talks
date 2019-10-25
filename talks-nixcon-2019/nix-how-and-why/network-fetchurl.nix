let
  pkgs = import <nixpkgs> {};
in pkgs.fetchurl {
  url = "http://grahamc.com";
  sha256 = "1qjjjhb7ag0and4jrjc2ywb6mqm55w4p65c2rkhpw9vh9l14g0b4";
}
