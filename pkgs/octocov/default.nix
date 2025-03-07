{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src version;

  vendorHash = "sha256-t3MRveLiewBzRvX2x5H67iUfN1TCT2D8Qg4fmEa6pjc=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/k1LoW/octocov.version=${version}"
    "-X github.com/k1LoW/octocov.commit=unknown"
    "-X github.com/k1LoW/octocov.date=unknown"
    "-X github.com/k1LoW/octocov/version.version=${version}"
  ];

  env.CGO_ENABLED = 0;

  doCheck = false;

  meta = with lib; {
    description = ''
      octocov is a toolkit for collecting code metrics (code coverage, code to test ratio, test execution time and your own custom metrics).
    '';
    homepage = "https://github.com/k1LoW/octocov";
    changelog = "https://github.com/k1LoW/octocov/releases/tag/v${version}";
    license = licenses.mit;
  };
}
