{
  lib,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  pname = "pinact";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "pinact";
    rev = "v${version}";
    sha256 = "sha256-WBKe398W9NXwZwiK6P5SDay45bFGkOf1+cmGlS+fWRc=";
  };

  vendorHash = "sha256-Ix7C+Xs8Y4LoI06Xb5qVGwoJ+J87wTjYjmQp6aAeFhw=";

  ldflags = [
    "-X main.date=unknown"
    "-X main.commit=unknown"
    "-X main.version=v${version}"
  ];

  subPackages = [ "./cmd/pinact" ];

  doCheck = false;

  meta = with lib; {
    description = "pinact is a CLI to edit GitHub Workflow and Composite action files and pin versions of Actions and Reusable Workflows. pinact can also update their versions and verify version annotations.";
    homepage = "https://github.com/suzuki-shunsuke/pinact";
    changelog = "https://github.com/suzuki-shunsuke/pinact/releases/tag/v${version}";
    license = licenses.mit;
  };
}
