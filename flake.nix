{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        devshell.follows = "";
        flake-compat.follows = "";
        git-hooks.follows = "";
        home-manager.follows = "";
        nix-darwin.follows = "";
        treefmt-nix.follows = "";
      };
    };
  };

  outputs =
    { self, nixpkgs, nixvim, flake-parts, ...  }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      perSystem =
        { system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config = {
              nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
              permittedInsecurePackages = [
                "dotnet-core-combined"
                "dotnet-sdk-6.0.428"
                "dotnet-sdk-7.0.410"
                "dotnet-sdk-wrapped-6.0.428"
              ];
            };
          };
          nixvimModule = {
            inherit pkgs;
            module = import ./config;
            extraSpecialArgs = {
              inherit self;
              inherit system;
            };
          };
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nixvim.legacyPackages.${system}.makeNixvimWithModule nixvimModule;
          };
        };
    };
}
