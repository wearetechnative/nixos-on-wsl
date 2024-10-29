{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    bmc.url = "github:wearetechnative/bmc";
    race.url = "github:wearetechnative/race";
    jsonify-aws-dotfiles.url = "github:mipmip/jsonify-aws-dotfiles";
  };

  outputs = { self, nixpkgs, nixos-wsl, race, bmc, jsonify-aws-dotfiles, ... }:
  let
    defaultSystem = "x86_64-linux";
    extraPkgs = {
      environment.systemPackages = [
        bmc.packages."${defaultSystem}".bmc
        jsonify-aws-dotfiles.packages."${defaultSystem}".jsonify-aws-dotfiles
        race.packages."${defaultSystem}".race
      ];
    };
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = defaultSystem;
	
        modules = [
          nixos-wsl.nixosModules.default
	  ./configuration.nix
	  extraPkgs
        ];
      };
    };
  };
}
