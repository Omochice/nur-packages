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
    "-X github.com/azu/dockerfile-pin/cmd.version=${version}"
  ];
  meta = with lib; {
    description = "A CLI tool that pins Dockerfile, Docker Compose, and GitHub Actions images to sha256 digests to prevent supply chain attacks.";
    homepage = "https://github.com/azu/dockerfile-pin";
    changelog = "https://github.com/azu/dockerfile-pin/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "dockerfile-pin";
  };
  subPackages = [ "." ];
  vendorHash = "sha256-CgMFIYoM+nWiZ5NXtTlXHhrjzVYxoVg0YVpQq3LLrjI=";
  # keep-sorted end
}
