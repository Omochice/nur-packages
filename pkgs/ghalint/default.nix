{
  source,
  lib,
  buildGo126Module,
}:

buildGo126Module rec {
  inherit (source) pname src version;
  # keep-sorted start block=yes
  doCheck = false;
  env.CGO_ENABLED = 0;
  ldflags = [
    "-X main.date=unknown"
    "-X main.commit=unknown"
    "-X main.version=${version}"
  ];
  meta.changelog = "https://github.com/suzuki-shunsuke/ghalint/releases/tag/v${version}";
  meta.description = "GitHub Actions linter";
  meta.homepage = "https://github.com/suzuki-shunsuke/ghalint";
  meta.license = lib.licenses.mit;
  meta.mainProgram = "ghalint";
  subPackages = [ "./cmd/ghalint" ];
  vendorHash = "sha256-n++Rq79KHyRVhIXIdN9IOADTGEG73Wl2SUq/YEo++WM=";
  # keep-sorted end
}
