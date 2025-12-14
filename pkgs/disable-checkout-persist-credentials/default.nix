{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src version;

  vendorHash = "sha256-7Ukbx4OZ2uBR3/iNHThw5jQWTmJJsn+LK5mF+0BUfFs=";

  ldflags = [
    "-X main.date=unknown"
    "-X main.commit=unknown"
    "-X main.version=${version}"
  ];

  env.CGO_ENABLED = 0;

  subPackages = [ "./cmd/disable-checkout-persist-credentials" ];

  doCheck = false;

  meta = with lib; {
    description = "CLI to disable actions/checkout's persist-credentials";
    homepage = "https://github.com/suzuki-shunsuke/disable-checkout-persist-credentials";
    changelog = "https://github.com/suzuki-shunsuke/disable-checkout-persist-credentials/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "disable-checkout-persist-credentials";
  };
}
