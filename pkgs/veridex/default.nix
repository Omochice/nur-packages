{
  source,
  lib,
  stdenv,
  autoPatchelfHook,
  makeWrapper,
  unzip,
}:

let
  # The macOS prebuilt is an x86_64 Mach-O binary, which aarch64-darwin runs
  # through Rosetta 2. Upstream ships no aarch64 build to prefer over it.
  archive = if stdenv.hostPlatform.isDarwin then "veridex-mac.zip" else "veridex-linux.zip";
in
stdenv.mkDerivation {
  inherit (source) pname src version;

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
    unzip appcompat/${archive} -d $out/libexec/veridex
    makeWrapper $out/libexec/veridex/appcompat.sh $out/bin/appcompat.sh
    runHook postInstall
  '';

  meta.description = "Given an APK, finds API uses that fall into the blocklist/max-target-X/unsupported APIs.";
  meta.homepage = "https://android.googlesource.com/platform/art/+/refs/tags/${source.version}/tools/veridex/";
  meta.license = lib.licenses.asl20;
  meta.mainProgram = "appcompat.sh";
  meta.platforms = [
    "aarch64-darwin"
    "x86_64-darwin"
    "x86_64-linux"
  ];
  meta.sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
}
