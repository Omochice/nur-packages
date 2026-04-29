{
  source,
  lib,
  stdenv,
  nodejs,
  makeWrapper,
  fetchNpmDeps,
}:

let
  npmDeps = fetchNpmDeps {
    src = source.src;
    sourceRoot = "package";
    hash = "sha256-mul/em8FSbrza9NAipB+w+tdAkLNGHbK8U1aRj1PLtw=";
    npmDepsFetcherVersion = 2;
  };
in
stdenv.mkDerivation rec {
  inherit (source) pname version;
  src = source.src;
  sourceRoot = "package";

  nativeBuildInputs = [
    nodejs
    makeWrapper
  ];

  # The shrinkwrap was generated on Linux (no fsevents) which causes `npm ci`
  # to fail on macOS. Use `npm install --offline` which is more lenient.
  configurePhase = ''
    runHook preConfigure
    export HOME="$TMPDIR"
    export npm_config_cache="$TMPDIR/npm_cache"
    cp -r ${npmDeps}/. "$npm_config_cache"
    chmod -R u+w "$npm_config_cache"
    npm install --offline --legacy-peer-deps --ignore-scripts --no-audit --no-fund --omit=dev
    runHook postConfigure
  '';

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib/node_modules/@salesforce/cli
    cp -r . $out/lib/node_modules/@salesforce/cli
    mkdir -p $out/bin

    # Create wrapper scripts instead of symlinks because patchShebangs
    # mishandles the complex shebang `#!/usr/bin/env -S node --no-deprecation`
    for cmd in sf sfdx; do
      makeWrapper ${nodejs}/bin/node $out/bin/$cmd \
        --add-flags "--no-deprecation" \
        --add-flags "$out/lib/node_modules/@salesforce/cli/bin/run.js" \
        --set SF_AUTOUPDATE_DISABLE true \
        --set SF_DISABLE_TELEMETRY true
    done
    runHook postInstall
  '';

  meta = with lib; {
    description = "Salesforce CLI for interacting with Salesforce orgs and services";
    homepage = "https://github.com/salesforcecli/cli";
    changelog = "https://github.com/salesforcecli/cli/releases/tag/${version}";
    license = licenses.asl20;
    mainProgram = "sf";
  };
}
