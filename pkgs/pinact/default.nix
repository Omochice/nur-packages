{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src version;

  vendorHash = "sha256-Ix7C+Xs8Y4LoI06Xb5qVGwoJ+J87wTjYjmQp6aAeFhw=";

  ldflags = [
    "-X main.date=unknown"
    "-X main.commit=unknown"
    "-X main.version=${version}"
  ];

  subPackages = [ "./cmd/pinact" ];

  doCheck = false;

  meta = with lib; {
    description = ''
      pinact is a CLI to edit GitHub Workflow and Composite action files and pin versions of Actions and Reusable Workflows.
      pinact can also update their versions and verify version annotations.
    '';
    homepage = "https://github.com/suzuki-shunsuke/pinact";
    changelog = "https://github.com/suzuki-shunsuke/pinact/releases/tag/v${version}";
    license = licenses.mit;
  };
}
