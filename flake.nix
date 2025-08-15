{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = rec {
          ArtixGameLauncher = nixpkgs.legacyPackages."x86_64-linux".callPackage ./Artix_Game_Launcher.nix {};
          kando = pkgs.callPackage ./kando.nix {};
          hello = pkgs.callPackage ./hello.nix {};
        };
        apps = rec {
          ArtixGameLauncher = flake-utils.lib.mkApp { drv = self.packages."x86_64-linux".ArtixGameLauncher; };
          kando = flake-utils.lib.mkApp { drv = self.packages.${system}.kando; };
        };
      }
  );
}
