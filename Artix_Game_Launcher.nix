{
  appimageTools,
  fetchurl,
}:
let
  pname = "ArtixGameLauncher";
  version = "2.20";
  src = fetchurl {
    url = "https://launch.artix.com/latest/Artix_Games_Launcher-x86_64.AppImage";
    sha256 = "sha256-8eVXOm5g92wErWa6lbTXrCL04MWYlObjonHJk+oUI3E=";
  };
  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: [ ];

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    install -m 444 -D ${appimageContents}/ArtixGamesLauncher.desktop $out/share/applications/ArtixGamesLauncher.desktop
    install -m 444 -D ${appimageContents}/ArtixLogo.png $out/share/icons/ArtixLogo.png
  '';

}
