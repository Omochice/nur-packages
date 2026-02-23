{
  source,
  lib,
  buildGoModule,
}:
buildGoModule rec {
  inherit (source) pname src version;
  # keep-sorted start block=yes
  doCheck = false;
  env.CGO_ENABLED = 0;
  ldflags = [
    "-s"
    "-w"
  ];
  meta.changelog = "https://github.com/jackchuka/gh-dep/releases/tag/${version}";
  meta.description = "A GitHub CLI extension that streamlines the review and merge workflow for automated dependency update PRs.";
  meta.homepage = "https://github.com/jackchuka/gh-dep";
  meta.license = lib.licenses.mit;
  meta.mainProgram = "gh-dep";
  vendorHash = "sha256-njInErbSVChWzZFm3hmdnwo5KDzyBD4mVCBO4xWk33s=";
  # keep-sorted end
}
