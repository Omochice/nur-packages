{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src version;

  vendorHash = "sha256-GNGrWhswAMP1+v+8uWgG0/k7JPaGc/BHIQebLNRC1J4=";

  ldflags = [
    "-X main.date=unknown"
    "-X main.commit=${builtins.readFile "${src}/.git/shallow"}"
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
