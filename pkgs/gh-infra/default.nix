{
  source,
  lib,
  buildGoModule,
}:
buildGoModule rec {
  inherit (source) pname src version;
  # keep-sorted start block=yes
  doCheck = true;
  env.CGO_ENABLED = 0;
  ldflags = [
    "-s"
    "-w"
    "-X main.revision=unknown"
    "-X main.version=${version}"
  ];
  meta.changelog = "https://github.com/babarot/gh-infra/releases/tag/${version}";
  meta.description = "Declarative GitHub infrastructure management via YAML";
  meta.homepage = "https://github.com/babarot/gh-infra/";
  meta.license = lib.licenses.mit;
  meta.mainProgram = "gh-infra";
  vendorHash = "sha256-w0Ix1xpJQ5H4NttZCjF1ZWE0/o2US5K76X2bxMrtBF4=";
  # keep-sorted end
}
