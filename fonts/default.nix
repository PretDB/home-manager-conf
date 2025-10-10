{ stdenvNoCC, lib }:
stdenvNoCC.mkDerivation {
  pname = "my_fonts_collection";
  version = "0.1";
  src = ./.;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    if [ -d "$src/fonts" ]; then
      cp -r $src/fonts/*.ttf $out/share/fonts/truetype/
    else
      echo "No fonts found in $src/fonts"
      exit 0
    fi
  '';

  meta = with lib; {
    description = "仿宋_GB2312";
    homepage = "https://www.pretdb.com/";
    platforms = platforms.all;
  };
}

