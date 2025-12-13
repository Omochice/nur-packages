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
  meta = {
    # keep-sorted start block=yes
    changelog = "https://github.com/jackchuka/gh-dep/releases/tag/${version}";
    description = "A GitHub CLI extension that streamlines the review and merge workflow for automated dependency update PRs.";
    homepage = "https://github.com/jackchuka/gh-dep";
    license = lib.licenses.mit;
    mainProgram = "gh-dep";
    # keep-sorted end
  };
  vendorHash = "sha256-NS6r8NcHFvZ7xMvUC+88tlUstUthanTRFtveN7/vJ3s=";
  # keep-sorted end
}
