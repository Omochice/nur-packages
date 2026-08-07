{
  fetchzip,
  lib,
  stdenvNoCC,
  unzip,
}:
let
  version = "android-15.0.0_r25";
  archive = if stdenvNoCC.hostPlatform.isDarwin then "veridex-mac.zip" else "veridex-linux.zip";
in
stdenvNoCC.mkDerivation {
  inherit version;

  pname = "veridex";

  nativeBuildInputs = [ unzip ];

  # Gitiles can archive a single directory, and only appcompat is needed.
  # Archiving the whole prebuilts/runtime repository downloads hundreds of
  # megabytes to reach the same two zips.
  src = fetchzip {
    name = "veridex-prebuilts-${version}";
    url = "https://android.googlesource.com/platform/prebuilts/runtime/+archive/refs/tags/${version}/appcompat.tar.gz";
    stripRoot = false;
    hash = "sha256-slqJwsUwfcDvN8oWF8YM4z+wk51qMqICR3yF5dxSFaY=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    unzip ${archive} -d $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    description = "Given an APK, finds API uses that fall into the blocklist/max-target-X/unsupported APIs.";
    homepage = "https://android.googlesource.com/platform/art/+/refs/tags/${version}/tools/veridex/";
    license = licenses.asl20;
    platforms = [
      "x86_64-linux"
      "aarch64-darwin"
    ];
    mainProgram = "appcompat.sh";
  };
}
