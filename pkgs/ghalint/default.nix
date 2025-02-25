{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src version;

  vendorHash = "sha256-ZIF4Y1A8ygrWjr4esrnq9t5OIPwkA9p2B5S4Rc+Js04=";

  ldflags = [
    "-X main.date=unknown"
    "-X main.commit=unknown"
    "-X main.version=${version}"
  ];

  CGO_ENABLED = 0;

  subPackages = [ "./cmd/ghalint" ];

  doCheck = false;

  meta = with lib; {
    description = "GitHub Actions linter";
    homepage = "https://github.com/suzuki-shunsuke/ghalint";
    changelog = "https://github.com/suzuki-shunsuke/ghalint/releases/tag/v${version}";
    license = licenses.mit;
  };
}
