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
    description = "GitHub Actions linter";
    homepage = "https://github.com/suzuki-shunsuke/ghalint";
    changelog = "https://github.com/suzuki-shunsuke/ghalint/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "ghalint";
  };
  subPackages = [ "./cmd/ghalint" ];
  vendorHash = "sha256-VCv5ZCeUWHld+q7tkHSUyeVagMhSN9893vYHyO/VlAI=";
  # keep-sorted end
}
