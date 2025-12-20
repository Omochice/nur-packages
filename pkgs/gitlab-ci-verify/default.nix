{
  source,
  lib,
  buildGoModule,
}:
let
  # Needs write access, but /homeless-shelter is read-only
  skippedTests = [
    # keep-sorted start
    "TestExists"
    "TestOpenFile/binary_data"
    "TestOpenFile/empty_file"
    "TestOpenFile/simple_read"
    "TestReadRemoteOrCached"
    "TestWriteAndReadFile/binary_data"
    "TestWriteAndReadFile/empty_file"
    "TestWriteAndReadFile/simple_write"
    # keep-sorted end
  ];
in
buildGoModule rec {
  inherit (source) pname src version;
  # keep-sorted start block=yes
  checkFlags = [ "-skip=^${builtins.concatStringsSep "$|^" skippedTests}$" ];
  env.CGO_ENABLED = 0;
  ldflags = [
    "-X github.com/timo-reymann/gitlab-ci-verify/internal/buildinfo.BuildTime=unknown"
    "-X github.com/timo-reymann/gitlab-ci-verify/internal/buildinfo.GitSha=unknown"
    "-X github.com/timo-reymann/gitlab-ci-verify/internal/buildinfo.Version=${version}"
  ];
  meta = with lib; {
    description = ''
      Validate and lint your gitlab ci files using ShellCheck, the Gitlab API, curated checks or even build your own checks
    '';
    homepage = "https://github.com/timo-reymann/gitlab-ci-verify";
    changelog = "https://github.com/timo-reymann/gitlab-ci-verify/releases/tag/v${version}";
    license = licenses.gpl3Plus;
    mainProgram = "gitlab-ci-verify";
  };
  vendorHash = "sha256-jO5U+coKOitil98sfo6+UlKYjDPcoinctUdIzTYh0Ls=";
  # keep-sorted end
}
