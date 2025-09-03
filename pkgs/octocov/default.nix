{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src version;

  vendorHash = "sha256-6biwUn0tZ/FjBEdg6xgtKB4jsY3qqbufCA63EOk+yrM=";

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
    mainProgram = "octocov";
  };
}
