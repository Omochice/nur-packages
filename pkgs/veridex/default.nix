{
  lib,
  stdenv,
  autoPatchelfHook,
  fetchzip,
  makeWrapper,
  unzip,
}:

let
  version = "android-15.0.0_r25";
  # The macOS prebuilt is an x86_64 Mach-O binary, which aarch64-darwin runs
  # through Rosetta 2. Upstream ships no aarch64 build to prefer over it.
  archive = if stdenv.hostPlatform.isDarwin then "veridex-mac.zip" else "veridex-linux.zip";
in
stdenv.mkDerivation {
  pname = "veridex";
  inherit version;

  # Gitiles can archive a single directory, and only appcompat is needed.
  # Archiving the whole prebuilts/runtime repository downloads hundreds of
  # megabytes to reach the same two zips.
  src = fetchzip {
    name = "veridex-prebuilts-${version}";
    url = "https://android.googlesource.com/platform/prebuilts/runtime/+archive/refs/tags/${version}/appcompat.tar.gz";
    stripRoot = false;
    hash = "sha256-slqJwsUwfcDvN8oWF8YM4z+wk51qMqICR3yF5dxSFaY=";
  };

  nativeBuildInputs = [
    makeWrapper
    unzip
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [ autoPatchelfHook ];

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [ stdenv.cc.cc.lib ];

  dontBuild = true;

  # appcompat.sh only takes its prebuilt code path when veridex and the data
  # files sit next to it, so the archive stays whole under libexec and is
  # reached through a wrapper. A symlink into bin would make the script look
  # for its siblings in bin and fall back to the Android tree layout.
  installPhase = ''
    runHook preInstall
    mkdir -p $out/libexec
    unzip ${archive} -d $out/libexec/veridex
    makeWrapper $out/libexec/veridex/appcompat.sh $out/bin/appcompat.sh
    runHook postInstall
  '';

  meta.description = "Given an APK, finds API uses that fall into the blocklist/max-target-X/unsupported APIs.";
  meta.homepage = "https://android.googlesource.com/platform/art/+/refs/tags/${version}/tools/veridex/";
  meta.license = lib.licenses.asl20;
  meta.mainProgram = "appcompat.sh";
  meta.platforms = [
    "aarch64-darwin"
    "x86_64-darwin"
    "x86_64-linux"
  ];
  meta.sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
}
