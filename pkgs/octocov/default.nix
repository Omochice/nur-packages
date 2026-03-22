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
    "-X github.com/k1LoW/octocov.version=${version}"
    "-X github.com/k1LoW/octocov.commit=unknown"
    "-X github.com/k1LoW/octocov.date=unknown"
    "-X github.com/k1LoW/octocov/version.version=${version}"
  ];
  meta.changelog = "https://github.com/k1LoW/octocov/releases/tag/v${version}";
  meta.description = "octocov is a toolkit for collecting code metrics (code coverage, code to test ratio, test execution time and your own custom metrics).";
  meta.homepage = "https://github.com/k1LoW/octocov";
  meta.license = lib.licenses.mit;
  meta.mainProgram = "octocov";
  vendorHash = "sha256-Bb7F75L6qg0WEqoVUUHcZi6RXTT2nB7rc9RfKsluZBg=";
  # keep-sorted end
}
