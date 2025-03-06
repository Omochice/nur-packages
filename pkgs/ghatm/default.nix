{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src version;

  vendorHash = "sha256-13sqf6oCzHaeOtlyU5ZXfKUEb7cZ7wucR59zA6O2BsQ=";

  ldflags = [
    "-X main.date=unknown"
    "-X main.commit=unknown"
    "-X main.version=${version}"
  ];

  subPackages = [ "./cmd/ghatm" ];

  env.CGO_ENABLED = 0;

  doCheck = false;

  meta = with lib; {
    description = "Set timeout-minutes to all GitHub Actions jobs";
    homepage = "https://github.com/suzuki-shunsuke/ghatm";
    changelog = "https://github.com/suzuki-shunsuke/ghatm/releases/tag/v${version}";
    license = licenses.mit;
  };
}
