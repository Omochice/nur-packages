{
  source,
  lib,
  buildGoLatestModule,
}:

buildGoLatestModule rec {
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
    description = ''
      pinact is a CLI to edit GitHub Workflow and Composite action files and pin versions of Actions and Reusable Workflows.
      pinact can also update their versions and verify version annotations.
    '';
    homepage = "https://github.com/suzuki-shunsuke/pinact";
    changelog = "https://github.com/suzuki-shunsuke/pinact/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "pinact";
  };
  subPackages = [ "./cmd/pinact" ];
  vendorHash = "sha256-vL2bv9m8PDCe42T0rLuwDkpaKSPGTDWrnVVOC03/nRA=";
  # keep-sorted end
}
