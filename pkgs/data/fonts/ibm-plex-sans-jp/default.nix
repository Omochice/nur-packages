{
  source,
  lib,
  stdenvNoCC,
  unzip,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  nativeBuildInputs = [ unzip ];

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
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
