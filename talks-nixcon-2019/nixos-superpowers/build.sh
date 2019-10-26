export NIX_PATH=nixos-config=$PWD/configuration.nix:nixpkgs=channel:nixos-19.09

nixos-rebuild build-vm
