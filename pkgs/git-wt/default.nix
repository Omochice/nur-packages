{
  source,
  lib,
  buildGo126Module,
  git,
}:
buildGo126Module rec {
  inherit (source) pname src version;
  # keep-sorted start block=yes
  doCheck = true;
  env.CGO_ENABLED = 0;
  ldflags = [
    "-s"
    "-w"
    "-X github.com/k1LoW/gh-wt.Revision=unknown"
  ];
  meta.changelog = "https://github.com/k1LoW/git-wt/releaess/tag/${version}";
  meta.description = "A Git subcommand that makes `git worktree` simple";
  meta.homepage = "https://github.com/k1LoW/git-wt";
  meta.license = lib.licenses.mit;
  meta.mainProgram = "git-wt";
  nativeCheckInputs = [ git ];
  vendorHash = "sha256-LkyH7czzBkiyAYGrKuPSeB4pNAZLmgwXgp6fmYBps6s=";
  # keep-sorted end
}
