{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src;
  version = lib.removePrefix "v" source.version;
  # keep-sorted start block=yes
  # Upstream's "glob pattern" subtest lacks the missing-fixture skip guard that
  # its sibling subtests have, so it fails because testdata/apks/ is absent from
  # the release source. Skip only that subtest rather than disabling all checks.
  checkFlags = [ "-skip=^TestLocalSource$/^glob_pattern$" ];
  doCheck = true;
  env.CGO_ENABLED = 0;
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
  vendorHash = "sha256-INIDPettuY0y4h6NF8ltF9r/AMQx9Each9JVBe9+CGo=";
  # keep-sorted end
}
