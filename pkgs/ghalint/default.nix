{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src version;

  vendorHash = "sha256-Tsn0GZXbBSE9iLkTzj/RNsm7WszAoDpy4Pzr3n7UM7k=";

  ldflags = [
    "-X main.date=unknown"
    "-X main.commit=unknown"
    "-X main.version=${version}"
  ];

  env.CGO_ENABLED = 0;

  subPackages = [ "./cmd/ghalint" ];

  doCheck = false;

  meta = with lib; {
    description = "GitHub Actions linter";
    homepage = "https://github.com/suzuki-shunsuke/ghalint";
    changelog = "https://github.com/suzuki-shunsuke/ghalint/releases/tag/v${version}";
    license = licenses.mit;
  };
}
