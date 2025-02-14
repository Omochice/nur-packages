{
  source,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  installPhase = ''
    runHook preInstall
    install -Dm644 *.ttf -t $out/share/fonts/FirgeNerd
    runHook postInstall
  '';

  meta = with lib; {
    description = "Programming font that combines Genshin Gothic and Fira Mono with Nerd Font";
    homepage = "https://github.com/yuru7/Firge";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
