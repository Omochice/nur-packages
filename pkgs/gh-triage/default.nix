{
  source,
  lib,
  buildGoModule,
}:
buildGoModule rec {
  inherit (source) pname src version;
  # keep-sorted start block=yes
  doCheck = true;
  env.CGO_ENABLED = 0;
  ldflags = [
    "-s"
    "-w"
    "-X github.com/k1LoW/gh-triage.commit=unknown"
    "-X github.com/k1LoW/gh-triage.date=unknown"
  ];
  meta = {
    # keep-sorted start block=yes
    changelog = "https://github.com/k1LoW/gh-triage/releases/tag/${version}";
    description = "`gh-triage` is a tool that helps you manage and triage GitHub issues and pull requests through unread notifications.";
    homepage = "https://github.com/k1LoW/gh-triage";
    license = lib.licenses.mit;
    mainProgram = "gh-triage";
    # keep-sorted end
  };
  vendorHash = "sha256-4rcgvua3dpV4KrwhHCLuuMSuH8VHPY9Xv51CTgn/vWw=";
  # keep-sorted end
}
