{
  pkgs,
  configFile ? null,
}:
pkgs.stdenv.mkDerivation {
  pname = "dwm";
  version = "patched";

  src = pkgs.lib.cleanSource ./.;

  buildInputs = [
    pkgs.xorg.libX11
    pkgs.xorg.libXft
    pkgs.xorg.libXinerama
  ];

  postUnpack =
    if configFile != null
    then ''
      echo "🔧 Overriding config.h"
      cp ${configFile} $sourceRoot/config.h
    ''
    else ''
      echo "⚙️  Using default config.h from source"
    '';

  installPhase = ''
    mkdir -p $out/bin
    make PREFIX=$out install
  '';

  meta = {
    description = "Patched DWM from local source";
    homepage = "https://dwm.suckless.org/";
    license = pkgs.lib.licenses.mit;
    platforms = pkgs.lib.platforms.linux;
  };
}
