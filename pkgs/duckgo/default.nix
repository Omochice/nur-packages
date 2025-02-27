{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src version;

  vendorHash = "sha256-njoBUoc4nB8q54lEPHvugM8CCHYwB0sklg0x8lyKK7Y=";

  ldflags = [
    "-X main.appRevision=unknown"
    "-X main.appVersion=${version}"
  ];

  CGO_ENABLED = 0;

  doCheck = false;

  meta = with lib; {
    description = "A command line DuckDuckGo client with fuzzyfinder UI written in Go";
    homepage = "https://github.com/sheepla/duckgo";
    changelog = "https://github.com/sheepla/duckgo/releases/tag/v${version}";
    license = licenses.mit;
  };
}
