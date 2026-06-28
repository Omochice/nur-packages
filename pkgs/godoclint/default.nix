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
    "-s"
    "-w"
  ];
  meta.changelog = "https://github.com/godoc-lint/godoc-lint/releases/tag/${version}";
  meta.description = "A linter for Go documentation practice (aka \"Go Doc Comments\" or \"godoc\")";
  meta.homepage = "https://github.com/godoc-lint/godoc-lint";
  meta.license = lib.licenses.mit;
  meta.mainProgram = "godoclint";
  subPackages = [ "./cmd/godoclint" ];
  vendorHash = "sha256-uU4zd5y/xaAfVdKtY3BNhFR90m9UQZRu8SNqkwIpKcE=";
  # keep-sorted end
}
