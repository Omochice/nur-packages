{
  source,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  installPhase = ''
    mkdir -p $out
    runHook preInstall
    find fonts -type f -name "*.otf" -exec install -Dm644 {} -t $out/share/fonts/opentype \;
    runHook postInstall
  '';

  meta = with lib; {
    description = "The package of IBM’s typeface, IBM Plex.";
    homepage = "https://github.com/IBM/plex";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
