{ pkgs, config, ... }: {
  i18n.consoleKeyMap = "dvorak";

  services.nginx = {
    enable = false;
    virtualHosts."_".root = ./public;
  };

  networking = {
    firewall.allowedTCPPorts = [ 80 443 ];
    hostName = "hello";
  };

  users = {
    extraUsers.root.initialHashedPassword = "";
    mutableUsers = false;

    motd = with config; ''
      Welcome to ${networking.hostName}

      - This machine is managed by NixOS
      - All changes are futile

      OS:      NixOS ${system.nixos.release} (${system.nixos.codeName})
      Version: ${system.nixos.version}
      Kernel:  ${boot.kernelPackages.kernel.version}
    '';
  };

  environment.systemPackages = with pkgs; [ vim emacs25-nox ];
}
