{
  fetchFromGitiles,
  source,
  lib,
  stdenvNoCC,
  unzip,
  pkgs,
}:
let
  target =
    if pkgs.stdenv.hostPlatform.isDarwin then
      {
        file = "veridex-mac.zip";
        hash = "sha256-IaFtakCDE/VeWAT3Okojon8ajuFzAe/wvY7kEBGajAM=";
      }
    else
      {
        file = "veridex-linux.zip";
        hash = "sha256-7wpNcsCfMaQZ5hvDLUG+JD7AM7oRBFVnl8yaURQ2Mkc=";
      };
in
stdenvNoCC.mkDerivation {
  inherit (source) pname version;

  nativeBuildInputs = [ unzip ];

  src = fetchFromGitiles {
    url = "https://android.googlesource.com/platform/prebuilts/runtime";
    rev = "android-15.0.0_r25";
    hash = target.hash;
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    unzip appcompat/${target} -d $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    description = "Given an APK, finds API uses that fall into the blocklist/max-target-X/unsupported APIs.";
    homepage = "https://android.googlesource.com/platform/art/+/refs/tags/${source.version}/tools/veridex/";
    license = licenses.asl20;
    platforms = [
      "x86_64-linux"
      "aarch64-darwin"
    ];
  };
}
