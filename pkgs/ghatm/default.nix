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
    "-X main.date=unknown"
    "-X main.commit=unknown"
    "-X main.version=${version}"
  ];
  meta = with lib; {
    description = "Set timeout-minutes to all GitHub Actions jobs";
    homepage = "https://github.com/suzuki-shunsuke/ghatm";
    changelog = "https://github.com/suzuki-shunsuke/ghatm/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "ghatm";
  };
  subPackages = [ "./cmd/ghatm" ];
  vendorHash = "sha256-M0FOwsyXgNr05uofTZN6XcoWU/xaGVPE4ncyzddTKEI=";
  # keep-sorted end
}
