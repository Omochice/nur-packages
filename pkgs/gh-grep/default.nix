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
    "-X github.com/k1LoW/gh-grep.version=${version}"
    "-X github.com/k1LoW/gh-grep.commit=${builtins.readFile "${src}/.git/shallow"}"
    "-X github.com/k1LoW/gh-grep.date=unknown"
    "-X github.com/k1LoW/gh-grep/version.Version=${version}"
  ];
  meta = with lib; {
    description = "Print lines matching a pattern in repositories using GitHub API";
    homepage = "https://github.com/k1LoW/gh-grep";
    changelog = "https://github.com/k1LoW/gh-grep/releases/tag/${version}";
    license = licenses.mit;
    mainProgram = "gh-grep";
  };
  vendorHash = "sha256-XEG5fPyDG0tq8WnBhveaIpm0sYAQddf503lyASH6+CI=";
  # keep-sorted end
}
