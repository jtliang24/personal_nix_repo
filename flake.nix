{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      # Define ArtixGameLauncher only for x86_64-linux
      artixSystem = "x86_64-linux";
      artixPkgs = import nixpkgs { system = artixSystem; };
      ArtixGameLauncher = artixPkgs.callPackage ./Artix_Game_Launcher.nix {};
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages = {
          kando = pkgs.callPackage ./kando.nix {};
          hello = pkgs.callPackage ./hello.nix {};
        };

        #apps = {
        #  kando = flake-utils.lib.mkApp {
        #    drv = pkgs.callPackage ./kando.nix {};
        #  };
        #};
      }
    ) // {
      # Add ArtixGameLauncher separately
      packages.${artixSystem}.ArtixGameLauncher = ArtixGameLauncher;
      #apps.${artixSystem}.ArtixGameLauncher = flake-utils.lib.mkApp {
      #  drv = ArtixGameLauncher;
      #};
    };
}
