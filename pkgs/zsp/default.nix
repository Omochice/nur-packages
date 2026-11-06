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
  # Upstream's "glob pattern" subtest lacks the missing-fixture skip guard that
  # its sibling subtests have, so it fails because testdata/apks/ is absent from
  # the release source. TestDeleteDownloadedAPKRemovesCacheAndTemp creates its
  # cache directory under HOME, which the sandbox points at the read-only
  # /homeless-shelter. Skip only these rather than disabling all checks.
  checkFlags = [
    "-skip=^TestLocalSource$/^glob_pattern$|^TestDeleteDownloadedAPKRemovesCacheAndTemp$"
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
