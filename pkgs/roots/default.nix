{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src version;

  vendorHash = "sha256-80X5ZmHrpi32aKplbqtX6E9DQs/8gzIQkm6BC4I8/Bw=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/k1LoW/roots.version=${version}"
    "-X github.com/k1LoW/roots.commit=${builtins.readFile "${src}/.git/shallow"}"
    "-X github.com/k1LoW/roots.date=unknown"
    "-X github.com/k1LoW/roots/version.version=${version}"
  ];

  env.CGO_ENABLED = 0;

  meta = with lib; {
    description = ''
      `roots` is a tool for exploring multiple root directories, such as those in a monorepo project.
    '';
    homepage = "https://github.com/k1LoW/roots";
    changelog = "https://github.com/k1LoW/roots/releases/tag/${version}";
    license = licenses.mit;
    mainProgram = "roots";
  };
}
