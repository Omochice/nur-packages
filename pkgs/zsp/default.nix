{
  source,
  lib,
  buildGoLatestModule,
  jdk_headless,
}:

buildGoLatestModule rec {
  inherit (source) pname src;
  version = lib.removePrefix "v" source.version;
  # keep-sorted start block=yes
  # The first two read testdata/apks/, which upstream does not ship, and the rest
  # need Android build tools at the hard-coded /opt/homebrew prefix.
  checkFlags = [
    "-skip=${
      lib.concatStringsSep "|" [
        "^TestLocalSource$/^glob_pattern$"
        "^TestFetchDirectURLSource$"
        "^TestUnsignedAPKFile$"
        "^TestFetchAPKUsesPrivateVerifiedSnapshot$"
        "^TestFetchLocalAPKReturnsVerifiedIdentity$"
        "^TestFetchKeepsValidatorsInHTTPCacheDir$"
        "^TestFetchReturnsErrNoNewAPKWhenETagUnchanged$"
        "^TestFetchWarnsWhenHTTPCacheCannotBeSaved$"
        "^TestPublishClearsHTTPCacheOnRetryableFailure$"
        "^TestPublishKeepsHTTPCacheOnCancel$"
        "^TestPublishKeepsHTTPCacheOnPermanentFailure$"
      ]
    }"
  ];
  doCheck = true;
  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];
  meta.changelog = "https://github.com/zapstore/zsp/releases/tag/v${version}";
  meta.description = "Publish apps to relays";
  meta.homepage = "https://github.com/zapstore/zsp";
  meta.license = lib.licenses.mit;
  meta.mainProgram = "zsp";
  # The keystore tests generate their JKS and PKCS#12 fixtures with keytool.
  # Providing it keeps those tests running instead of skipping a dozen of them.
  nativeCheckInputs = [ jdk_headless ];
  vendorHash = "sha256-HU0l8cLYatcserUZwGcNz/4qtyuU9GjIWqVWGwSipVI=";
  # keep-sorted end
}
