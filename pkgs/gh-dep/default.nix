{
  source,
  lib,
  buildGo126Module,
}:
buildGo126Module rec {
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
  vendorHash = "sha256-GkOVUN2gCTgKB8IpvIQdRkk+BFC4mgnNlck1Z3MkrXw=";
  # keep-sorted end
}
