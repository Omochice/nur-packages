{
  source,
  lib,
  buildGo124Module,
}:

buildGo124Module rec {
  inherit (source) pname src version;

  vendorHash = "sha256-oOAO+lTdcZYC+XeYQG+Ny+H1F2b9D+r/LDQTaQ9ruhw=";

  ldflags = [
    "-X github.com/timo-reymann/gitlab-ci-verify/internal/buildinfo.BuildTime=unknown"
    "-X github.com/timo-reymann/gitlab-ci-verify/internal/buildinfo.GitSha=unknown"
    "-X github.com/timo-reymann/gitlab-ci-verify/internal/buildinfo.Version=${version}"
  ];

  env.CGO_ENABLED = 0;

  doCheck = false;

  meta = with lib; {
    description = ''
      Validate and lint your gitlab ci files using ShellCheck, the Gitlab API, curated checks or even build your own checks
    '';
    homepage = "https://github.com/timo-reymann/gitlab-ci-verify";
    changelog = "https://github.com/timo-reymann/gitlab-ci-verify/releases/tag/v${version}";
    license = licenses.gpl3Plus;
    mainProgram = "gitlab-ci-verify";
  };
}
