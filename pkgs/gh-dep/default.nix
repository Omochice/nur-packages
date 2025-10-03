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
patches = [ ./patches/go-1-25-0.patch ];
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
  vendorHash = "sha256-kLLZw+56YiJ/CE/B5u5Y1vCSTs/YRqpQ9OkqBjgZ46E=";
  # keep-sorted end
}
