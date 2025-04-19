{
  description = "Home Manager configuration of hank";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kvim = {
      url = "github:HCHogan/kvim";
      flake = false;
    };

    hvim = {
      url = "github:HCHogan/hvim";
      flake = false;
    };

  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."hank" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit inputs; };

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
