{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.startMenuLaunchers = true;

  services.openssh.enable = true;
  services.tailscale.enable = true;

  nix = {
    extraOptions = ''experimental-features = nix-command flakes'';
  };
  
  environment.systemPackages = with pkgs; [
    vim
    tmux
    xdg-utils
    inkscape
    curl
    rsync
    jq
    awscli2
    gum
    granted
    neofetch
    dialog
    git
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
