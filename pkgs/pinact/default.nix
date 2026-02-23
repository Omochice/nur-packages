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
    "-X main.date=unknown"
    "-X main.commit=unknown"
    "-X main.version=${version}"
  ];
  meta.description = ''
    pinact is a CLI to edit GitHub Workflow and Composite action files and pin versions of Actions and Reusable Workflows.
    pinact can also update their versions and verify version annotations.
  '';
  meta.homepage = "https://github.com/suzuki-shunsuke/pinact";
  meta.changelog = "https://github.com/suzuki-shunsuke/pinact/releases/tag/v${version}";
  meta.license = lib.licenses.mit;
  meta.mainProgram = "pinact";
  subPackages = [ "./cmd/pinact" ];
  vendorHash = "sha256-EqfhHy9OUiaoCI/VFjUJlm917un3Lf4/cUmeHG7w9Bg=";
  # keep-sorted end
}
