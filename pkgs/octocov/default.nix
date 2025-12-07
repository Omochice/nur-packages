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
    "-X github.com/k1LoW/octocov.version=${version}"
    "-X github.com/k1LoW/octocov.commit=unknown"
    "-X github.com/k1LoW/octocov.date=unknown"
    "-X github.com/k1LoW/octocov/version.version=${version}"
  ];
  meta = with lib; {
    description = ''
      octocov is a toolkit for collecting code metrics (code coverage, code to test ratio, test execution time and your own custom metrics).
    '';
    homepage = "https://github.com/k1LoW/octocov";
    changelog = "https://github.com/k1LoW/octocov/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "octocov";
  };
  vendorHash = "sha256-PSLPmtqpYoj0UAH3FdeT5jpb2R1jajWfOUKkZWZpUcY=";
  # keep-sorted end
}
