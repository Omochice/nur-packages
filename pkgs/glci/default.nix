{
  source,
  lib,
  buildGoModule,
}:

buildGoModule {
  inherit (source) pname src version;
  # keep-sorted start block=yes
  env.CGO_ENABLED = 0;
  # Upstream stamps the commit SHA here, which glci resolves its runner image
  # by. nvfetcher records the tag rather than the SHA, but CI promotes the
  # release image under the tag as well, so the tag reaches the same image
  ldflags = [
    "-X gitlab.com/gitlab-org/ci-cd/runner-tools/glci/pkg/version.Commit=${source.version}"
  ];
  meta = with lib; {
    description = "Run GitLab CI/CD pipelines locally";
    homepage = "https://gitlab.com/gitlab-org/ci-cd/runner-tools/glci";
    changelog = "https://gitlab.com/gitlab-org/ci-cd/runner-tools/glci/-/releases/${source.version}";
    license = licenses.mit;
    mainProgram = "glci";
  };
  # The pages tests create their project storage under $HOME, which is the
  # read-only /homeless-shelter during the build
  preCheck = "export HOME=$(mktemp -d)";
  subPackages = [ "cmd/glci" ];
  vendorHash = "sha256-XOpUoZGQy6eZxHIfi52Bfpwg5GKj0DUSPDG+vx02Hs4=";
  # keep-sorted end
}
