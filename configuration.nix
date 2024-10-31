{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.startMenuLaunchers = true;

  services.openssh.enable = true;
  services.tailscale.enable = true;

  users.users.pim = {
	  name = "pim";
	  home = "/home/pim";
	  isNormalUser = true;
	  shell = "/run/current-system/sw/bin/zsh";
	  group = "wheel";
	  extraGroups = ["nixusers"];
  };


  nix = {
    extraOptions = ''experimental-features = nix-command flakes'';
    package = pkgs.nixFlakes;

    settings.trusted-substituters = [
      "http://attic.tools.technative.cloud:8080/smartmc"
    ];
    settings.extra-substituters = [
      "http://attic.tools.technative.cloud:8080/smartmc"
    ];
    settings.extra-trusted-public-keys = [
      "smartmc:uix5eOnUkmqH6VzKToVNFyEr7PNUmXKt1QDQqVdv2XA="
    ];

  };

  
  environment.systemPackages = with pkgs; [
    #luxery
    zsh
    vim
    home-manager
    age
    tmux
    rsync

    #extra
    xdg-utils
    neofetch
    dialog

    #basic devops
    tfswitch
    curl
    attic-client
    aws-mfa
    jq
    awscli2
    gum
    granted
    git
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
