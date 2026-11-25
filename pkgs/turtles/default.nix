{
  sources,
  lib,
  stdenv,
  autoPatchelfHook,
  versionCheckHook,
}:
let
  # Building from source needs the MoonBit toolchain, which nixpkgs does not provide.
  source =
    sources.${stdenv.hostPlatform.system}
      or (throw "turtles: no prebuilt binary for ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "turtles";
  version = lib.removePrefix "v" sources.x86_64-linux.version;
  inherit (source) src;
  # keep-sorted start block=yes
  doInstallCheck = true;
  dontUnpack = true;
  meta = with lib; {
    description = "Mutation testing for MoonBit projects";
    homepage = "https://github.com/gpui-mbt/turtles.mbt";
    changelog = "https://github.com/gpui-mbt/turtles.mbt/blob/main/CHANGELOG.md";
    license = licenses.mit;
    mainProgram = "turtles";
    platforms = builtins.attrNames sources;
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
  nativeBuildInputs = lib.optionals stdenv.hostPlatform.isLinux [ autoPatchelfHook ];
  nativeInstallCheckInputs = [ versionCheckHook ];
  # keep-sorted end

  installPhase = ''
    runHook preInstall
    install -Dm755 $src $out/bin/turtles
    runHook postInstall
  '';
}
